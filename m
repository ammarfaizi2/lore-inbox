Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129486AbRB0Cbn>; Mon, 26 Feb 2001 21:31:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129491AbRB0Cbf>; Mon, 26 Feb 2001 21:31:35 -0500
Received: from [204.244.205.25] ([204.244.205.25]:21576 "HELO post.gateone.com")
	by vger.kernel.org with SMTP id <S129486AbRB0Cba>;
	Mon, 26 Feb 2001 21:31:30 -0500
From: Michael Peddemors <michael@linuxmagic.com>
Reply-To: michael@linuxmagic.com
Organization: Wizard Internet Services
To: "Benjamin C.R. LaHaise" <blah@kvack.org>,
        "David S. Miller" <davem@redhat.com>
Subject: Re: [UPDATE] zerocopy.. While working on ip.h stuff
Date: Mon, 26 Feb 2001 19:41:54 -0800
X-Mailer: KMail [version 1.1.95.0]
Content-Type: text/plain
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
In-Reply-To: <Pine.LNX.3.96.1010226190859.12521B-100000@kanga.kvack.org>
In-Reply-To: <Pine.LNX.3.96.1010226190859.12521B-100000@kanga.kvack.org>
MIME-Version: 1.0
Message-Id: <0102261941540L.02007@mistress>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Feb 2001, Benjamin C.R. LaHaise wrote:
> On Mon, 26 Feb 2001, David S. Miller wrote:
> > At gigapacket rates, it becomes an issue.  This guy is talking about
> > tinkering with new IP _options_, not just the header.  So even if the
> > IP header itself fits totally in a cache line, the options afterwardsd
> > likely will not and thus require another cache miss.

Yes, I expect to use the whole of the allowed size :) 
So instead of the more common IP Header length of 20 bytes, I will be using 
25-60 bytes for a header, (But so does source routing) and the router RFC 
says that we should handle it...
Now, of course, you have raised the question of whether that would be handled 
effeciently with the current kernel code..

> Hmmm, one way around this is to have the packet queue store things in
> in a linear array of pointers to data areas, then process things in
> bursts, ie:
>
> 	- find packet data areas for queued packets
> 	- walk list doing prefetches of ip header and options
> 	- then actually do the packet processing (save output for later)
>
> That will require a number of new hooks for pipelining operations, though.
> Just a thought.
>
> 		-ben

-- 
"Catch the magic of Linux...."
--------------------------------------------------------
Michael Peddemors - Senior Consultant
Unix Administration - WebSite Hosting
Network Services - Programming
Wizard Internet Services http://www.wizard.ca
Linux Support Specialist - http://www.linuxmagic.com
--------------------------------------------------------
(604) 589-0037 Beautiful British Columbia, Canada
--------------------------------------------------------
