Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932338AbWE3RBE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338AbWE3RBE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 13:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932335AbWE3RBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 13:01:04 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:22977 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S932332AbWE3RBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 13:01:02 -0400
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: Possible kernel memory leaks
References: <44797BEF.70206@gmail.com>
From: Catalin Marinas <catalin.marinas@arm.com>
Date: Tue, 30 May 2006 18:00:55 +0100
In-Reply-To: <44797BEF.70206@gmail.com> (Catalin Marinas's message of "Sun,
 28 May 2006 11:31:11 +0100")
Message-ID: <tnxvernwipk.fsf@arm.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 30 May 2006 17:00:59.0011 (UTC) FILETIME=[9FAD4530:01C6840A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Catalin Marinas <catalin.marinas@gmail.com> wrote:
> - acpi_evaluate_integer in drivers/acpi/utils.c - "element" is not freed
> on the error path (if Coverity hasn't seen this, it was probably
> confused by the return_* macros)

This is simpler. I'll send a separate patch for it.

> - acpi_ev_execute_reg_method in drivers/acpi/events/evregion.c - I'm not
> sure about this but kmemleak reports an orphan pointer on the following
> allocation path:
>   c0159372: <kmem_cache_alloc>
>   c01ffa07: <acpi_os_acquire_object>
>   c0215b3a: <acpi_ut_allocate_object_desc_dbg>
>   c02159ce: <acpi_ut_create_internal_object_dbg>
>   c0203784: <acpi_ev_execute_reg_method>
>   c0203db4: <acpi_ev_reg_run>
>   c020ed17: <acpi_ns_walk_namespace>
>   c0203d6b: <acpi_ev_execute_reg_methods>
> Is acpi_ut_remove_reference actually removing the params[0/1]?

I'll need to enable the ACPI debug output as I can't find the leak by
only looking at the code. I'll let you know if there is a leak.

-- 
Catalin
