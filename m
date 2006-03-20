Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964989AbWCTVsv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964989AbWCTVsv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 16:48:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964996AbWCTVsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 16:48:51 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:48872 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S964989AbWCTVss (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 16:48:48 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCH][3/3] mm: swsusp post resume aggressive swap prefetch
Date: Mon, 20 Mar 2006 22:47:37 +0100
User-Agent: KMail/1.9.1
Cc: linux list <linux-kernel@vger.kernel.org>, ck list <ck@vds.kolivas.org>,
       Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       linux-mm@kvack.org
References: <200603200234.01472.kernel@kolivas.org>
In-Reply-To: <200603200234.01472.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603202247.38576.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sunday 19 March 2006 16:34, Con Kolivas wrote:
> 
> Swsusp reclaims a lot of memory during the suspend cycle and can benefit
> from the aggressive_swap_prefetch mode immediately upon resuming.

It slows down the resume on my box way too much.  Last time it took 10x more
time than actually reading the image.

I think the problem is for the userland suspend (which I use) it's done too early,
when the image pages are still in the swap, so they are taken into consideration
by the aggressive prefetch.  If that really is the case, the solution would be to
trigger the aggressive prefetch from the userland, if needed, after the image
pages have been released.

Greetings,
Rafael
