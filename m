Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275001AbTHLCYt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 22:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275002AbTHLCYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 22:24:49 -0400
Received: from hera.cwi.nl ([192.16.191.8]:36051 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S275001AbTHLCYr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 22:24:47 -0400
From: Andries.Brouwer@cwi.nl
Date: Tue, 12 Aug 2003 04:24:30 +0200 (MEST)
Message-Id: <UTC200308120224.h7C2OUg18189.aeb@smtp.cwi.nl>
To: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [retry] deadlock (and mailer error)
Cc: akpm@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(1) Deadlock

A few hours ago I wrote:

---
Now that I mentioned that inserting usb-storage hangs forever
and then causes a SCSI oops, the question arises how the hang
is caused. It turns out to be a semaphore deadlock.

What happens is that base/bus.c:bus_add_driver() downs
        down_write(&bus->subsys.rwsem);
and then later usb/core/hub.c:usb_reset_device() downs
        down_read(&gdev->bus->subsys.rwsem);

This is the same semaphore, and we have a deadlock.
---


(2) Mailer error

but vger didnt like this letter (?) and confusingly answered

---
The following addresses had permanent fatal errors
<linux-kernel@vger.kernel.org>

... while talking to vger.kernel.org.:
>>> MAIL From:<aeb@hera.cwi.nl.> SIZE=463
<<< 501-5.1.7 For input: <aeb@hera.cwi.nl.> SIZE=463
<<< 501 5.1.7 Path data: Spurious dot (.) at the end of the domain name
501 <linux-kernel@vger.kernel.org>... Data format error
<aeb@smtp.cwi.nl>... Deferred: Connection refused by hera.cwi.nl.
---

Andries
