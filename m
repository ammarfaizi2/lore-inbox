Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317544AbSHYVKM>; Sun, 25 Aug 2002 17:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317580AbSHYVKM>; Sun, 25 Aug 2002 17:10:12 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31760 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317544AbSHYVKL>;
	Sun, 25 Aug 2002 17:10:11 -0400
Date: Sun, 25 Aug 2002 22:14:27 +0100
From: Matthew Wilcox <willy@debian.org>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] (re)implement setkeycode/getkeycode/kd_mksound/kbd_setrate via the input core
Message-ID: <20020825221427.A6931@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This bit looks wrong to me:

+ for (handle = kbd_handler.handle; handle; handle = handle->hnext)
+ if (handle->dev->keycodesize) break;
+
+ if (!handle->dev->keycodesize)
+ return -ENODEV;

if we reach termination for the loop without finding a keycodesize, handle
will be NULL, so you'd get an oops.  Just do:

+ if (!handle)
+ return -ENODEV

(sorry about the formatting, i'm reading l-k via uwsg's web archive).

-- 
Revolutions do not require corporate support.
