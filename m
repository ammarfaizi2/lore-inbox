Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261787AbUDSTsh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 15:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbUDSTsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 15:48:37 -0400
Received: from msgdirector3.onetel.net.uk ([212.67.96.159]:32570 "EHLO
	msgdirector3.onetel.net.uk") by vger.kernel.org with ESMTP
	id S261787AbUDSTse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 15:48:34 -0400
From: Chris Lingard <chris@ukpost.com>
To: "Bryan O'Sullivan" <bos@serpentine.com>
Subject: Re: initramfs howto?
Date: Mon, 19 Apr 2004 20:48:29 +0100
User-Agent: KMail/1.5.2
References: <1081451826.238.23.camel@clubneon.priv.hereintown.net> <buo4qrt4pga.fsf@mcspd15.ucom.lsi.nec.co.jp> <1081531299.19918.13.camel@serpentine.pathscale.com>
In-Reply-To: <1081531299.19918.13.camel@serpentine.pathscale.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404192048.29666.chris@ukpost.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 09 April 2004 6:21 pm, Bryan O'Sullivan wrote:
> On Thu, 2004-04-08 at 23:48, Miles Bader wrote:

> I'm agnostic.  It's a two-line patch.  I don't care if it's called
> /spam/fandango/wubble, so long as the brave souls who are trying out
> initramfs don't keep stumbling over the same problem again and again :-)

May I suggest

diff -Naur linux-2.6.5.old/init/main.c linux-2.6.5/init/main.c
--- linux-2.6.5.old/init/main.c 2004-04-05 18:19:04.000000000 +0100
+++ linux-2.6.5/init/main.c     2004-04-18 15:37:56.000000000 +0100
@@ -604,7 +604,12 @@
        smp_init();
        do_basic_setup();

-       prepare_namespace();
+       /*
+       * check if there is an early userspace init, if yes
+       * let it do all the work
+       */
+       if ( ! sys_access("/linuxrc", 0) == 0)
+               prepare_namespace();

        /*
         * Ok, we have completed the initial bootup, and

linuxrc already exists for initrd systems, and is coded in anyway.

I have tested this with both with both linuxrc -> bin/ash
and with a script that brings up a full system.  (I have made
a boot CD that installs Linux-2.6.5 with udev)

Chris Lingard
