Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270364AbUJTOZ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270364AbUJTOZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 10:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270199AbUJTOHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 10:07:16 -0400
Received: from lists.us.dell.com ([143.166.224.162]:21702 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S270067AbUJTOC0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 10:02:26 -0400
Date: Wed, 20 Oct 2004 09:02:14 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org,
       Ernie Petrides <petrides@redhat.com>
Subject: Re: [PATCH] reserved buffers only for PF_MEMALLOC
Message-ID: <20041020140214.GB16114@lists.us.dell.com>
References: <Pine.LNX.4.44.0408101310580.7156-100000@dhcp83-102.boston.redhat.com> <20040810201652.GF13509@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040810201652.GF13509@logos.cnet>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2004 at 05:16:52PM -0300, Marcelo Tosatti wrote:
> On Tue, Aug 10, 2004 at 01:20:24PM -0400, Rik van Riel wrote:
> > 
> > The buffer allocation path in 2.4 has a long standing bug,
> > where non-PF_MEMALLOC tasks can dig into the reserved pool
> > in get_unused_buffer_head().  The following patch makes the
> > reserved pool only accessible to PF_MEMALLOC tasks.
> > 
> > Other processes will loop in create_buffers() - the only
> > function that calls get_unused_buffer_head() - and will call
> > try_to_free_pages(GFP_NOIO), freeing any buffer heads that
> > have become freeable due to IO completion.
> > 
> > Note that PF_MEMALLOC tasks will NOT do anything inside
> > try_to_free_pages(), so it is needed that they are able to
> > dig into the reserved buffer heads while other tasks are
> > not.
> 
> Applied.
> 
> Matt, it would be really nice if you could run the workload
> which triggers the deadlock on 2.4.27+Rik's patch.

Sorry for the long delay.  kernel 2.4.28-pre3 has been running under
load for 12 days, where otherwise we would have expected a failure in
less than 1 day.  I'm satisfied this is the right thing to have done.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
