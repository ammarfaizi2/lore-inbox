Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262801AbTEAXzg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 19:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262805AbTEAXzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 19:55:36 -0400
Received: from mx12.arcor-online.net ([151.189.8.88]:22205 "EHLO
	mx12.arcor-online.net") by vger.kernel.org with ESMTP
	id S262801AbTEAXzf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 19:55:35 -0400
From: Daniel Phillips <dphillips@sistina.com>
Reply-To: dphillips@sistina.com
Organization: Sistina
To: Thomas Schlichter <schlicht@uni-mannheim.de>,
       Willy TARREAU <willy@w.ods.org>, hugang <hugang@soulinfo.com>
Subject: Re: [RFC][PATCH] Faster generic_fls
Date: Fri, 2 May 2003 02:13:41 +0200
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org, akpm@digeo.com
References: <200304300446.24330.dphillips@sistina.com> <20030501171627.GA1785@pcw.home.local> <200305020127.26279.schlicht@uni-mannheim.de>
In-Reply-To: <200305020127.26279.schlicht@uni-mannheim.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305020213.41721.dphillips@sistina.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 02 May 2003 01:27, Thomas Schlichter wrote:
> ...So for me the table version seems to be the slowest one. The BSRL
> instruction on the K6-III seems to be very slow, too. The tree and my shift
> version are faster than the original version here...
>
> That someone else can test my fls_shift version I'll provide it here again:
> static inline int fls_shift(int x)
> {
> 	int bit = 32;
>
> 	while(x > 0) {
> 		--bit;
> 		x <<= 1;
> 	}
>
> 	return x ? bit : 0;
> }

Your shift version is the fastest on the PIII as well, finishing in 45.3 
seconds vs 53.4 for my original, and using only 12 bytes of text.  This was a 
big surprise.  The time was the same, whether I inlined it or not.  I take 
this to mean that -O3 inlines such a short function in either case.

Regards,

Daniel
