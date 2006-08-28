Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964855AbWH1W31@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964855AbWH1W31 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 18:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964860AbWH1W31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 18:29:27 -0400
Received: from smtp-out.google.com ([216.239.45.12]:25021 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S964855AbWH1W30
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 18:29:26 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=svHxIo0Dy8VK5z/ii6Cay6LGLvmaquDliJ7yt6Y10u6lRschlPtd+D9An1YKwbTZY
	uRHpRHUkat+dM77evUW8Q==
Subject: Re: [Devel] Re: BC: resource beancounters (v2)
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Kir Kolyshkin <kir@openvz.org>
Cc: devel@openvz.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andrew Morton <akpm@osdl.org>, Rik van Riel <riel@redhat.com>,
       Andi Kleen <ak@suse.de>, Chandra Seetharaman <sekharan@us.ibm.com>,
       Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>, Andrey Savochkin <saw@sw.ru>,
       Matt Helsley <matthltc@us.ibm.com>, Oleg Nesterov <oleg@tv-sign.ru>
In-Reply-To: <44F32AC7.1090604@openvz.org>
References: <44EC31FB.2050002@sw.ru> <20060823100532.459da50a.akpm@osdl.org>
	 <44EEE3BB.10303@sw.ru> <20060825073003.e6b5ae16.akpm@osdl.org>
	 <20060825203026.A16221@castle.nmd.msu.ru>
	 <1156558552.24560.23.camel@galaxy.corp.google.com>
	 <1156610224.3007.284.camel@localhost.localdomain>
	 <1156783721.8317.6.camel@galaxy.corp.google.com>
	 <44F32AC7.1090604@openvz.org>
Content-Type: text/plain
Organization: Google Inc
Date: Mon, 28 Aug 2006 15:28:09 -0700
Message-Id: <1156804089.8985.19.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-28 at 21:41 +0400, Kir Kolyshkin wrote:
> Rohit Seth wrote:
> >
> > I'm not saying per use glibc etc.  That will indeed be useless and bring
> > it to virtualization world.  Just like fake node, one should be allowed
> > to use pages that are already in  (for example) page cache- so that you
> > don't end up duplicating all shared stuff.  But as far as charging is
> > concerned, charge it to container who either got the page in page cache
> > OR if FS based semantics exist then charge it to the container where the
> > file belongs.  What I was suggesting is to not charge a page to
> > different counters.
> >   
> 
> Consider the following simple scenario: there are 50 containers 
> (numbered, say, 1 to 50) all sharing a single installation of Fedora 
> Core 5. They all run sshd, apache, syslogd, crond and some other stuff 
> like that. This is actually quite a real scenario.
> 
> In the world that you propose the container which was unlucky to start 
> first (probably the one with ID of either 1 or 50) will be charged for 
> all the memory, and all the
> others will have most of their memory for free. And in such a world 
> per-container memory accounting or limiting is just not possible.

If you are only having task based accounting then yes the first
container using a page will be charged.  And when it hit its limit then
it will inactivate some of the pages.  If some other container now uses
the same page (that got inactivated) again then this next container will
be charged for that page.

Though if we have file/directory based accounting then shared pages
belonging to /usr/lib or /usr/bin can go to a common container.

-rohit

