Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262824AbTEBAZJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 20:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262827AbTEBAZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 20:25:09 -0400
Received: from mx12.arcor-online.net ([151.189.8.88]:21712 "EHLO
	mx12.arcor-online.net") by vger.kernel.org with ESMTP
	id S262824AbTEBAZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 20:25:08 -0400
From: Daniel Phillips <dphillips@sistina.com>
Reply-To: dphillips@sistina.com
Organization: Sistina
To: Willy Tarreau <willy@w.ods.org>,
       Thomas Schlichter <schlicht@uni-mannheim.de>
Subject: Re: [RFC][PATCH] Faster generic_fls
Date: Fri, 2 May 2003 02:43:15 +0200
User-Agent: KMail/1.5.1
Cc: Willy TARREAU <willy@w.ods.org>, hugang <hugang@soulinfo.com>,
       linux-kernel@vger.kernel.org, akpm@digeo.com
References: <200304300446.24330.dphillips@sistina.com> <200305020127.26279.schlicht@uni-mannheim.de> <20030502001050.GA25789@alpha.home.local>
In-Reply-To: <20030502001050.GA25789@alpha.home.local>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305020243.15248.dphillips@sistina.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 02 May 2003 02:10, Willy Tarreau wrote:
> At first, I thought you had coded an FFS instead of an FLS. But I realized
> it's valid, and is fast because one half of the numbers tested will not even
> take one iteration.

Aha, and duh.  At 1 million iterations, my binary search clobbers the shift 
version by a factor of four.  At 2**31 iterations, my version also wins, by 
20%.

I should note that the iterations parameter to my benchmark program is deeply 
flawed, since it changes the nature of the input set, not just the number of 
iterations.  Fortunately, all tests I've done have been with 2**32 
iterations, giving a perfectly uniform distribution of input values.

For uniformly distributed inputs the simple shift loop does well, but for 
calculating floor(log2(x)) it's much worse than the fancier alternatives.  I 
suspect typical usage leans more to the latter than the former.

Regards,

Daniel
