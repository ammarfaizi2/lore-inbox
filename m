Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263085AbUGMDJo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263085AbUGMDJo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 23:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263107AbUGMDJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 23:09:44 -0400
Received: from muss.CIS.McMaster.CA ([130.113.64.9]:2719 "EHLO
	cgpsrv1.cis.mcmaster.ca") by vger.kernel.org with ESMTP
	id S263085AbUGMDJm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 23:09:42 -0400
From: Gabriel Devenyi <devenyga@mcmaster.ca>
To: ck@vds.kolivas.org
Subject: Re: [ck] Re: Preempt Threshold Measurements
Date: Mon, 12 Jul 2004 23:09:43 -0400
User-Agent: KMail/1.6.2
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
References: <200407121943.25196.devenyga@mcmaster.ca> <200407122248.50377.devenyga@mcmaster.ca> <20040713025502.GR21066@holomorphy.com>
In-Reply-To: <20040713025502.GR21066@holomorphy.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407122309.43088.devenyga@mcmaster.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ah good, thanks for the suggestion on how to improve this... Now, what exactly 
is that, and where/how do I change it.... (I really should start/finish that 
"understanding the linux kernel" book of mine)


-- 
Gabriel Devenyi
devenyga@mcmaster.ca

On Monday 12 July 2004 22:55, William Lee Irwin III wrote:
> On Mon, Jul 12, 2004 at 10:48:50PM -0400, Gabriel Devenyi wrote:
> > Well I'm not particularly educated in kernel internals yet, here's some
> > reports from the system when its running.
> > 6ms non-preemptible critical section violated 4 ms preempt threshold
> > starting at do_munmap+0xd2/0x140 and ending at do_munmap+0xeb/0x140
> >  [<c014007b>] do_munmap+0xeb/0x140
> >  [<c01163b0>] dec_preempt_count+0x110/0x120
> >  [<c014007b>] do_munmap+0xeb/0x140
> >  [<c014010f>] sys_munmap+0x3f/0x60
> >  [<c0103ee1>] sysenter_past_esp+0x52/0x71
>
> Looks like ZAP_BLOCK_SIZE may be too large for you. Lowering that some
> may "help" this. It's probably harmless, but try lowering that to half
> of whatever it is now, or maybe 64*PAGE_SIZE. It may be worthwhile
> to restructure how the preemption points are done in unmap_vmas() so
> we don't end up in some kind of tuning nightmare.
>
>
> -- wli
> _______________________________________________
> ck@vds.kolivas.org
> ck mailing list - unmoderated. Please reply-to-all when posting.
> http://bhhdoa.org.au/mailman/listinfo/ck
