Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261696AbVF0BGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261696AbVF0BGN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 21:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261694AbVF0BGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 21:06:13 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:65503 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261697AbVF0BFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 21:05:43 -0400
Date: Sun, 26 Jun 2005 16:09:44 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: "David S. Miller" <davem@davemloft.net>, Dan Malek <dan@embeddededge.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: increased translation cache footprint in v2.6
Message-ID: <20050626190944.GC6091@logos.cnet>
References: <20050626172334.GA5786@logos.cnet> <20050626164939.2f457bf6.akpm@osdl.org> <20050626185210.GB6091@logos.cnet> <20050626.173338.41634345.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050626.173338.41634345.davem@davemloft.net>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 26, 2005 at 05:33:38PM -0700, David S. Miller wrote:
> From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
> Date: Sun, 26 Jun 2005 15:52:10 -0300
> 
> > Well, a TLB entry might cache different sized pages. The platform
> > support 4kb, 16kb and 8Mb (IIRC, maybe some other size also).  The
> > bigger pages (8Mb) are only used to map 8Mbytes of instruction at
> > KERNELBASE, 24Mbytes of data (3 8Mbyte entries) also at KERNELBASE
> > and another 8Mbytes of the configuration registers memory space,
> > which lives outside RAM space.
> 
> Why don't you use 8MB TLB entries when there is a miss to
> one of the PAGE_OFFSET pages?  I'm not saying to lock them,
> just to use large 8MB TLB entries when a miss is taken for
> kernel data accesses to where the kernel maps all of lowmem.

David, 

Thats a very interesting idea, will probably optimize performance in 
general ("why did nobody thought of it before?" kind). 

The increase in TLB miss handler size might be offset by the reduced
kernel misses...

Dan, what do you think? 
