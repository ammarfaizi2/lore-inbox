Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932169AbWBXJhm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbWBXJhm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 04:37:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932171AbWBXJhm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 04:37:42 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:46047 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932169AbWBXJhl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 04:37:41 -0500
Date: Fri, 24 Feb 2006 15:07:56 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Chris Mason <mason@suse.com>
Cc: akpm@osdl.org, sct@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-aio@kvack.org, kenneth.w.chen@intel.com, pbadari@us.ibm.com,
       linux-kernel@vger.kernel.org, sonny@burdell.org
Subject: Re: [RFC][WIP] DIO simplification and AIO-DIO stability
Message-ID: <20060224093756.GA5241@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20060223072955.GA14244@in.ibm.com> <200602232001.34327.mason@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602232001.34327.mason@suse.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2006 at 08:01:32PM -0500, Chris Mason wrote:
> On Thursday 23 February 2006 02:29, Suparna Bhattacharya wrote:
> > DIO code complexity and stability concerns were discussed way back during
> > OLS and Kernel summit last year. Still, the lack of a solid alternative and
> > motivation to subject oneself to the test of courage and delicate balance
> > that fiddling with this code entails, has meant that gingerly applying
> > fixes and bandaids as and when bugs are found, and moving on thereafter,
> > continues to be the most palatable option.
> >
> > A recent AIO-DIO bug reported by Kenneth Chen, came very close
> > to being the proverbial last straw for me. Hence, here is a rough attempt
> > to put together a (currently WIP) draft towards DIO code simplication,
> > based on suggestions that some of you have brought up at various times.
> > Several details, e.g. range locking implementation still need to be fleshed
> > out completely, ideas/comments/suggestions would be welcome.
> 
> I'm really in favor of this, and had actually started an implementation a 
> while back.  At the time, I posted a different version that added yet another 
> semaphore but simplified the rest of the locking (and held no locks during 
> the dio/aio).

Yes I have saved that patch as a reference as well.
With range locking I'm hoping that would be able to avoid the need for
i_hole_sem. Also I wanted to push out all locking code out of the DIO
code to avoid the various locking mode checks.

> 
> I'll try to dig up my original radix tagging code.  I'm not sure if I kept it, 
> but it did pass Daniel's dio vs buffer io racing tests at the time.

Cool - that would be great !

Regards
Suparna

> 
> -chris
> 
> --
> To unsubscribe, send a message with 'unsubscribe linux-aio' in
> the body to majordomo@kvack.org.  For more info on Linux AIO,
> see: http://www.kvack.org/aio/
> Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

