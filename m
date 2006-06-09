Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965227AbWFILVo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965227AbWFILVo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 07:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965233AbWFILVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 07:21:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:65502 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965227AbWFILVo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 07:21:44 -0400
Date: Fri, 9 Jun 2006 04:21:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: balbir@in.ibm.com
Cc: nagar@watson.ibm.com, jlan@sgi.com, csturtiv@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch][RFC]  Disabling per-tgid stats on task exit in
 taskstats
Message-Id: <20060609042129.ae97018c.akpm@osdl.org>
In-Reply-To: <448952C2.1060708@in.ibm.com>
References: <44892610.6040001@watson.ibm.com>
	<20060609010057.e454a14f.akpm@osdl.org>
	<448952C2.1060708@in.ibm.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Jun 2006 16:21:46 +0530
Balbir Singh <balbir@in.ibm.com> wrote:

> Andrew Morton wrote:
> > On Fri, 09 Jun 2006 03:41:04 -0400
> > Shailabh Nagar <nagar@watson.ibm.com> wrote:
> > 
> > 
> >>Hence, this patch introduces a configuration parameter
> >>	/sys/kernel/taskstats_tgid_exit
> >>through which a privileged user can turn on/off sending of per-tgid stats on
> >>task exit.
> > 
> > 
> > That seems a bit clumsy.  What happens if one consumer wants the per-tgid
> > stats and another does not?
> 
> For all subsystems that re-use the taskstats structure from the exit path,
> we have the issue that you mentioned. Thats because several statistics co-exist
> in the same structure. These subsystems can keep their tgid-stats empty by not
> filling up anything in fill_tgid() or using this patch to selectively enable/disable
> tgid stats.
> 
> For other subsystems, they could pass tgidstats as NULL to taskstats_exit_send().
> 

I don't understand.  If a subsystem exists then it fills in its slots in
the taskstats structure, doesn't it?

No other subsystem needs a global knob, does it?

You see the problem - if one userspace package wants the tgid-stats and
another concurrently-running one does now, what do we do?  Just leave it
enabled and run a bit slower?

If so, how much slower?  Your changelog says some potential users don't
need the tgid-stats, but so what?  I assume this patch is a performance
thing?  If so, has it been quantified?

