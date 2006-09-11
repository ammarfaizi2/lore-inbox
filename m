Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750760AbWIKU2X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbWIKU2X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 16:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbWIKU2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 16:28:22 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:29592 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750760AbWIKU2W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 16:28:22 -0400
Date: Mon, 11 Sep 2006 13:29:08 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Oliver Neukum <oliver@neukum.org>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       David Howells <dhowells@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Uses for memory barriers
Message-ID: <20060911202908.GF1295@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <200609090049.20416.oliver@neukum.org> <Pine.LNX.4.44L0.0609082216070.8541-100000@netrider.rowland.org> <20060911162059.GA1496@us.ibm.com> <200609112148.42302.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200609112148.42302.oliver@neukum.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2006 at 09:48:42PM +0200, Oliver Neukum wrote:
> Am Montag, 11. September 2006 18:21 schrieb Paul E. McKenney:
> > 1.      A given CPU will always perceive its own memory operations
> >         as occuring in program order.
> 
> Is this true for physical memory if virtually indexed caches are
> involved?

As I understand it, in systems with virtually indexed caches, the OS must
take care to ensure that a given cacheline appears only once in the cache,
even if it is mapped to multiple virtual addresses.  If an OS failed to
do this, then, as far as I can see, all bets are off.  Curt Schimmel's
book "UNIX(R) Systems for Modern Architectures: Symmetric Multiprocessing
and Caching for Kernel Programmers" is an excellent guide to the issues
posed by virtually indexed and virtually tagged caches.

In principle, one could construct a virtually indexed/tagged CPU cache 
that automatically ejected any line with a conflicting physical address
(given that lookups are presumably much more frequent than loading new
cache lines), but I have no idea if any real hardware takes this approach.
I have had the good fortune to always work with physically tagged/indexed
caches.  ;-)

						Thanx, Paul
