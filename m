Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968334AbWLEEqm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968334AbWLEEqm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 23:46:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968349AbWLEEqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 23:46:42 -0500
Received: from smtp.osdl.org ([65.172.181.25]:51105 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968334AbWLEEqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 23:46:42 -0500
Date: Mon, 4 Dec 2006 20:46:33 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Aucoin <Aucoin@Houston.RR.com>
cc: "'Nick Piggin'" <nickpiggin@yahoo.com.au>,
       "'Tim Schmielau'" <tim@physik3.uni-rostock.de>,
       "'Andrew Morton'" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       clameter@sgi.com
Subject: RE: la la la la ... swappiness
In-Reply-To: <200612050402.kB542no9004124@ms-smtp-03.texas.rr.com>
Message-ID: <Pine.LNX.4.64.0612042034060.3542@woody.osdl.org>
References: <200612050402.kB542no9004124@ms-smtp-03.texas.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 4 Dec 2006, Aucoin wrote:
>
> If I'm going to go through all the trouble to change the kernel and maybe
> create a new proc file how much code would I have to touch to create a proc
> file to set something like, let's say, effective memory and have all the vm
> calculations use effective memory as the basis for swap and cache
> calculations?

Considering your /proc/meminfo under load:

	MemTotal:      2075152 kB
	MemFree:        169848 kB
	Buffers:          4360 kB
	Cached:         334824 kB
	SwapCached:          0 kB
	Active:         178692 kB
	Inactive:       271452 kB
	HighTotal:     1179392 kB
	HighFree:         3040 kB
	LowTotal:       895760 kB
	LowFree:        499876 kB
	SwapTotal:      524276 kB
	SwapFree:       524276 kB
	Dirty:               0 kB
	Writeback:           0 kB
	Mapped:         116720 kB
	Slab:            27956 kB
	..

I actually suspect you should be _fairly_ close to such a situation 
already. In particular, the Active and Inactive lists really are fairly 
small, and don't contain the big SHM area, they seem to be just the cache 
and some (a fairly small amount of) anonymous pages.

The above actually confuses me mightily. I _really_ expected the SHM pages 
to show up on the active/inactive lists if it was actually SHM, and they 
don't seem to. What am I missing?

Louis, exactly how do you allocate that big 1.6GB shared area? 

			Linus
