Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751183AbWCaBmG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbWCaBmG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 20:42:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbWCaBmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 20:42:06 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:55760 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751183AbWCaBmF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 20:42:05 -0500
Date: Thu, 30 Mar 2006 17:40:22 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: linux@horizon.com
cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Synchronizing Bit operations V2
In-Reply-To: <20060331013346.913.qmail@science.horizon.com>
Message-ID: <Pine.LNX.4.64.0603301738190.2758@schroedinger.engr.sgi.com>
References: <20060331013346.913.qmail@science.horizon.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Mar 2006, linux@horizon.com wrote:

> The only conceivable reason for passing the mode as a separate parameter is
> - To change the mode dynamically at run time.
> - To share common code when the sequence is long and mostly shared
>   between the various modes (as in open(2) or ll_rw_block()).

There is usually quite complex code involved although the code generated 
is minimal.

> On the downside, it's more typing and uglier than a series of
> 
> frob_bit_nonatomic()
> 	(probably temporarily or permanently aliased to frob_bit())
> frob_bit_atomic()
> frob_bit_acquire()
> frob_bit_release()
> frob_bit_barrier()
> 
> functions, and those also prevent you from doing something silly like
> frob_bit(x, y, O_DIRECT).  Also, the MODE_ prefix might be wanted by
> something else.

Ok. We could change the MODE_ prefix but the problem with not passing this 
as a parameter that there are numerous functions derived from bit ops that 
are then also needed in lots of different flavors. Passing a parameter 
cuts down the number of variations dramatically.

