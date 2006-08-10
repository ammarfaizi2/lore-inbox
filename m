Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161061AbWHJGLH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161061AbWHJGLH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 02:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161060AbWHJGLG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 02:11:06 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:51899 "EHLO
	amsfep20-int.chello.nl") by vger.kernel.org with ESMTP
	id S1161057AbWHJGLE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 02:11:04 -0400
Subject: Re: [RFC][PATCH 0/9] Network receive deadlock prevention for NBD
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: David Miller <davem@davemloft.net>
Cc: johnpol@2ka.mipt.ru, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, phillips@google.com
In-Reply-To: <20060809.165431.118952392.davem@davemloft.net>
References: <1155127040.12225.25.camel@twins>
	 <20060809130752.GA17953@2ka.mipt.ru> <1155130353.12225.53.camel@twins>
	 <20060809.165431.118952392.davem@davemloft.net>
Content-Type: text/plain
Date: Thu, 10 Aug 2006 08:06:28 +0200
Message-Id: <1155189988.12225.100.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-09 at 16:54 -0700, David Miller wrote:
> From: Peter Zijlstra <a.p.zijlstra@chello.nl>
> Date: Wed, 09 Aug 2006 15:32:33 +0200
> 
> > The idea is to drop all !NFS packets (or even more specific only
> > keep those NFS packets that belong to the critical mount), and
> > everybody doing critical IO over layered networks like IPSec or
> > other tunnel constructs asks for trouble - Just DON'T do that.
> 
> People are doing I/O over IP exactly for it's ubiquity and
> flexibility.  It seems a major limitation of the design if you cancel
> out major components of this flexibility.

We're not, that was a bit of my own frustration leaking out; I think 
this whole push to IP based storage is a bit silly. I'm just not going 
to help the admin who's server just hangs because his VPN key expired.

Running critical resources remotely like this is tricky, and every 
hop/layer you put in between increases the risk of something going bad.
The only setup I think even remotely sane is a dedicated network in the
very same room - not unlike FC but cheaper (which I think is the whole
push behind this, eth is cheap)


