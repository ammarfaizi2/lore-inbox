Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264524AbUHGW3e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264524AbUHGW3e (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 18:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264526AbUHGW3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 18:29:34 -0400
Received: from thunk.org ([140.239.227.29]:30658 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S264524AbUHGW3c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 18:29:32 -0400
Date: Sat, 7 Aug 2004 18:26:34 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jean-Luc Cooke <jlcooke@certainkey.com>
Cc: James Morris <jmorris@redhat.com>,
       "YOSHIFUJI Hideaki / ?$B5HF#1QL@" <yoshfuji@linux-ipv6.org>,
       mludvig@suse.cz, cryptoapi@lists.logix.cz, linux-kernel@vger.kernel.org,
       davem@redhat.com
Subject: Re: [PATCH]
Message-ID: <20040807222634.GA15806@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Jean-Luc Cooke <jlcooke@certainkey.com>,
	James Morris <jmorris@redhat.com>,
	"YOSHIFUJI Hideaki / ?$B5HF#1QL@" <yoshfuji@linux-ipv6.org>,
	mludvig@suse.cz, cryptoapi@lists.logix.cz,
	linux-kernel@vger.kernel.org, davem@redhat.com
References: <20040806042852.GD23994@certainkey.com> <Xine.LNX.4.44.0408060040360.20834-100000@dhcp83-76.boston.redhat.com> <20040806125427.GE23994@certainkey.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040806125427.GE23994@certainkey.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2004 at 08:54:27AM -0400, Jean-Luc Cooke wrote:
> That and it's not endian-correct.  There are other issues with random.c (lack
> for forward secrecy in the case of seed discovery, use of the insecure MD4 in
> creating syn and seq# for tcp, the use of halfMD4 and twothridsMD4 is
> madness
> (what is 2/3's of 16!?!), 

This was deliberate becasue sequence number generation could not be
slow for some workloads.  The sequence number attacks that MD4
protects against are tcp hijacking attacks where the attacker is on
the network path ---- if you really want security you'd be using real
crypto for encryption and for integrity protection at the application
layer.

> the use of LFSRs for "mixing" when they're linear,
> the polymonials used are not even primitive, 

The basic idea here is that you can mix in arbitrary amounts of zero
data without destroying the randomness of the pool.  This is
important, and was an explicit design goal.

> the ability for root to wipe-out
> the random pool, the ability for root to access the random seed directly, the
> paper I'm co-authoring will explain all of this).

Yawn.  Root has access to /dev/mem.  Your point?

							- Ted
