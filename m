Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267234AbSLEF5j>; Thu, 5 Dec 2002 00:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267236AbSLEF5j>; Thu, 5 Dec 2002 00:57:39 -0500
Received: from dp.samba.org ([66.70.73.150]:53924 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267234AbSLEF5h>;
	Thu, 5 Dec 2002 00:57:37 -0500
Date: Thu, 5 Dec 2002 16:05:36 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] generic device DMA implementation
Message-ID: <20021205050536.GE1500@zax.zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	James Bottomley <James.Bottomley@steeleye.com>,
	"Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
References: <20021205023847.GA1500@zax.zax> <200212050313.gB53DXV05743@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212050313.gB53DXV05743@localhost.localdomain>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2002 at 09:13:33PM -0600, James Bottomley wrote:
> david@gibson.dropbear.id.au said:
> > The point is, there has to be an advantage to using consistent memory
> > if it is available AND the possibility of it not being available. 
> 
> I'm really thinking of this from the driver writer's point of view.  The 
> advantage of consistent memory is that you don't have to think about where to 
> place all the sync points (sync points can be really subtle and nasty and an 
> absolute pain---I shudder to recall all of the problems I ran into writing a 
> driver on a fully inconsistent platform).
> 
> The advantage here is that you can code the driver only to use consistent 
> memory and not bother with the sync points (whatever the cost of this is).  
> Most platforms support reasonably cheap consistent memory, so most people 
> simply don't want to bother with inconsistent memory if they can avoid it.
> 
> If you do the sync points, you can specify the
> DMA_CONFORMANCE_NON_CONSISTENT level and have the platform choose
> what type of memory you get.  For a platform which makes memory
> consistent by turning off CPU caching at the page level, it's
> probably better to return non-consistent memory if the driver can
> cope with it.

But if you have the sync points, you don't need a special allocater
for the memory at all - any old RAM will do.  So why not just use
kmalloc() to get it.

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
