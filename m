Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266210AbTCADCu>; Fri, 28 Feb 2003 22:02:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268212AbTCADCt>; Fri, 28 Feb 2003 22:02:49 -0500
Received: from are.twiddle.net ([64.81.246.98]:4773 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S266210AbTCADCt>;
	Fri, 28 Feb 2003 22:02:49 -0500
Date: Fri, 28 Feb 2003 19:12:53 -0800
From: Richard Henderson <rth@twiddle.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390 (7/13): gcc 3.3 adaptions.
Message-ID: <20030228191253.B26656@twiddle.net>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	"Richard B. Johnson" <root@chaos.analogic.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.3.95.1030224143236.14614A-100000@chaos> <Pine.LNX.4.44.0302241259320.13406-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0302241259320.13406-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, Feb 24, 2003 at 01:02:39PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2003 at 01:02:39PM -0800, Linus Torvalds wrote:
> Does gcc still warn about things like
> 
> 	#define COUNT (sizeof(array)/sizeof(element))
> 
> 	int i;
> 	for (i = 0; i < COUNT; i++)
> 		...
> 
> where COUNT is obviously unsigned (because sizeof is size_t and thus 
> unsigned)?

Yes.  We don't do complete value-range propagation to figure
out if a warning is needed.  We only look at the comparison
itself and note that one of the arguments changed signedness
due to forced promotions.


r~
