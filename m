Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262061AbUBWXMY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 18:12:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262096AbUBWXMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 18:12:23 -0500
Received: from mail.convergence.de ([212.84.236.4]:23427 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S262061AbUBWXLk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 18:11:40 -0500
Message-ID: <403A889F.6080406@convergence.de>
Date: Tue, 24 Feb 2004 00:11:27 +0100
From: Michael Hunold <hunold@convergence.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Michael Hunold <hunold@linuxtv.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Compilation fix for latest DVB updates (was Re: x86_64 build failure)
References: <20040223143728.77a76d84.akpm@osdl.org>
In-Reply-To: <20040223143728.77a76d84.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------080509080002010105020804"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080509080002010105020804
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

On 02/23/04 23:37, Andrew Morton wrote:

> drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c:32:28: dvb_usb_compat.h: No such file or directory

Rats. My latest test kernel configuration had USB disabled for some 
unknown reason, so the dvb-ttusb-budget and dvb-ttusb-dec drivers were 
not compiled at all.

I attached a quick fix: simply remove the offending line of code, it's 
from our 2.4 USB compatibility layer.

I CCed LKML so others get to know this patch, too.

CU
Michael.

--------------080509080002010105020804
Content-Type: text/plain;
 name="dvb-ttusb-budget-compile-fix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dvb-ttusb-budget-compile-fix.diff"

diff -ura linux-2.6.3/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c linux-2.6.3-hf/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c
--- linux-2.6.3/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c	2004-02-24 00:06:29.000000000 +0100
+++ linux-2.6.3-hf/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c	2004-02-24 00:07:26.000000000 +0100
@@ -29,7 +29,6 @@
 #include <linux/dvb/dmx.h>
 #include <linux/pci.h>
 
-#include "dvb_usb_compat.h"
 #include "dvb_functions.h"
 
 /*

--------------080509080002010105020804--
