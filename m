Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272221AbTHDUIG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 16:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272168AbTHDUIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 16:08:05 -0400
Received: from imap.gmx.net ([213.165.64.20]:36285 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S272221AbTHDUHG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 16:07:06 -0400
Message-Id: <5.2.1.1.2.20030804213330.0196e2d0@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Mon, 04 Aug 2003 22:11:15 +0200
To: Con Kolivas <kernel@kolivas.org>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH] O13int for interactivity
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
In-Reply-To: <200308050207.18096.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 02:07 AM 8/5/2003 +1000, Con Kolivas wrote:

>The _major_ change in this patch is that tasks on uninterruptible sleep do 
>not
>earn any sleep avg during that sleep; it is not voluntary sleep so they 
>should
>not get it. This has the effect of stopping cpu hogs from gaining dynamic
>priority during periods of heavy I/O. Very good for the jerks you may
>see in X or audio skips when you start a whole swag of disk intensive cpu 
>hogs
>(eg make -j large number). I've simply dropped all their sleep_avg, but
>weighting it may be more appropriate. This has the side effect that pure
>disk tasks (eg cp) have relatively low priority which is why weighting may
>be better. We shall see.

IMHO, absolute cut off is a very bad idea (btdt, and it _sucked rocks_).

The last thing in the world you want to do is to remove differentiation 
between tasks... try to classify them and make them all the same within 
their class.  For grins, take away all remaining differentiation, and run a 
hefty parallel make.

         -Mike

