Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267370AbUIWWV7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267370AbUIWWV7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 18:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267487AbUIWWSL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 18:18:11 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:1698 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S267370AbUIWWOr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 18:14:47 -0400
Message-ID: <41534AC7.70409@austin.ibm.com>
Date: Thu, 23 Sep 2004 17:14:31 -0500
From: Joel Schopp <jschopp@austin.ibm.com>
Reply-To: jschopp@austin.ibm.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steven Pratt <slpratt@austin.ibm.com>
CC: linux-kernel@vger.kernel.org, linux-fs-devel@vger.kernel.org
Subject: Re: [PATCH/RFC] Simplified Readahead
References: <4152F46D.1060200@austin.ibm.com>
In-Reply-To: <4152F46D.1060200@austin.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The key design point of the new design is to make the readahead code 
> aware of the size of the I/O request.  This change eliminates the need 
> for treating large random I/O as sequential and all of the averaging 
> code that exists just to support this.  In addition to this change, the 
> new design ramps up quicker, and shuts off faster.  This, combined with 
> the request size awareness eliminates the so called "slow read path" 
> that we try so hard to avoid in the current code.  For complete details 
> on the design of the new readahead logic, please refer to 
> http://www-124.ibm.com/developerworks/opensource/linuxperf/readahead/read-ahead-design.pdf 

I do love the design.  Certainly an improvement over what we currently 
have in all ways I can think of.

> 
> 
> There are a few exception cases which still concern me.
> 1. pages already in cache
> 2. I/O queue congestion.
> 3. page stealing

Correct me if I am wrong on this.  But if there was simultaneous 
multithreaded reading on a single file would it look non sequential and 
not trigger readahead?  For instance if on a 4 processor system 4 
threads were each reading 1/4 of the single file sequentially.  Would 
this be exception case number 4?

I don't know if this is a common scenario, just a plausible one.  I also 
don't know a good way to deal with it.  Current code is just as 
susceptible to it in any case.  Nothing to hold up putting this in, just 
curious if somebody knows how we might deal with it properly.
