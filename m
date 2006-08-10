Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161058AbWHJGLD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161058AbWHJGLD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 02:11:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161060AbWHJGLB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 02:11:01 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:36739 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1161057AbWHJGK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 02:10:59 -0400
Date: Thu, 10 Aug 2006 15:13:05 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: clameter@sgi.com, mpm@selenic.com, npiggin@suse.de,
       manfred@colorfullife.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Simple Slab: A slab allocator with minimal meta
 information
Message-Id: <20060810151305.bc4602e0.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060810144451.13591e4b.kamezawa.hiroyu@jp.fujitsu.com>
References: <Pine.LNX.4.64.0608091744290.4966@schroedinger.engr.sgi.com>
	<20060810140153.e5932e76.kamezawa.hiroyu@jp.fujitsu.com>
	<Pine.LNX.4.64.0608092211320.5806@schroedinger.engr.sgi.com>
	<20060810144451.13591e4b.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2006 14:44:51 +0900
KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:
> > If you do that then you loose the cache hot advantage. It is advantageous 
> > to initialize the object and then immediately use it. If you initialize it 
> > before then the cacheline will be evicted and then brought back.
> 
> hmm, I don't know precise analization of the perfromance benefit of slab on
> current (Linux + Fast CPU/Bus + Large Cache) systems. I'm grad if you show the
> performance of new "Simple Slab" next time.
> 

BTW, in recent Linux, many objects are freed by call_rcu(hoo, dealyed_free_foo).
Objects are freed far after it was touched.
I think catching this kind of freeing will not boost performance by cache-hit if
reuse freed page (object). 

-Kame

