Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267165AbUI0Smz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267165AbUI0Smz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 14:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266895AbUI0Smz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 14:42:55 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:30462 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S267165AbUI0Sm3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 14:42:29 -0400
Subject: Re: [PATCH/RFC] Simplified Readahead
From: Ram Pai <linuxram@us.ibm.com>
To: Steven Pratt <slpratt@austin.ibm.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <41583225.4040901@austin.ibm.com>
References: <Pine.LNX.4.44.0409242123110.14902-100000@dyn319181.beaverton.ibm.com>
	 <41583225.4040901@austin.ibm.com>
Content-Type: text/plain
Organization: 
Message-Id: <1096310537.11845.33.camel@dyn319181.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 27 Sep 2004 11:42:18 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-09-27 at 08:30, Steven Pratt wrote:
> Ram Pai wrote:
> 
> >On Fri, 24 Sep 2004, Ram Pai wrote:
> >  
> >
> >>On Thu, 23 Sep 2004, Steven Pratt wrote:
> >>    
> >>

 ..snip..

> >To summarize you noticed 3 problems:
> >
> >1. page cache hits not handled properly.
> >2. readahead thrashing not accounted.
> >3. read congestion not accounted.
> >  
> >
> Yes.
> 
> >Currently both the patches do not handle all the above cases.
> >  
> >
> No, thrashing was handled in the first patch, and both thrashing and 
> page cache hits are handled in the second.  Also, it seems to be the 
> consensus that on normal I/O ignoring queue congestion is the right 
> behavior.
> 
> >So if your patch performs much better than the current one, than
> >it is the winner anyway.   But past experience has shown that some
> >benchmark gets a hit for any small change. This happens to be tooo big
> >a change.
> >
> I agree, we need more people to test this.
> 
> >


I will fix the 3 problems you discovered in the current code.
And lets  compare the two results.  However you have more features in
your patch which will be the differentiating factor between the two
versions.

1. exponential increase and decrease of window size 
2. overlapped read of current window and readahead window.
3. fixed slow-read path.
4. anything else?
	
The readsize parameter comes in handy to incorporate the
the above features.

RP

