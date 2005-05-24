Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262055AbVEXOfg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262055AbVEXOfg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 10:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261935AbVEXOff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 10:35:35 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:27591 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S261474AbVEXOeh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 10:34:37 -0400
Message-ID: <42933B7A.3060206@freenet.de>
Date: Tue, 24 May 2005 16:34:34 +0200
From: Carsten Otte <cotte@freenet.de>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: suparna@in.ibm.com
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       schwidefsky@de.ibm.com, akpm@osdl.org,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC/PATCH 2/4] fs/mm: execute in place (3rd version)
References: <1116866094.12153.12.camel@cotte.boeblingen.de.ibm.com> <1116869420.12153.32.camel@cotte.boeblingen.de.ibm.com> <20050524093029.GA4390@in.ibm.com> <42930B64.2060105@freenet.de> <20050524133211.GA4896@in.ibm.com>
In-Reply-To: <20050524133211.GA4896@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suparna Bhattacharya wrote:

>On Tue, May 24, 2005 at 01:09:24PM +0200, Carsten Otte wrote:
>  
>
>BTW, your calculation between your previous patch and current one is a
>reasonable argument for not reverting back to the earlier version, but
>then that wasn't what I was suggesting. Hope that was clear. Not complicating
>the common path in filemap.c with if (xip) branches is a good idea.
>  
>
True, there is more copied code obviously. I was just comparing
against the soloution to unify things that I found.

>Right now you have chosen what is possibly the lesser of two evils,
>but having had to end up modifying code in multiple places in read/write and
>inadvertant bugs introduced thus in the past and paid for over time :( 
>has made me quite wary of code duplication in this particular area, simple
>as it seems.
>
>I'll take a closer look and see if I can think of any other way to abstract
>this better. Maybe the long term solution is what Christoph suggested
>in terms of collapsing interfaces.
>  
>
Maintenance effort is a good point. Changes would need to be applied
to both versions, which don't differ too much today.
Embedded folks will likely figure they also need the reverse path to
return references (like put_xip_page()), and indication of required access
(read/write) to make this work with flash chips.
Therefore I guess those two versions to differ more in the future,
making it hard to think about a soloution unifying the code paths
in a sane way so that it will work out for flash in the end.
As for me, I did not find a better one than in version one/two. If you
figure a good one, I will be happy to work on its implementation.

