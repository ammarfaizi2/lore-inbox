Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261674AbVC3AAl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261674AbVC3AAl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 19:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261671AbVC3AAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 19:00:40 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:15775 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261674AbVC3AAU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 19:00:20 -0500
Date: Tue, 29 Mar 2005 18:59:52 -0500
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: William Cohen <wcohen@redhat.com>
Cc: SystemTAP <systemtap@sources.redhat.com>, akpm@osdl.org,
       prasanna@in.ibm.com, linux-kernel@vger.kernel.org, davem@davemloft.net
Subject: Re: kprobe_handler should  check pre_handler function
Message-ID: <20050329235952.GA4969@in.ibm.com>
Reply-To: ananth@in.ibm.com
References: <424872C8.6080207@redhat.com> <20050329023408.GA4847@in.ibm.com> <4249A9EA.10901@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4249A9EA.10901@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2005 at 02:18:02PM -0500, William Cohen wrote:
> Ananth N Mavinakayanahalli wrote:
> >On Mon, Mar 28, 2005 at 04:10:32PM -0500, William Cohen wrote:
> >
> >Hi Will,
> >
> >
> >>I found kprobes expects there to be a pre_handler function in the 
> >>structure. I was writing a probe that only needed a post_handler 
> >>function, no pre_handler function. The probe was tracking the 
> >>destinations of indirect calls and jumps, the probe needs to fire after 
> >>the instruction single steps to get the target address. The probe 
> >>crashed the machine because arch/i386/kernel/kprobe.c:kprobe_handler() 
> >>blindly calls p->pre_handler().  There should be a check to verify that 
> >>the pointer is non-null. There are cases where the pre_handler is not 
> >>needed and it would make sense to set it to NULL. Thus, a check should 
> >>be done for pre_handler like post_handler and fault_handler.
> >
> >
> >You are right. The check for pre_handler is needed and here is a patch
> >against 2.6.12-rc1-mm3 that does this.
> >
> >Thanks,
> >Ananth
> 
> Ananth,
> 
> Thanks. It looks like it addresses the problem. Could you see about 
> getting this patch in the upstream kernel?

Will,

I think Andrew now has this in his patchset. It will probably be in the
next -mm.

Thanks,
Ananth
