Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932440AbVIFHsg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440AbVIFHsg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 03:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932441AbVIFHsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 03:48:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:42219 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932440AbVIFHsg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 03:48:36 -0400
From: Andi Kleen <ak@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: RFC: i386: kill !4KSTACKS
Date: Tue, 6 Sep 2005 09:50:16 +0200
User-Agent: KMail/1.8
Cc: Denis Vlasenko <vda@ilport.com.ua>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       lkml <linux-kernel@vger.kernel.org>
References: <20050904145129.53730.qmail@web50202.mail.yahoo.com> <200509060913.59822.ak@suse.de> <1125991977.5138.6.camel@npiggin-nld.site>
In-Reply-To: <1125991977.5138.6.camel@npiggin-nld.site>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509060950.16752.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Are there still good reasons to have such a thing?

I think so yes. It just doesn't make much sense to handle larger 64bit
setups with multiple GB of memory with 4K pages.  While larger softpage
size will not increase TLB usage it will give you less cache use and in
general less cycles while accessing mem_map and while doing VM operations in 
general. Other benefits are faster TLB flush (I saw some bottlenecks
with that in 2.4 on large systems) 

Simple example: you have to handle a few GB of memory in the LRU
list. Doing it with half as many objects (8k page instead of 4k) is much more 
efficient.

-Andi
