Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263972AbUEHAch@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263972AbUEHAch (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 20:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263923AbUEHAcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 20:32:36 -0400
Received: from mail1.fw-sj.sony.com ([160.33.82.68]:63362 "EHLO
	mail1.fw-sj.sony.com") by vger.kernel.org with ESMTP
	id S263972AbUEHAb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 20:31:26 -0400
Message-ID: <409C2CBA.8040709@am.sony.com>
Date: Fri, 07 May 2004 17:41:30 -0700
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: get_cmos_time() takes up to a second on boot
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In Linux 2.4.20, the routine get_cmos_time() in
arch/i386/kernel/time.c takes up to a second to run
during a boot on an x86 desktop.

It looks like this is because of the first 'for' loop where
it synchronizes with the edge of the RTC clock (and where
the comment reads "may take up to 1 second...")

In Linux 2.6.5, this same code appears in
mach_get_cmos_time() in
include/asm-i386/mach-default/mach_time.c
(but I haven't measured it on 2.6.5 yet).

What is the downside of disabling this
synchronization with the clock edge?

1 second of variability is unnacceptable
when you're requirement is to boot in
.5 seconds.  :)

Would it be bad to disable this synchronization
completely?  How about just during boot?

=============================
Tim Bird
Chair, Bootup Time Working Group, CE Linux Forum
Senior Staff Engineer, Sony Electronics
=============================

