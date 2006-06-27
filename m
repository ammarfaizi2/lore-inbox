Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932554AbWF0TwE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932554AbWF0TwE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 15:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932555AbWF0TwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 15:52:04 -0400
Received: from mail.gmx.net ([213.165.64.21]:65427 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932554AbWF0TwD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 15:52:03 -0400
X-Authenticated: #420190
Message-ID: <44A18C38.7040504@gmx.net>
Date: Tue, 27 Jun 2006 21:51:20 +0200
From: Marko Macek <Marko.Macek@gmx.net>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: vojtech@suse.cz, thoffman@arnor.net
CC: vanackere@lif.univ-mrs.fr, linux-kernel@vger.kernel.org
Subject: USB input ati_remote autorepeat problem
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I have problems with autorepeat in ati_remote (drivers/usb/input) driver 
in "recent" kernels: all keys start repeating immediately without some 
delay.

This makes some things, like changing the channel prev/next or toggling 
fullscreen, etc... impossible/hard.

The problem seems to be related to FILTER_TIME and HZ=250 (which I 
forgot to change).

FILTER_TIME is defined to HZ / 20, and since 250 is not divisible by 20, 
the time will be too short to ignore enough events.

Defining FILTER_TIME to HZ / 20 + 1 seems to fix things, but I'm not 
sure if there are any bad side effects.

    Mark
