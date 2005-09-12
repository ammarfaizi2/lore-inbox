Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750880AbVILQHA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750880AbVILQHA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 12:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750902AbVILQHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 12:07:00 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:26499 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750877AbVILQG7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 12:06:59 -0400
Date: Mon, 12 Sep 2005 09:06:45 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Peter Staubach <staubach@redhat.com>, g@joust
Cc: Andrew Morton <akpm@osdl.org>, dwmw2@infradead.org, bunk@stusta.de,
       johnstul@us.ibm.com, drepper@redhat.com, Franz.Fischer@goyellow.de,
       linux-kernel@vger.kernel.org
Subject: Re: [UPDATE PATCH][Bug 5132] fix sys_poll() large timeout handling
Message-ID: <20050912160645.GB25471@us.ibm.com>
References: <20050831200109.GB3017@us.ibm.com> <20050906212514.GB3038@us.ibm.com> <20050910003525.GC24225@us.ibm.com> <20050909181658.221eb6f9.akpm@osdl.org> <20050910022330.GD24225@us.ibm.com> <20050909193621.5d578583.akpm@osdl.org> <20050910025534.GE24225@us.ibm.com> <4325910E.8080707@redhat.com> <20050912150541.GA25471@us.ibm.com> <43259C84.5020209@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43259C84.5020209@redhat.com>
X-Operating-System: Linux 2.6.13 (i686)
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.09.2005 [11:19:32 -0400], Peter Staubach wrote:
> Nishanth Aravamudan wrote:
> 
> >
> >I don't think the embedded folks are going to be ok with adding a 64-bit
> >div in the poll() common-path... But otherwise the patch looks pretty
> >sane, except I think you want s64, not int64_t? I can't ever remember
> >myself :)
> > 
> >
> 
> Oops, I missed an include which is required.  The updated patch is attached.

Could you update your patch against 2.6.13-mm3? Andrew has aleady pulled
in the patch I sent with his changes. It should make your pactch a
little smaller (and only need to touch fs/select.c).

> A 64 bit quantity divided by a 32 bit quantity seems to be a standard
> interface in the kernel and is used fairly widely, so I suspect that
> the embedded folks have already done the work.

I understand that the interface is common enough, but I'm not sure how
appreciated it is :)

> I don't know which should be used, s64 or int64_t.  I chose int64_t
> because then it would (more or less) match the interface of do_div().

Yes, I'll leave this to someone else to figure out...

> >I agree the interface mght be mis-defined. And changing timeout_msecs()
> >to an integer is consistent with the size of millisecond-unit variables
> >used elsewhere in the kernel.
> >
> 
> Yes, it also makes the kernel definition for sys_poll() match the user level
> definition for poll(2) found in <poll.h>.

Yup, sounds good to me.

Thanks,
Nish
