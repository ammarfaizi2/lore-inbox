Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161394AbWG1XxU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161394AbWG1XxU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 19:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161396AbWG1XxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 19:53:20 -0400
Received: from ra.tuxdriver.com ([70.61.120.52]:12047 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1161394AbWG1XxT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 19:53:19 -0400
Date: Fri, 28 Jul 2006 19:52:58 -0400
From: Neil Horman <nhorman@tuxdriver.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: kernel-janitors@osdl.org, linux-kernel@vger.kernel.org, paulus@au.ibm.com
Subject: Re: [KJ] audit return code handling for kernel_thread [1/11]
Message-ID: <20060728235258.GB4899@hmsreliant.homelinux.net>
References: <200607282007.k6SK75MK009573@ra.tuxdriver.com> <44CAA26D.7030809@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44CAA26D.7030809@yahoo.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 29, 2006 at 09:49:01AM +1000, Nick Piggin wrote:
> nhorman@tuxdriver.com wrote:
> >Audit/Cleanup of kernel_thread calls, specifically checking of return 
> >codes.
> >    Problems seemed to fall into 3 main categories:
> >    
> 
> Thanks for doing this. Nitpick: this should be all one patch, or at most 3
> patches (then each of the below 3 items would become individual changelogs).
> 
You're welcome. I specifically split it into multiple little patches, as each file has a
different maintainer, but if the consensus is for one patch (or three), so be it, I'll do
that in the future.

> Each patch should have a unique changelog, each should have a unique subject
> (sans the sequence number).
> 
> cc'ing Andrew is also a good idea, if you want them to get merged ;)
> 
I can do that :)

> One coding style comment:
> if (...)
>     multi line
>         statement
> 
> Could use braces around the outermost if statement, for clarity.
> 
If you ack this, I'll post a follow on patch to clean that up next week.  I've already
received a suggestion to use the same failure to start thread warning message to
save string table space, so I've got some extra clean up to do anyway.

Regards
Neil

> 
> >    1) callers of kernel_thread were inconsistent about meaning of a zero 
> >    return
> >    code.  Some callers considered a zero return code to mean success, 
> >    others took
> >    it to mean failure.  a zero return code, while not actually possible 
> >    in the
> >    current implementation, should be considered a success (pid 0 
> >    is/should be
> >    valid). fixed all callers to treat zero return as success
> >    
> >    2) caller of kernel_thread saved return code of kernel_thread for 
> >    later use
> >    without ever checking its value.  Callers who did this tended to 
> >    assume a
> >    non-zero return was success, and would often wait for a completion 
> >    queue to be
> >    woken up, implying that an error (negative return code) from 
> >    kernel_thread could
> >    lead to deadlock.  Repaired by checking return code at call time, and 
> >    setting
> >    saved return code to zero in the event of an error.
> >    
> >    3) callers of kernel_thread never bothered to check the return code at 
> >    all.
> >    This can lead to seemingly unrelated errors later in execution.  Fixed 
> >    by
> >    checking return code at call time and printing a warning message on 
> >    failure.
> 
> -- 
> SUSE Labs, Novell Inc.
> Send instant messages to your online friends http://au.messenger.yahoo.com 

-- 
/***************************************************
 *Neil Horman
 *Software Engineer
 *gpg keyid: 1024D / 0x92A74FA1 - http://pgp.mit.edu
 ***************************************************/
