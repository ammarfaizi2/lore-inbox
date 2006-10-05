Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751301AbWJEQVO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbWJEQVO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 12:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751514AbWJEQVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 12:21:14 -0400
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:62264 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1751301AbWJEQVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 12:21:13 -0400
To: Jeff Garzik <jeff@garzik.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: make-bogus-warnings-go-away tree
X-Message-Flag: Warning: May contain useful information
References: <20061003001115.e898b8cb.akpm@osdl.org>
	<20061005083754.GA1060@elte.hu> <4524D8DC.1080100@garzik.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 05 Oct 2006 09:21:10 -0700
In-Reply-To: <4524D8DC.1080100@garzik.org> (Jeff Garzik's message of "Thu, 05 Oct 2006 06:05:16 -0400")
Message-ID: <adawt7elond.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 05 Oct 2006 16:21:12.0055 (UTC) FILETIME=[45D0B070:01C6E89A]
Authentication-Results: sj-dkim-1.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Jeff> So, I agree that annotations are a good idea, but I'm not so
    Jeff> sure that your proposed "= 0" approach is the best one.
    Jeff> Remember, we need to do this for multi-member structures,
    Jeff> integers, and pointers, not just things easily assigned to
    Jeff> zero.

Not to mention the fact that "foo = 0" generates extra (probably
unnecessary) code to initialize foo, while "foo = foo" just shuts up
the gcc warning without affecting generated code.

I'm already somewhat unconfortable shutting up these gcc warnings at
all, since adding these annotations add one more thing that must be
maintained -- I feel it would be all-too-easy to change the logic of a
function in a way that introduces a bug, and then have the annotation
hide a "is used uninitialised" warning.

But I definitely feel we shouldn't make our object code even slightly
worse just to shut up the warnings.

 - R.
