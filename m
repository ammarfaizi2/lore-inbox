Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030365AbWATB3S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030365AbWATB3S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 20:29:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030456AbWATB3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 20:29:18 -0500
Received: from mx1.redhat.com ([66.187.233.31]:3792 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030365AbWATB3R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 20:29:17 -0500
Date: Thu, 19 Jan 2006 20:28:44 -0500
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: AChittenden@bluearc.com, linux-kernel@vger.kernel.org, lwoodman@redhat.com
Subject: Re: Out of Memory: Killed process 16498 (java).
Message-ID: <20060120012844.GE3798@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, AChittenden@bluearc.com,
	linux-kernel@vger.kernel.org, lwoodman@redhat.com
References: <89E85E0168AD994693B574C80EDB9C270355601F@uk-email.terastack.bluearc.com> <20060119194836.GM21663@redhat.com> <20060119170305.2e8ae353.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060119170305.2e8ae353.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2006 at 05:03:05PM -0800, Andrew Morton wrote:
 > This is the bypass-the-batching patch.  It's a reasonable thing to do, but I'd
 > just do it unconditionally and remove the code which clears
 > ->all_unreclaimable from free_pages_bulk(), if possible.
 > 
 > Has this patch been shown to have any effect?  If so, what was it, and
 > under what conditions?

Larry originally came up with the patch for our RHEL4 2.6.9 kernel,
after customers were hitting OOM under some heavy workload he can
probably recall better than I can.

iirc it didn't solve the users OOM entirely, but it does make their workload
run longer before the kill happens.

A little while later, after Fedora users started reporting oom kills,
I forward-ported it to 2.6.14, and threw it out in an update.
The Fedora user in the bug report
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=175173
who on x86-64 with 5GB saw zone_dma exhausted saw a similar result,
delays the kill, but it does still happen.

Hmm.

		Dave
