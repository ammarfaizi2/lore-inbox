Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317829AbSIEQrE>; Thu, 5 Sep 2002 12:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317836AbSIEQrE>; Thu, 5 Sep 2002 12:47:04 -0400
Received: from dsl-213-023-039-222.arcor-ip.net ([213.23.39.222]:21671 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317829AbSIEQrE>;
	Thu, 5 Sep 2002 12:47:04 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: "Christian Ehrhardt" <ehrhardt@mathematik.uni-ulm.de>
Subject: Re: [RFC] Alternative raceless page free
Date: Thu, 5 Sep 2002 18:31:45 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@transmeta.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org, Christian Ehrhardt <ulcae@in-ulm.de>
References: <3D644C70.6D100EA5@zip.com.au> <E17myRo-00068H-00@starship> <20020905160431.1671.qmail@thales.mathematik.uni-ulm.de>
In-Reply-To: <20020905160431.1671.qmail@thales.mathematik.uni-ulm.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17mzXm-00068j-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 September 2002 18:04, Christian Ehrhardt wrote:
> On Thu, Sep 05, 2002 at 05:21:31PM +0200, Daniel Phillips wrote:
> > ...this particular piece of code can no doubt be considerably
> > simplified, while improving robustness and efficiency at the same time.
> > But that goes beyond the scope of this patch.
> 
> Well yes ;-) There's funny things going on like accessing a page
> after page_cache_release...

You're right about that one too, it should be put_page_nofree, since
freeing the page there is a bug for two reasons: !!page->mapping tells
us there should be a count on the page, and we continue to operate on
the page immediately below.  Thanks again.

-- 
Daniel
