Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261611AbULFTIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261611AbULFTIg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 14:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261579AbULFTIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 14:08:35 -0500
Received: from sarvega.com ([161.58.151.164]:42769 "EHLO sarvega.com")
	by vger.kernel.org with ESMTP id S261611AbULFTII (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 14:08:08 -0500
Date: Mon, 6 Dec 2004 13:07:43 -0600
From: John Lash <jkl@sarvega.com>
To: "Niel Lambrechts" <antispam@telkomsa.net>
Cc: "'Burton Windle'" <bwindle@fint.org>, <linux-kernel@vger.kernel.org>
Subject: Re: kernel panic after changing processor arch
Message-ID: <20041206130743.6c5f0fd3@homer.sarvega.com>
In-Reply-To: <000101c4dbc5$96844e70$0a00000a@MERCKX>
References: <20041206123705.5fbac5b4@homer.sarvega.com>
	<000101c4dbc5$96844e70$0a00000a@MERCKX>
X-Mailer: Sylpheed-Claws 0.9.12cvs102 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Dec 2004 20:58:33 +0200
"Niel Lambrechts" <antispam@telkomsa.net> wrote:

> > 
> > my first guess would be that the reiserfs module on your 
> > initrd needs to be recompiled using the PENTIUMM arch.....
> > 
> > --john
> 
> No.
> 
> I did:
> make menuconfig - change from i686 to pentiumm - save settings.
> make 
> make install
> mkinitrd -s 1024x768 -k "bzImage.2.6.8-24.5-default" -I "initrd" -m
> "reiserfs"
> lilo
> 
> If I "mount -o loop" the new initrd, modinfo shows the type of
> reiserfs.ko to be "PENTIUMM" as I would expect...
> 
> I have also tried compiling reiserfs support directly into the kernel
> and dropping reiserfs from the -m option, to no avail.
> 
> -Niel
> 

so much for the first guess. try modifying the initrd to pop open an interactive
shell that you can use before it actually fails. You can poke around and see
what's going on. Depending on how it's set up, you might be able to get away
with something this simple in the linuxrc:

	/bin/sh </dev/console >/dev/console 2>/dev/console

If you ramdisk has strace and some other use utilities, it might help you track
down the bad apple.

--john
