Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263542AbTDNQUj (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 12:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263547AbTDNQUj (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 12:20:39 -0400
Received: from 217-125-129-224.uc.nombres.ttd.es ([217.125.129.224]:44781 "HELO
	cocodriloo.com") by vger.kernel.org with SMTP id S263542AbTDNQUh (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 12:20:37 -0400
Date: Mon, 14 Apr 2003 18:43:21 +0200
From: Antonio Vargas <wind@cocodriloo.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Antonio Vargas <wind@cocodriloo.com>,
       Timothy Miller <tmiller10@cfl.rr.com>, linux-kernel@vger.kernel.org,
       nicoya@apia.dhs.org
Subject: Re: Quick question about hyper-threading (also some NUMA stuff)
Message-ID: <20030414164321.GE14552@wind.cocodriloo.com>
References: <001301c3028a$25374f30$6801a8c0@epimetheus> <10760000.1050332136@[10.10.2.4]> <20030414152947.GB14552@wind.cocodriloo.com> <12790000.1050334744@[10.10.2.4]> <20030414155748.GD14552@wind.cocodriloo.com> <14860000.1050337484@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <14860000.1050337484@[10.10.2.4]>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 14, 2003 at 09:24:45AM -0700, Martin J. Bligh wrote:
> >> > Perhaps it would be good to un-COW pages:
> >> > 
> >> > 1. fork process
> >> > 2. if current node is not loaded, continue as usual
> >> > 3. if current node is loaded:
> >> > 3a. pick unloaded node
> >> > 4b. don't do COW for data pages, but simply copy them to node-local memory
> >> > 
> >> > This way, read-write sharings would be replicated for each node.
> >> 
> >> Sharing read-write stuff is a total nightmare - you have to deal with
> >> all the sync stuff, and invalidation. In real-life scenarios, I really
> >> doubt the complexity is worth it - read-only is quite complex enough,
> >> thanks ;-) 
> > 
> > I mean MAP_PRIVATE stuff, not MAP_SHARED.
> 
> OK, unless I misunderstand you, I think that happens naturally for that
> kind of thing - when we do the COW split, we'll get a node-local page
> by default (unless the local node is out of memory).
> 
> M.
�
IYes, it happens naturaly, but it's done when we try to write to it.
What I meant was, at fork time, it we are forking to a different node,
instead of COW-marking, do the COW-mark and the immediately do a sort-of
for_each_page(touch_as_if_written(page)), so that nodes would not have to
reference the memory from others.

I don't know if it's really usefull, and anyways I could not try to code it
unless there is a sort of NUMA simulator for "normal" machines.

Greets, Antonio.

