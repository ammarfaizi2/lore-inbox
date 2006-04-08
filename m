Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751431AbWDHVGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751431AbWDHVGE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 17:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751432AbWDHVGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 17:06:04 -0400
Received: from hera.cwi.nl ([192.16.191.8]:15306 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S1751431AbWDHVGD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 17:06:03 -0400
Date: Sat, 8 Apr 2006 23:06:01 +0200 (MEST)
From: <Andries.Brouwer@cwi.nl>
Message-Id: <200604082106.k38L61j25619@apps.cwi.nl>
To: linux-kernel@vger.kernel.org
Subject: strlen_user and keys
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[faraway from home, not near recent kernel source]

strnlen_user() is documented as returning the string length including
terminating NUL. Probably that was a bad idea - people expect that
if user space and kernel library functions have similar names, they do
similar things. The shouting "INCLUDING" in the description already
shows that also the author expected that bugs would be created by
using this name.

[see, e.g., arch/i386/lib/usercopy.c]

security/keys/keyctl.c does

        dlen = strnlen_user(_description, PAGE_SIZE - 1);
	description = kmalloc(dlen + 1, GFP_KERNEL);
	copy_from_user(description, _description, dlen + 1);

copying one byte too many.
(Thus in some unknown kernel source tree, maybe 2.6.14.
This may have been fixed already.)

Andries
