Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261300AbVBDRjS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbVBDRjS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 12:39:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266006AbVBDRgC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 12:36:02 -0500
Received: from rproxy.gmail.com ([64.233.170.197]:17116 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S265201AbVBDRb7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 12:31:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=ECLobeMEMKuX2Ijjddauao8ru7f5bsy4TlmKm/gDL+TdclmfzCsHkosJnCP080wx73TAp+Sx9wUgy6nhHCz+38BXg9ETrIiAE2Gm0DcJh1SXyzr7+PqkIr4yk3vXnLbz3dVJ5ExYsPO9qbBFfL3SEfM5Nd/XB+VPpsb+ixPY1uY=
Message-ID: <9e4733910502040931955f5a6@mail.gmail.com>
Date: Fri, 4 Feb 2005 12:31:55 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC] Reliable video POSTing on resume
Cc: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
       ncunningham@linuxmail.org, ACPI List <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Matthew Garrett <mjg59@srcf.ucam.org>
In-Reply-To: <20050204163019.GC1290@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050122134205.GA9354@wsc-gmbh.de>
	 <e796392205020221387d4d8562@mail.gmail.com> <420217DB.709@gmx.net>
	 <4202A972.1070003@gmx.net> <20050203225410.GB1110@elf.ucw.cz>
	 <1107474198.5727.9.camel@desktop.cunninghams>
	 <4202DF7B.2000506@gmx.net> <9e47339105020321031ccaabb@mail.gmail.com>
	 <420367CF.7060206@gmx.net> <20050204163019.GC1290@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Feb 2005 17:30:19 +0100, Pavel Machek <pavel@ucw.cz> wrote:
> I do not understand how initramfs fits into picture... Plus lot of
> people (me :-) do not use initramfs...

The final fix for this will include the video reset app on initramfs.
I already have code in the kernel for telling the primary video card
from secondary ones. When the kernel is initially booting and finds
the secondary cards it will do a call_usermodehelper() and execute the
video reset app. This happens very early in the boot sequence so it
needs to be on initramfs. There are also a few embedded type systems
that don't even post their primary video hardware they need this
support too.

For non-x86 systems put an emu version on initramfs. My statically
linked against klibc x86 reset app is about 15K. The emu version is
significantly bigger but there is no way to avoid it if you are using
x86 hardware in a non-x86 box.

Fixing this at kernel boot (resume) time will let user space apps
assume that all video cards are reset. That removes a lot of
complexity from the user space apps (like X).

-- 
Jon Smirl
jonsmirl@gmail.com
