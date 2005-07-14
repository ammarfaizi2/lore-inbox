Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261378AbVGNN04@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbVGNN04 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 09:26:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261381AbVGNN04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 09:26:56 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:22749 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261378AbVGNN0z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 09:26:55 -0400
Date: Thu, 14 Jul 2005 15:26:29 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>
cc: Christoph Hellwig <hch@infradead.org>, zanussi@us.ibm.com,
       linux-kernel@vger.kernel.org, karim@opersys.com, varap@us.ibm.com,
       richardj_moore@uk.ibm.com
Subject: Re: Merging relayfs?
In-Reply-To: <20050711193409.043ecb14.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0507131809120.3743@scrub.home>
References: <17107.6290.734560.231978@tut.ibm.com> <20050712022537.GA26128@infradead.org>
 <20050711193409.043ecb14.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 11 Jul 2005, Andrew Morton wrote:

> > > Hi Andrew, can you please merge relayfs?  It provides a low-overhead
> > > logging and buffering capability, which does not currently exist in
> > > the kernel.
> > 
> > While the code is pretty nicely in shape it seems rather pointless to
> > merge until an actual user goes with it.
> 
> Ordinarily I'd agree.  But this is a bit like kprobes - it's a funny thing
> which other kernel features rely upon, but those features are often ad-hoc
> and aren't intended for merging.

I agree with Christoph, I'd like to see a small (and useful) example 
included, which can be used as reference. relayfs client still need some 
code of their own to communicate with user space. If I look at the example 
code I'm not really sure netlink is a good way to go as control channel.
kprobes has a rather simple interface, relayfs is more complex and I think 
it's a good idea to provide some sane and complete example code to copy 
from.

Looking through the patch there are still a few areas I'm concerned about:
- the usage of atomic_t look a little silly, there is only a single 
writer and probably needs some cache line optimisations
- I would prefer "unsigned int" over just "unsigned"
- the padding/commit arrays can be easily managed by the client
- overwrite mode can be implemented via the buffer switch callback

In general I'm not against merging, but I have a few ideas for further 
cleanups/optimisations and it really would help to have some useful 
example code (e.g. a _simple_ event tracer).

bye, Roman
