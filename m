Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965144AbWHQRO2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965144AbWHQRO2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 13:14:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965146AbWHQRO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 13:14:28 -0400
Received: from smtp-out.google.com ([216.239.45.12]:13215 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S965144AbWHQRO0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 13:14:26 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=xjsFpoYAuZDeYvr4k6XRWOMdCrRSQ6m47A0fEjvs4SN6Ls0kjzpKpacyU9QbaH4Y8
	hhXw1GKNd57eihqTbgW4Q==
Subject: Re: [RFC][PATCH 5/7] UBC: kernel memory accounting (core)
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Kirill Korotaev <dev@sw.ru>
Cc: Dave Hansen <haveblue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>, hugh@veritas.com,
       ckrm-tech@lists.sourceforge.net, Andi Kleen <ak@suse.de>
In-Reply-To: <44E470B5.4020706@sw.ru>
References: <44E33893.6020700@sw.ru>  <44E33C8A.6030705@sw.ru>
	 <1155754029.9274.21.camel@localhost.localdomain>
	 <1155755729.22595.101.camel@galaxy.corp.google.com>
	 <44E470B5.4020706@sw.ru>
Content-Type: text/plain
Organization: Google Inc
Date: Thu, 17 Aug 2006 10:13:11 -0700
Message-Id: <1155834791.14617.42.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-17 at 17:35 +0400, Kirill Korotaev wrote:

> > My preference would be to have container (I keep on saying container,
> > but resource beancounter) pointer embeded in task, mm(not sure),
> > address_space and anon_vma structures.  This should allow us to track
> > user land pages optimally.  But for tracking kernel usage on behalf of
> > user, we will have to use an additional field (unless we can re-use
> > mapping).  Please correct me if I'm wrong, though all the kernel
> > resources will be allocated/freed in context of a user process.  And at
> > that time we know if a allocation should succeed or not.  So we may
> > actually not need to track kernel pages that closely.  We are not going
> > to run reclaim on any of them anyways.  
> objects are really allocated in process context
> (except for TCP/IP and other softirqs which are done in arbitrary
> process context!)

Can these pages be tagged using mapping field of the page struct.

> And objects are not always freed in correct context (!).
> 
You mean beyond Networking and softirq.

> Note, page_ub is not for _user_ pages. user pages accounting will be added
> in next patch set. page_ub is added to track kernel allocations.
> 

But will the page_ub be used for some purpose for user land pages?

-rohit

