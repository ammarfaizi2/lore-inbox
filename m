Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751276AbWH1Qu3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbWH1Qu3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 12:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbWH1Qu3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 12:50:29 -0400
Received: from smtp-out.google.com ([216.239.45.12]:41769 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751276AbWH1Qu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 12:50:28 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=xcis/X8H65jnSkdb7yDS5FKj6+dvHSX5lTe3XlUApspmVKWa3cEw72qjcyjiaMGGa
	kb6yl0OXNzl6yOnitSw3g==
Subject: Re: BC: resource beancounters (v2)
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrey Savochkin <saw@sw.ru>, Andrew Morton <akpm@osdl.org>,
       Kirill Korotaev <dev@sw.ru>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, devel@openvz.org,
       Rik van Riel <riel@redhat.com>, Andi Kleen <ak@suse.de>,
       Greg KH <greg@kroah.com>, Oleg Nesterov <oleg@tv-sign.ru>,
       Matt Helsley <matthltc@us.ibm.com>,
       Chandra Seetharaman <sekharan@us.ibm.com>
In-Reply-To: <1156610224.3007.284.camel@localhost.localdomain>
References: <44EC31FB.2050002@sw.ru> <20060823100532.459da50a.akpm@osdl.org>
	 <44EEE3BB.10303@sw.ru> <20060825073003.e6b5ae16.akpm@osdl.org>
	 <20060825203026.A16221@castle.nmd.msu.ru>
	 <1156558552.24560.23.camel@galaxy.corp.google.com>
	 <1156610224.3007.284.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Google Inc
Date: Mon, 28 Aug 2006 09:48:41 -0700
Message-Id: <1156783721.8317.6.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-08-26 at 17:37 +0100, Alan Cox wrote:
> Ar Gwe, 2006-08-25 am 19:15 -0700, ysgrifennodd Rohit Seth:
> > Yes, sharing of pages across different containers/managers will be a
> > problem.  Why not just disallow that scenario (that is what fake nodes
> > proposal would also end up doing).
> 
> Because it destroys the entire point of using containers instead of
> something like Xen - which is sharing. Also at the point I am using
> beancounters per user I don't want glibc per use, libX11 per use glib
> per use gtk per user etc..
> 
> 

I'm not saying per use glibc etc.  That will indeed be useless and bring
it to virtualization world.  Just like fake node, one should be allowed
to use pages that are already in  (for example) page cache- so that you
don't end up duplicating all shared stuff.  But as far as charging is
concerned, charge it to container who either got the page in page cache
OR if FS based semantics exist then charge it to the container where the
file belongs.  What I was suggesting is to not charge a page to
different counters.

-rohit

