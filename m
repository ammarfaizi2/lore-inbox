Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965183AbVINOWL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965183AbVINOWL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 10:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965189AbVINOWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 10:22:11 -0400
Received: from nevyn.them.org ([66.93.172.17]:5068 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S965183AbVINOWJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 10:22:09 -0400
Date: Wed, 14 Sep 2005 10:22:04 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Markus F.X.J. Oberhumer" <markus@oberhumer.com>,
       linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] i386: fix stack alignment for signal handlers
Message-ID: <20050914142204.GA19731@nevyn.them.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	"Markus F.X.J. Oberhumer" <markus@oberhumer.com>,
	linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
References: <43273CB3.7090200@oberhumer.com> <Pine.LNX.4.58.0509131542510.26803@g5.osdl.org> <4327611D.7@oberhumer.com> <Pine.LNX.4.58.0509131649060.26803@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0509131649060.26803@g5.osdl.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2005 at 04:52:30PM -0700, Linus Torvalds wrote:
> Your test program does seems to imply that gcc wants the alignment before
> the return address (ie it prints out an address that is 4 bytes offset),
> but on the other hand I'm not even sure how careful gcc is about this
> alignment thing at all.

Very, on architectures where the ABI requires alignment.  E.G. for
vector register loads that require 16-byte alignment to avoid a trap.

The comment for the relevant bits of the GCC configuration says it
won't assume this for x86, but I believe that comment is out of date.
I think it'll assume 16-byte alignment on entrance to non-main()
functions.

> In the "main()" function, gcc will actually generate a "andl $-16,%esp" to 
> force the alignment, but ot in the handler function. Just a gcc special 
> case? Random luck?

Special case.  This is only done for main().

-- 
Daniel Jacobowitz
CodeSourcery, LLC
