Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751188AbWCJOFQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbWCJOFQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 09:05:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbWCJOFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 09:05:16 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:22486 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751188AbWCJOFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 09:05:15 -0500
Subject: Re: [PATCH 00/03] Unmapped: Separate unmapped and mapped pages
From: Arjan van de Ven <arjan@infradead.org>
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Magnus Damm <magnus@valinux.co.jp>,
       Linux Kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
In-Reply-To: <aec7e5c30603100519l5a68aec3ub838ac69a734a46b@mail.gmail.com>
References: <20060310034412.8340.90939.sendpatchset@cherry.local>
	 <1141977139.2876.15.camel@laptopd505.fenrus.org>
	 <aec7e5c30603100519l5a68aec3ub838ac69a734a46b@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 10 Mar 2006 15:05:06 +0100
Message-Id: <1141999506.2876.45.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-10 at 14:19 +0100, Magnus Damm wrote:
> On 3/10/06, Arjan van de Ven <arjan@infradead.org> wrote:
> > > Apply on top of 2.6.16-rc5.
> > >
> > > Comments?
> >
> >
> > my big worry with a split LRU is: how do you keep fairness and balance
> > between those LRUs? This is one of the things that made the 2.4 VM suck
> > really badly, so I really wouldn't want this bad...
> 
> Yeah, I agree this is important. I think linux-2.4 tried to keep the
> LRU list lengths in a certain way (maybe 2/3 of all pages active, 1/3
> inactive).

not really 

> My current code just extends this idea which basically means that
> there is currently no relation between how many pages that sit in each
> LRU. The LRU with the largest amount of pages will be shrunk/rotated
> first. And on top of that is the guarantee logic and the
> reclaim_mapped threshold, ie the unmapped LRU will be shrunk first by
> default.

that sounds wrong, you lose history this way. There is NO reason to
shrink only the unmapped LRU and not the mapped one. At minimum you
always need to pressure both. How you pressure (absolute versus
percentage) is an interesting question, but to me there is no doubt that
you always need to pressure both, and "equally" to some measure of equal


