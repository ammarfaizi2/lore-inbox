Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262161AbUCEC0O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 21:26:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262163AbUCEC0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 21:26:14 -0500
Received: from 104.engsoc.carleton.ca ([134.117.69.104]:63892 "EHLO
	quickman.certainkey.com") by vger.kernel.org with ESMTP
	id S262161AbUCEC0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 21:26:13 -0500
Date: Thu, 4 Mar 2004 21:14:01 -0500
From: Jean-Luc Cooke <jlcooke@certainkey.com>
To: dean gaudet <dean-list-linux-kernel@arctic.org>
Cc: Christophe Saout <christophe@saout.de>,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: dm-crypt, new IV and standards
Message-ID: <20040305021401.GA13805@certainkey.com>
References: <20040220172237.GA9918@certainkey.com> <Xine.LNX.4.44.0402201624030.7335-100000@thoron.boston.redhat.com> <20040221164821.GA14723@certainkey.com> <Pine.LNX.4.58.0403022352080.12846@twinlark.arctic.org> <20040303150647.GC1586@certainkey.com> <Pine.LNX.4.58.0403031735210.26196@twinlark.arctic.org> <20040304132430.GA8213@certainkey.com> <Pine.LNX.4.58.0403041702180.794@twinlark.arctic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0403041702180.794@twinlark.arctic.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2004 at 05:19:26PM -0800, dean gaudet wrote:
> On Thu, 4 Mar 2004, Jean-Luc Cooke wrote:
> 
> > recommend using a MAC with CTR.  (Why still have CTR?  Unlike CBC, you can
> > compute the N+1-th block without needing to know the output from the N-th
> > block, so there is the possibility for very high parallelizum).
> 
> for disk crypto there are other opportunities for parallelism using
> bitslicing to encrypt/decrypt multiple blocks in parallel (for example see
> <http://www.cs.utexas.edu/users/atri/papers/spaa.ps>).  there's a
> latency/throughput tradeoff though...

Humm.  Though AES uses GF's a lot, I think on 32bit processors bit slicing
AES just isn't worth it.

Though 512 byte fs blocks would only take 16 "transforms".  It's really hard
to implement ShiftRow() in bitwise SIMD...and x86 cpus simply don't have
enough registers (aliased or otherwise) to do this I think.  Fun read though!

JLC - bit-slicing MD5() will not improve things either, tried that for MD5CRK

-- 
http://www.certainkey.com
Suite 4560 CTTC
1125 Colonel By Dr.
Ottawa ON, K1S 5B6
