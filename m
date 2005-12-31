Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932135AbWAASVh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbWAASVh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jan 2006 13:21:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbWAASVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jan 2006 13:21:37 -0500
Received: from mail.suse.de ([195.135.220.2]:39853 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932135AbWAASVh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jan 2006 13:21:37 -0500
From: Andi Kleen <ak@suse.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: [POLL] SLAB : Are the 32 and 192 bytes caches really usefull on x86_64 machines ?
Date: Sat, 31 Dec 2005 21:13:53 +0100
User-Agent: KMail/1.8.2
Cc: Matt Mackall <mpm@selenic.com>, Denis Vlasenko <vda@ilport.com.ua>,
       Eric Dumazet <dada1@cosmosbay.com>, linux-kernel@vger.kernel.org
References: <7vbqzadgmt.fsf@assigned-by-dhcp.cox.net> <20051228210124.GB1639@waste.org> <20051230211340.GA3672@dmt.cnet>
In-Reply-To: <20051230211340.GA3672@dmt.cnet>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512312113.53962.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 30 December 2005 22:13, Marcelo Tosatti wrote:
> 
> <snip>
> 
> > > Note that just looking at slabinfo is not enough for this - you need the
> > > original
> > > sizes as passed to kmalloc, not the rounded values reported there.
> > > Should be probably not too hard to hack a simple monitoring script up
> > > for that
> > > in systemtap to generate the data.
> > 
> > Something like this:
> > 
> > http://lwn.net/Articles/124374/
> 
> Written with a systemtap script: 
> http://sourceware.org/ml/systemtap/2005-q3/msg00550.html

I had actually written a similar script on my own before,
but I found it was near completely unusable on a 4core Opteron
system even under moderate load because systemtap bombed out 
when it needed more than one spin to take the lock of the 
shared hash table.

(it basically did if (!spin_trylock()) ... stop script; ...) 

The problem was that the backtraces took so long that another
CPU very often run into the locked lock.

Still with a stripped down script without backtraces had some
interesting results. In particular my init was reading some 
file in /proc 10 times a second, allocating 4K (wtf did it do that?) and
some other somewhat surprising results.

-Andi
