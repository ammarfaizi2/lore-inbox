Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262837AbUGMCzK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262837AbUGMCzK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 22:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262450AbUGMCzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 22:55:10 -0400
Received: from holomorphy.com ([207.189.100.168]:42386 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262837AbUGMCzF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 22:55:05 -0400
Date: Mon, 12 Jul 2004 19:55:02 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Gabriel Devenyi <devenyga@mcmaster.ca>
Cc: ck@vds.kolivas.org, linux-kernel@vger.kernel.org
Subject: Re: [ck] Re: Preempt Threshold Measurements
Message-ID: <20040713025502.GR21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Gabriel Devenyi <devenyga@mcmaster.ca>, ck@vds.kolivas.org,
	linux-kernel@vger.kernel.org
References: <200407121943.25196.devenyga@mcmaster.ca> <20040713024051.GQ21066@holomorphy.com> <200407122248.50377.devenyga@mcmaster.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407122248.50377.devenyga@mcmaster.ca>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2004 at 10:48:50PM -0400, Gabriel Devenyi wrote:
> Well I'm not particularly educated in kernel internals yet, here's some 
> reports from the system when its running.
> 6ms non-preemptible critical section violated 4 ms preempt threshold starting 
> at do_munmap+0xd2/0x140 and ending at do_munmap+0xeb/0x140
>  [<c014007b>] do_munmap+0xeb/0x140
>  [<c01163b0>] dec_preempt_count+0x110/0x120
>  [<c014007b>] do_munmap+0xeb/0x140
>  [<c014010f>] sys_munmap+0x3f/0x60
>  [<c0103ee1>] sysenter_past_esp+0x52/0x71

Looks like ZAP_BLOCK_SIZE may be too large for you. Lowering that some
may "help" this. It's probably harmless, but try lowering that to half
of whatever it is now, or maybe 64*PAGE_SIZE. It may be worthwhile
to restructure how the preemption points are done in unmap_vmas() so
we don't end up in some kind of tuning nightmare.


-- wli
