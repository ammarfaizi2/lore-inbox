Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261301AbTEABjc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 21:39:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261302AbTEABjc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 21:39:32 -0400
Received: from zero.aec.at ([193.170.194.10]:30993 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S261301AbTEABjb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 21:39:31 -0400
Date: Thu, 1 May 2003 03:51:48 +0200
From: Andi Kleen <ak@muc.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix prefetch patching in 2.5-bk
Message-ID: <20030501015148.GB3616@averell>
References: <20030501001511.GA2890@averell> <Pine.LNX.4.44.0304301814010.20283-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0304301814010.20283-100000@home.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 01, 2003 at 03:21:52AM +0200, Linus Torvalds wrote:
> and making "sourcelen==0" a special case for replacement (replace with the 
> proper destination length nop, instead of having that "0x90 0x90 0x90" 
> sequence).

Note sure what you mean with 0x90 sequence.

My original implementation used .rept to generate the correct number of 
(single byte) nops based on the label length of the other case. 
But it didn't work because I ran into at least one weird assembler bug (it internally 
got confused on something and gave an impossible error message about a
missing label). Also it only generated single byte nops.

In any case you need to pad the code to the correct number of bytes,
I'm not sure how it can be done otherwise.

-Andi
