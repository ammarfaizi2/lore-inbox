Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261713AbVC1E6K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261713AbVC1E6K (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 23:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261718AbVC1E6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 23:58:10 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:19586 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261713AbVC1E6E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 23:58:04 -0500
Date: Sun, 27 Mar 2005 20:53:34 -0800
From: Paul Jackson <pj@engr.sgi.com>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: davej@redhat.com, jengelh@linux01.gwdg.de, penberg@gmail.com,
       rlrevell@joe-job.com, linux-os@analogic.com, arjan@infradead.org,
       vda@ilport.com.ua, juhl-lkml@dif.dk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] no need to check for NULL before calling kfree()
 -fs/ext2/
Message-Id: <20050327205334.14a7b3c4.pj@engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0503280033130.2459@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0503252307010.2498@dragon.hyggekrogen.localhost>
	<Pine.LNX.4.61.0503251726010.6354@chaos.analogic.com>
	<1111825958.6293.28.camel@laptopd505.fenrus.org>
	<Pine.LNX.4.61.0503261811001.9945@chaos.analogic.com>
	<Pine.LNX.4.62.0503270044350.3719@dragon.hyggekrogen.localhost>
	<1111881955.957.11.camel@mindpipe>
	<Pine.LNX.4.62.0503271246420.2443@dragon.hyggekrogen.localhost>
	<20050327065655.6474d5d6.pj@engr.sgi.com>
	<Pine.LNX.4.61.0503271708350.20909@yvahk01.tjqt.qr>
	<20050327174026.GA708@redhat.com>
	<Pine.LNX.4.62.0503280033130.2459@dragon.hyggekrogen.localhost>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper wrote:
> What I'm trying to find out now is if there's a general consensus that 
> these patches are worthwile and wanted or if they are unwanted and I'm 
> wasting my time. 

Thanks for your good work so far, and your good natured tolerance of
the excessively detailed discussions resulting.

I don't have a big preference either way - but a couple of questions:

 1) Do you have any wild guess of how many of these you've done so far,
    and how many potentially remain that could be done?  Tens, hundreds,
    thousands?

 2) Any idea what was going on with the numbers you posted yesterday,
    which, at least from what I saw at first glance, seemed to show
    "if (likely(p)) kfree(p);" to be a good or best choice, for all
    cases, including (p != NULL) being very unlikely?  That seemed
    like a weird result.

If the use of "likely(p)" is almost always a winner, then the changes
you've been doing, followed by a header file change:

	static inline void kfree(const void *p)
	{
		if (likely(p))
			__kfree(p);	/* __kfree(p) doesn't check for NULL p */
	}

along the lines that Jan considered a few posts ago, might be a winner.

But since this "likely(p)" result seems so bizarre, it seems unlikely that
the above kfree wrapper would be a winner.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
