Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262635AbVA0Q71@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262635AbVA0Q71 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 11:59:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262666AbVA0Q6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 11:58:38 -0500
Received: from rain.plan9.de ([193.108.181.162]:54196 "EHLO rain.plan9.de")
	by vger.kernel.org with ESMTP id S262635AbVA0Q4a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 11:56:30 -0500
Date: Thu, 27 Jan 2005 17:56:28 +0100
From: <pcg@goof.com ( Marc) (A.) (Lehmann )>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: critical bugs in md raid5
Message-ID: <20050127165628.GB7474@schmorp.de>
Mail-Followup-To: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
References: <20050127035906.GA7025@schmorp.de> <m1vf9j4fsp.fsf@muc.de> <20050127063131.GA29574@schmorp.de> <20050127095102.GA88779@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050127095102.GA88779@muc.de>
X-PGP: "1024D/DA743396 1999-01-26 Marc Alexander Lehmann <schmorp@schmorp.de>
       Key fingerprint = 475A FE9B D1D4 039E 01AC  C217 A1E8 0270 DA74 3396"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2005 at 10:51:02AM +0100, Andi Kleen <ak@muc.de> wrote:
> The nasty part there is that it can affect completely unrelated
> data too (on a traditional disk you normally only lose the data
> that is currently being written) because of of the relationship
> between stripes on different disks.

Sorry, I must be a bit dense at times I understood that now, you meant in
the case where parity is lost and you have an I/O error in other cases.

> There were some suggestions in the past 
> to be a bit nicer on read IO errors - often if a read fails and you rewrite 
> the block from the reconstructed data the disk would allocate a new block
> and then be error free again.
> 
> The problem is just that when there are user visible IO errors
> on a modern disk something is very wrong and it will likely run quickly out 

Also, linux already does re-write failed parity blocks automatically on
a crash, so whatever damage you might think might be done to the disk
will already be done at numerous occasions, as linux in general nor the
raid driver in particular checks for bad blocks before rewriting (I don't
suggets that it does, just that linux already rewrites failed blocks if it
doesn't know about them, and this hasn't been a particular bad problem).

-- 
                The choice of a
      -----==-     _GNU_
      ----==-- _       generation     Marc Lehmann
      ---==---(_)__  __ ____  __      pcg@goof.com
      --==---/ / _ \/ // /\ \/ /      http://schmorp.de/
      -=====/_/_//_/\_,_/ /_/\_\      XX11-RIPE
