Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262080AbUEQS0n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262080AbUEQS0n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 14:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbUEQS0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 14:26:43 -0400
Received: from mailwasher.lanl.gov ([192.16.0.25]:14812 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S262080AbUEQS0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 14:26:41 -0400
Subject: Re: 1352 NUL bytes at the end of a page?
From: Steven Cole <scole@lanl.gov>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: hugh@veritas.com, linux-kernel@vger.kernel.org, support@bitmover.com,
       Linus Torvalds <torvalds@osdl.org>, Wayne Scott <wscott@bitmover.com>,
       adi@bitmover.com, Andrew Morton <akpm@osdl.org>, wli@holomorphy.com,
       lm@bitmover.com, "Theodore Ts'o" <tytso@mit.edu>
In-Reply-To: <20040517174004.GU17014@parcelfarce.linux.theplanet.co.uk>
References: <200405162136.24441.elenstev@mesatop.com>
	 <Pine.LNX.4.58.0405162152290.25502@ppc970.osdl.org>
	 <20040516231120.405a0d14.akpm@osdl.org>
	 <20040517.085640.30175416.wscott@bitmover.com>
	 <20040517151738.GA4730@thunk.org>
	 <Pine.LNX.4.58.0405170820560.25502@ppc970.osdl.org>
	 <20040517153736.GT17014@parcelfarce.linux.theplanet.co.uk>
	 <E88DCF88-A827-11D8-A7EA-000A95CC3A8A@lanl.gov>
	 <20040517174004.GU17014@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Message-Id: <1084815598.26340.6.camel@spc0.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5-4mdk 
Date: Mon, 17 May 2004 11:39:58 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-05-17 at 11:40, viro@parcelfarce.linux.theplanet.co.uk
wrote:
> On Mon, May 17, 2004 at 11:30:36AM -0600, Steven Cole wrote:
>  
> > mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 
> > 0) = 0x40018000
> 
> rw anonymous - that has nothing to do with any IO.
> 
> > old_mmap(NULL, 19184, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40018000
> 
> read-only, whatever file that was.
> 
> Was there anything with PROT_WRITE and without MAP_ANONYMOUS?

Yes, seven of the 52 references to mmap in the strace output met
the above criteria: 

  old_mmap(0x4015f000, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x142000) = 0x4015f000
  old_mmap(0x40170000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x9000) = 0x40170000
  old_mmap(0x40180000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 4, 0x9000) = 0x40180000
  old_mmap(0x40191000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 4, 0x10000) = 0x40191000
  old_mmap(0x4019c000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 4, 0x7000) = 0x4019c000
  old_mmap(0x401a0000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 4, 0x3000) = 0x401a0000
  old_mmap(0x401af000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 4, 0xe000) = 0x401af000


Steven 

