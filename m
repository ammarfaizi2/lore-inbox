Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262068AbUKKABp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262068AbUKKABp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 19:01:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262147AbUKKABp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 19:01:45 -0500
Received: from ozlabs.org ([203.10.76.45]:48279 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262068AbUKKABn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 19:01:43 -0500
Date: Thu, 11 Nov 2004 10:48:05 +1100
From: David Gibson <hermes@gibson.dropbear.id.au>
To: Bryan Batten <BryanBatten@compuserve.com>
Cc: Pavel Roskin <proski@gnu.org>,
       Trivial Patch Monkey <trivial@rustcorp.com.au>,
       linux-kernel@vger.kernel.org
Subject: Re: Warning Fix drivers/net/wireless in Kernel 2.6.9
Message-ID: <20041110234805.GB12725@zax>
Mail-Followup-To: David Gibson <hermes@gibson.dropbear.id.au>,
	Bryan Batten <BryanBatten@compuserve.com>,
	Pavel Roskin <proski@gnu.org>,
	Trivial Patch Monkey <trivial@rustcorp.com.au>,
	linux-kernel@vger.kernel.org
References: <41927F5F.4080204@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41927F5F.4080204@compuserve.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2004 at 12:51:43PM -0800, Bryan Batten wrote:
> The patch removes the "makes pointer from integer without a cast"
> warnings in orinoco code by casting the appropriate parameter to
> readw, writew as (void *) in the header file hermes.h.
> 
> The underlying problem is that readw/writes boil down to low level
> calls that take a pointer, while inw/outw boil down (eventually) to
> low level calls that take an int. So the choice was to either cast
> inw, outw parameters as (int)'s, or cast readw, writew parameters as
> (void *). I chose the latter.
> 
> I suspect the truly "best" fix would be to change the underlying
> inx/outx definitions to accept a pointer, so's to be consistent
> with the definitions of readx/writex, but that would probably break
> other stuff.

That's what the new ioread*() and iowrite*() functions are for.  Al
Viro has already made a fix to use these, and it is in the netdev bk
tree.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist.  NOT _the_ _other_ _way_
				| _around_!
http://www.ozlabs.org/people/dgibson
