Return-Path: <linux-kernel-owner+w=401wt.eu-S965304AbXATQVJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965304AbXATQVJ (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 11:21:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965305AbXATQVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 11:21:09 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:60800 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965304AbXATQVH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 11:21:07 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=CIBi8VSFAmTCt0+tXpt4D7v3ExQo7yqI2ShbKsyP6eYCeEC2dFq/lEHVmzT8/RdkJMiHJ6VK3G0hcn6I12REPEFd+Uvad6CCjqpGPTkAz0+OKB9wImHYK5ixFmpxR71IwXQuLlIWmBAujuh7wOuNZQvajeSep6dOuvv28AQU6gg=
From: Denis Vlasenko <vda.linux@googlemail.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: O_DIRECT question
Date: Sat, 20 Jan 2007 17:19:15 +0100
User-Agent: KMail/1.8.2
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Aubrey <aubreylee@gmail.com>,
       Hua Zhong <hzhong@gmail.com>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel@vger.kernel.org, hch@infradead.org,
       kenneth.w.chen@intel.com, akpm@osdl.org, mjt@tls.msk.ru
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com> <45A5D4A7.7020202@yahoo.com.au> <Pine.LNX.4.64.0701110746360.3594@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0701110746360.3594@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701201719.15341.vda.linux@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 January 2007 16:50, Linus Torvalds wrote:
> 
> On Thu, 11 Jan 2007, Nick Piggin wrote:
> > 
> > Speaking of which, why did we obsolete raw devices? And/or why not just
> > go with a minimal O_DIRECT on block device support? Not a rhetorical
> > question -- I wasn't involved in the discussions when they happened, so
> > I would be interested.
> 
> Lots of people want to put their databases in a file. Partitions really 
> weren't nearly flexible enough. So the whole raw device or O_DIRECT just 
> to the block device thing isn't really helping any.
> 
> > O_DIRECT is still crazily racy versus pagecache operations.
> 
> Yes. O_DIRECT is really fundamentally broken. There's just no way to fix 
> it sanely. Except by teaching people not to use it, and making the normal 
> paths fast enough (and that _includes_ doing things like dropping caches 
> more aggressively, but it probably would include more work on the device 
> queue merging stuff etc etc).

What will happen if we just make open ignore O_DIRECT? ;)

And then anyone who feels sad about is advised to do it
like described here:

http://lkml.org/lkml/2002/5/11/58
--
vda
