Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272366AbTHIOeV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 10:34:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272367AbTHIOeV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 10:34:21 -0400
Received: from waste.org ([209.173.204.2]:16066 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S272366AbTHIOeU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 10:34:20 -0400
Date: Sat, 9 Aug 2003 09:33:14 -0500
From: Matt Mackall <mpm@selenic.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, jmorris@intercode.com.au, davem@redhat.com
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
Message-ID: <20030809143314.GT31810@waste.org>
References: <20030809074459.GQ31810@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030809074459.GQ31810@waste.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 09, 2003 at 02:44:59AM -0500, Matt Mackall wrote:
> The attached (lightly tested) patch gets rid of the SHA in the
> /dev/random code and replaces it with cryptoapi, leaving us with just
> one SHA implementation. It also updates syncookies. This code is
> already at about 125% of baseline throughput, and can probably reach
> 250% with some tweaking of cryptoapi's redundant padding (in case
> anyone else cares about being able to get 120Mb/s of cryptographically
> strong random data).
> 
> The potentially controversial part is that the random driver is
> currently non-optional and this patch would make cryptoapi
> non-optional as well. I plan to cryptoapi-ify the outstanding
> MD5 instance as well.

Some details I left out at 3am:

- this code is just a proof of concept
- the random number generator is non-optional because it's used
  various things from filesystems to networking
- the cryptoapi layer is itself quite thin (the .o is about 2.8k
  stripped on my box)

An alternative approach is to subvert cryptoapi by pulling the core
transform out of the SHA1 module and putting it in the core with hooks
so /dev/random can get at it directly. Downsides are subverting the
api and losing pluggability. Upsides are avoiding api overhead and
potential sleeping.

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
