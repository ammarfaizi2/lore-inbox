Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290841AbSAaCe6>; Wed, 30 Jan 2002 21:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290839AbSAaCeq>; Wed, 30 Jan 2002 21:34:46 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:44852 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S290838AbSAaCef>; Wed, 30 Jan 2002 21:34:35 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] x86 ELF bootable kernels/Linux booting Linux/LinuxBIOS
In-Reply-To: <m1elk7d37d.fsf@frodo.biederman.org>
	<a39ooh$lb3$1@cesium.transmeta.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 30 Jan 2002 19:31:05 -0700
In-Reply-To: <a39ooh$lb3$1@cesium.transmeta.com>
Message-ID: <m14rl3ckuu.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> Followup to:  <m1elk7d37d.fsf@frodo.biederman.org>
> By author:    ebiederm@xmission.com (Eric W. Biederman)
> In newsgroup: linux.dev.kernel
> > 
> > - Code at that entry point to query from the firmware/BIOS the
> >   information the kernel needs.
> > 
> 
> How do you query from the 16-bit firmware/BIOS at the 32-bit
> entrypoint?  Or is it that you have a table, fixed by protocol, of
> what information is available (so we're basically fucked when
> something needs to change)?

I drop back into real mode.  Run the existing query code, (I had to factor
setup.S but the queries are 100% the same) and then I climb back to
32bit mode.  But I do it from setup_arch() so if I don't have a
pcbios, I can skip all that nasty busyness.

I did it the wrong way (fixed table) initially and after some
conversations with you and some thinking I changed it around.

There is nothing outside the ELF specification that needs to be used.
All I depend on is having flat 32bit code and data segments, initially
loaded in %cs and %ds.  So basically anyones x86 ELF bootloader should
work.

I have defined a fully optional table of tagged elements, so the
bootloader can tell me what kind of firmware I have.  All it passes
besides that is the bootloader name and the bootloader version.  So
you must do the bios queries yourself.

Eric
