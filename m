Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285915AbRLHLeN>; Sat, 8 Dec 2001 06:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285920AbRLHLeE>; Sat, 8 Dec 2001 06:34:04 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:49925 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S285915AbRLHLdy>; Sat, 8 Dec 2001 06:33:54 -0500
Subject: Re: On re-working the major/minor system
To: hpa@zytor.com (H. Peter Anvin)
Date: Sat, 8 Dec 2001 11:42:48 +0000 (GMT)
Cc: andersen@codepoet.org, linux-kernel@vger.kernel.org
In-Reply-To: <3C114CFB.50403@zytor.com> from "H. Peter Anvin" at Dec 07, 2001 03:12:59 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16CfsW-0001AL-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > That works, and should prevent most major problems.  Hmm.  At
> > least for cpio there are 6 chars worth of device info in there,
> > so we coule easily go to 48 bits without RPM problems.  Or redhat
> > could fix rpm to use tarballs like debs do, and then we could go

RPM can't easily use tarballs. Too much of a tar ball isnt rigidly defined so
you can cryptographically sign it.

> > to 64 bit devices no problem.
> 
> The big stubling block seems to be NFSv2.

Well 2.5 isnt going to be able to support NFS without a magic daemon
maintained translation table - so that when the kernel randomly changes the
major/minor number of an exported file system (eg a USB reconnect or even plain
boring shutdown/reboot) it can keep consistent file handles.

If you have a file handle table surely you can remap every NFS file handle
through that down to 32bits. For device files the problem doesn't matter 
because at the kernel meeting Linus said those were going to change in a way
that meant devices over NFS are a lost cause and clients would have to use
devfs

Alan


