Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267734AbUHaKhs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267734AbUHaKhs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 06:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267759AbUHaKhs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 06:37:48 -0400
Received: from launch.server101.com ([216.218.196.178]:7072 "EHLO
	mail-pop3-1.server101.com") by vger.kernel.org with ESMTP
	id S267734AbUHaKhj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 06:37:39 -0400
From: Tim Fairchild <tim@bcs4me.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: K3b and 2.6.9?
Date: Tue, 31 Aug 2004 20:37:00 +1000
User-Agent: KMail/1.6.1
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200408301047.06780.tim@bcs4me.com> <200408311151.25854.tim@bcs4me.com> <Pine.LNX.4.58.0408301917360.2295@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0408301917360.2295@ppc970.osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408312037.00994.tim@bcs4me.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 31 Aug 2004 12:29, Linus Torvalds wrote:

> Ehh.. This seems to imply that K3b opens the device for _reading_ when it
> wants to burn a CD-ROM. It also implies that K3b only uses the commands
> that are already marked as being "safe for writing", so the kernel command
> list is apparently fine.

On starting k3b seems to use 'safe for reading' commands and 'safe for 
writing' command 0x55 (mode_select?) to test the drive function. file->f_mode 
is returning with 0x0d during 'safe for writing' command.

growisofs also is returning file->f_mode as 0x0d with any 'safe for writing' 
command if I disable the line and allow k3b to run and burn dvd and just 
printk the cmd and file->f_mode values ... 

I believe FMODE_WRITE is 0x02  tho don't know where that is defined... If this 
bit not set does it mean the device is opened for reading? during a burn? 
Sorry, I'm very new to this... but do notice that cdrecord returnes 0x0f 
which does have the bit set correctly...

tim
