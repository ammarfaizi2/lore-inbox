Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262180AbVBJRyn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262180AbVBJRyn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 12:54:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbVBJRyn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 12:54:43 -0500
Received: from mx1.redhat.com ([66.187.233.31]:39348 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262181AbVBJRy1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 12:54:27 -0500
Date: Thu, 10 Feb 2005 12:54:10 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Fruhwirth Clemens <clemens@endorphin.org>
cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       <michal@logix.cz>, <davem@davemloft.net>, <adam@yggdrasil.com>
Subject: Re: [PATCH 01/04] Adding cipher mode context information to crypto_tfm
In-Reply-To: <1108056540.14335.80.camel@ghanima>
Message-ID: <Xine.LNX.4.44.0502101247390.9159-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Feb 2005, Fruhwirth Clemens wrote:

> Why should I pass the first thing of size X as scatterlist, and the
> second thing of size X as linear buffer? 
> 
> I could do that. It would be reasonable, because tweaks are more likely
> to be generated than transmitted, read or whatever. But what for shall I
> narrow the interface? I could also pass a linear mapped buffer as
> scatterlist. This doesn't cause any overhead.
> 
> And switching to a more specific interface would just delay a solution
> of the inherent limitations of kmap's. I guess it will take another half
> year until the next guy stumbles across this (totally undocumented!)
> problem. Why are you pushing to ignore this problem?

What problem?

All you need is the two existing kmaps, for simultaneous processing of 
input & output data at the page level.

The tweak is linearly generated data fed into this process.  It does not 
need to be kmapped.  It is not discontiguous.  There is no need for a 
third or Nth scatterlist.

Making a generic N-way scatterlist processor is pointless overengineering,
causing new problems with non-trivial solutions, for no benefit
whatsoever.


- James
-- 
James Morris
<jmorris@redhat.com>

