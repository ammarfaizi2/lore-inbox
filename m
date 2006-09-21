Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751209AbWIUEL2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbWIUEL2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 00:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbWIUEL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 00:11:28 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:41830 "EHLO
	asav13.insightbb.com") by vger.kernel.org with ESMTP
	id S1751209AbWIUEL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 00:11:27 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aa4HABCsEUWBT4obLA
From: Dmitry Torokhov <dtor@insightbb.com>
To: Robin Getz <rgetz@blackfin.uclinux.org>
Subject: Re: drivers/char/random.c exported interfaces
Date: Thu, 21 Sep 2006 00:11:25 -0400
User-Agent: KMail/1.9.3
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org,
       Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>
References: <6.1.1.1.0.20060920125855.01eca0c0@ptg1.spd.analog.com>
In-Reply-To: <6.1.1.1.0.20060920125855.01eca0c0@ptg1.spd.analog.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609210011.25891.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 20 September 2006 13:04, Robin Getz wrote:
> Randy Dunlap said:
> >ISTM that we should at least fix the first 2 (by EXPORTing them).
> >or we don't allow INPUT=m.
> >
> >You want to send a patch?
> 
> No problem - which patch do you want? (exporting? or set INPUT to bool?)
> 
> I'll send the export later tonight if no objections.
>

Would there be any objections if I commit the patch below so input
could be built as a module? 

-- 
Dmitry

Input: fix building input core as a module

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/char/random.c |    1 +
 lib/kobject.c         |    1 +
 2 files changed, 2 insertions(+)

Index: work/drivers/char/random.c
===================================================================
--- work.orig/drivers/char/random.c
+++ work/drivers/char/random.c
@@ -645,6 +645,7 @@ void add_input_randomness(unsigned int t
 	add_timer_randomness(&input_timer_state,
 			     (type << 4) ^ code ^ (code >> 4) ^ value);
 }
+EXPORT_SYMBOL_GPL(add_input_randomness);
 
 void add_interrupt_randomness(int irq)
 {
Index: work/lib/kobject.c
===================================================================
--- work.orig/lib/kobject.c
+++ work/lib/kobject.c
@@ -119,6 +119,7 @@ char *kobject_get_path(struct kobject *k
 
 	return path;
 }
+EXPORT_SYMBOL_GPL(kobject_get_path);
 
 /**
  *	kobject_init - initialize object.
