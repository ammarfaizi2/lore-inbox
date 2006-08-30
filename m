Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750744AbWH3JGy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbWH3JGy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 05:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750745AbWH3JGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 05:06:54 -0400
Received: from liaag2ag.mx.compuserve.com ([149.174.40.158]:14002 "EHLO
	liaag2ag.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1750744AbWH3JGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 05:06:53 -0400
Date: Wed, 30 Aug 2006 05:00:33 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [PATCH RFC 0/6] Implement per-processor data areas for i386.
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Jan Beulich <jbeulich@novell.com>, Zachary Amsden <zach@vmware.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200608300503_MC3-1-C9C4-92F7@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060827084417.918992193@goop.org>

On Sun, 27 Aug 2006 01:44:17 -0700, Jeremy Fitzhardinge wrote:

> This patch implements per-processor data areas by using %gs as the
> base segment of the per-processor memory.

This changes the ABI for signals and ptrace() and that seems like
a bad idea to me.

And the way things are done now is so ingrained into the i386
kernel that I'm not sure it can be done.  E.g. I found two
open-coded implementations of current, one in kernel_fpu_begin()
and one in math_state_restore().

> - It also allows per-CPU data to be allocated as each CPU is brought
>   up, rather than statically allocating it based on the maximum number
>   of CPUs which could be brought up.

Can you describe what it is about the way things work now that
prevents dynamic allocation?

-- 
Chuck
