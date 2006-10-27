Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965246AbWJ0IpJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965246AbWJ0IpJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 04:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965254AbWJ0IpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 04:45:09 -0400
Received: from tim.rpsys.net ([194.106.48.114]:8649 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S965246AbWJ0IpH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 04:45:07 -0400
Subject: Re: [PATCH, RFC/T] Fix handling of write failures to swap devices
From: Richard Purdie <rpurdie@openedhand.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: kernel list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <4541C1B2.7070003@yahoo.com.au>
References: <1161935995.5019.46.camel@localhost.localdomain>
	 <4541C1B2.7070003@yahoo.com.au>
Content-Type: text/plain
Date: Fri, 27 Oct 2006 09:44:54 +0100
Message-Id: <1161938694.5019.83.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-10-27 at 18:22 +1000, Nick Piggin wrote:
> Richard Purdie wrote:
> > Comments and testing from people who know this area of code better than
> > me would be appreciated!
> 
> This is the right approach to handling swap write errors. However, you need
> to cut down on the amount of code duplication. 

The code is subtly different to the swapoff code but I'll take another
look and see if I can refactor it now I have it all working.

> Also, if you hit that BUG_ON, then you probably have a bug, don't
> remove it!

I gave that a lot of thought. We are in a write handler and have to
handle the write error from there so the page will be marked as
writeback. That function appears to be safe to call with that set
through the new code path I added (which wouldn't have happened in the
past). I therefore decided it was safe and the simplest solution was to
remove the BUG_ON. If anyone can see a problem with a page being in
writeback in that function, please enlighten me though!

Cheers,

Richard

