Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262047AbTDNQvh (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 12:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263563AbTDNQvh (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 12:51:37 -0400
Received: from 217-125-129-224.uc.nombres.ttd.es ([217.125.129.224]:38123 "HELO
	cocodriloo.com") by vger.kernel.org with SMTP id S262047AbTDNQvd (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 12:51:33 -0400
Date: Mon, 14 Apr 2003 19:14:19 +0200
From: Antonio Vargas <wind@cocodriloo.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Antonio Vargas <wind@cocodriloo.com>,
       Timothy Miller <tmiller10@cfl.rr.com>, linux-kernel@vger.kernel.org,
       nicoya@apia.dhs.org
Subject: Re: Quick question about hyper-threading (also some NUMA stuff)
Message-ID: <20030414171419.GG14552@wind.cocodriloo.com>
References: <001301c3028a$25374f30$6801a8c0@epimetheus> <10760000.1050332136@[10.10.2.4]> <20030414152947.GB14552@wind.cocodriloo.com> <12790000.1050334744@[10.10.2.4]> <20030414155748.GD14552@wind.cocodriloo.com> <14860000.1050337484@[10.10.2.4]> <20030414164321.GE14552@wind.cocodriloo.com> <15700000.1050338226@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15700000.1050338226@[10.10.2.4]>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 14, 2003 at 09:37:07AM -0700, Martin J. Bligh wrote:
> >> OK, unless I misunderstand you, I think that happens naturally for that
> >> kind of thing - when we do the COW split, we'll get a node-local page
> >> by default (unless the local node is out of memory).
> >
> > Yes, it happens naturaly, but it's done when we try to write to it.
> > What I meant was, at fork time, it we are forking to a different node,
> > instead of COW-marking, do the COW-mark and the immediately do a sort-of
> > for_each_page(touch_as_if_written(page)), so that nodes would not have to
> > reference the memory from others.
> 
> Ah, you probably don't want to do that ... it's very expensive. Moreover,
> if you exec 2ns later, all the effort will be wasted ... and it's very hard
> to deterministically predict whether you'll exec or not (stupid UNIX 
> semantics). Doing it lazily is probably best, and as to "nodes would not 
> have to reference the memory from others" - you're still doing that, you're
> just batching it on the front end.

True... What about a vma-level COW-ahead just like we have a file-level
read-ahead, then? I mean batching the COW at unCOW-because-of-write time.

btw, COW-ahead sound really silly :)

> > I don't know if it's really usefull, and anyways I could not try to code it
> > unless there is a sort of NUMA simulator for "normal" machines.
> 
> There isn't, but writing one would be very useful (and fairly simple) if
> you have a 2x machine or something that you could use. I've thought about
> writing this several times ... just haven't got round to it.
> 
> M.

Not possible for me since I've got no SMP. But posting a quick note about
your proposed "fake-NUMA-on-SMP.patch" would be good only if to have an
offsite (offbrain also? ;) backup of your ideas :)
