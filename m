Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750899AbWGCLJH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbWGCLJH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 07:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750916AbWGCLJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 07:09:07 -0400
Received: from gate.crashing.org ([63.228.1.57]:21933 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750899AbWGCLJG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 07:09:06 -0400
Subject: Re: [PATCH] powerpc:Fix rheap alignment problem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pantelis Antoniou <pantelis.antoniou@gmail.com>
Cc: Rune Torgersen <runet@innovsys.com>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200607020818.27603.pantelis.antoniou@gmail.com>
References: <9FCDBA58F226D911B202000BDBAD467306E04FF6@zch01exm40.ap.freescale.net>
	 <200607011750.05019.pantelis.antoniou@gmail.com>
	 <DCEAAC0833DD314AB0B58112AD99B93B07B36F@ismail.innsys.innovsys.com>
	 <200607020818.27603.pantelis.antoniou@gmail.com>
Content-Type: text/plain
Date: Mon, 03 Jul 2006 21:08:49 +1000
Message-Id: <1151924929.19419.51.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-07-02 at 08:18 +0300, Pantelis Antoniou wrote:
> On Sunday 02 July 2006 06:54, Rune Torgersen wrote:
> > From: Pantelis Antoniou
> > Sent: Sat 7/1/2006 9:50 AM
> > >Since genalloc is the blessed linux thing it might be best to use that & remove
> > >rheap completely. Oh well...
> > 
> > Two problems with genalloc that I can see (for CPM programming):
> > 1) (minor) Does not have a way to specify alignment (genalloc does it for you)
> > 2) (major problerm, at least for me) Does not have a way to allocate a specified address in the pool.
> > 
> > 2 is needed esp when programming MCC drivers, since a lot of the datastructures must be in DP RAM _and_ be in a specific spot. And if you cannot tell the allocator that I am using a specific address, then the allocator might very well give somebody else that portion of RAM. The only solution without a fixed allocator is to allocate ALL memory in the DP RAM and use your own allocator. 
> > 
> 
> Yeah, that too.
> 
> Too bad there are no main tree drivers like that, but they do exist.
> 
> One could conceivably hack genalloc to do that, but will end up with
> something complex too.
> 
> BTW, there are other uEngine based architectures with similar alignment
> requirements.
> 
> So in conclusion, for the in-tree drivers genalloc is sufficient as an cpm memory allocator.
> For some out of tree drivers, it is not.

Sounds like a good enough justification to keep rheap for now then.

Ben.


