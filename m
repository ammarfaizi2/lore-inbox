Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261410AbULTEdw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261410AbULTEdw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Dec 2004 23:33:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261413AbULTEdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Dec 2004 23:33:52 -0500
Received: from smtp109.mail.sc5.yahoo.com ([66.163.170.7]:53165 "HELO
	smtp109.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261410AbULTEdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Dec 2004 23:33:50 -0500
Subject: Re: 2.6.10-rc3: kswapd eats CPU on start of memory-eating task
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Rik van Riel <riel@redhat.com>
Cc: Con Kolivas <kernel@kolivas.org>, Mikhail Ramendik <mr@ramendik.ru>,
       Andrew Morton <akpm@digeo.com>, lista4@comhem.se,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0412192220450.4315@chimarrao.boston.redhat.com>
References: <14514245.1103496059334.JavaMail.tomcat@pne-ps4-sn2>
	 <41C6073B.6030204@yahoo.com.au> <20041219155722.01b1bec0.akpm@digeo.com>
	 <200412200303.35807.mr@ramendik.ru> <41C640DE.7050002@kolivas.org>
	 <Pine.LNX.4.61.0412192220450.4315@chimarrao.boston.redhat.com>
Content-Type: text/plain
Date: Mon, 20 Dec 2004 15:33:45 +1100
Message-Id: <1103517225.5093.12.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-12-19 at 22:21 -0500, Rik van Riel wrote:
> On Mon, 20 Dec 2004, Con Kolivas wrote:
> 
> > I still suspect the thrash token patch even with the swap token timeout 
> > at 0. Is it completely disabled at 0 or does it still do something?
> 
> It makes it harder to page out pages from the task holding the
> token.  I wonder if kswapd should try to steal the token away
> from the task holding it, so in effect nobody holds the token
> when the system isn't under a heavy swapping load.
> 

In that case, the first thing we need to do is disable thrash token
completely, and retest that. We still don't know for sure that it is
the problem.

I don't have the code in front of me at the moment, but I'll be able
to send a patch to do that in a couple of hours, if nobody beats me
to it.

Nick


