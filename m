Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751121AbVKJAbI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbVKJAbI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 19:31:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbVKJAbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 19:31:08 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:29448 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751121AbVKJAbG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 19:31:06 -0500
Date: Wed, 9 Nov 2005 16:31:01 -0800
Message-Id: <200511100031.jAA0V1HP027702@zach-dev.vmware.com>
Subject: [PATCH 0/10] I386 BIOS and cpu fixes / cleanups
From: Zachary Amsden <zach@vmware.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 10 Nov 2005 00:31:05.0653 (UTC) FILETIME=[09724E50:01C5E58E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The harmless portion of my current i386 cleanups, including one very
nice bugfix to protect the kernel from rampant trampling by the PnP
BIOS.  The problem was the PnP transfer segments were protected in
page increments, not byte increments, so a broken BIOS could overstep
the bounds the PnP code was trying to enforce.  Turns out I had such
a broken BIOS, and discovered a common PnP bug is to use word access
(2 bytes) to get and set device IDs, which are supposed to be 1-byte.

Rather than let the BIOS trample memory, I added a workaround to
copy data to and from a temporary value, which allows the BIOS to
smash the high byte safely.

The rest of these are (hopefully) obviously correct, nice transforms
or removal of dead code.

Zachary Amsden <zach@vmware.com>
