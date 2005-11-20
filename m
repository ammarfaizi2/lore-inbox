Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751206AbVKTKgu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbVKTKgu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 05:36:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbVKTKgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 05:36:50 -0500
Received: from mtaout3.012.net.il ([84.95.2.7]:21856 "EHLO mtaout3.012.net.il")
	by vger.kernel.org with ESMTP id S1751206AbVKTKgt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 05:36:49 -0500
Date: Sun, 20 Nov 2005 12:35:36 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
Subject: Re: Inconsistent timing results of multithreaded program on an SMP
 machine.
In-reply-to: <200511202128.13308.kernel@kolivas.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: Marcel Zalmanovici <MARCEL@il.ibm.com>, linux-kernel@vger.kernel.org
Message-id: <20051120103536.GB12997@granada.merseine.nu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
References: <OF5AC87F24.6CC16082-ONC22570BF.00387722-C22570BF.0038A482@il.ibm.com>
 <200511202128.13308.kernel@kolivas.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 20, 2005 at 09:28:13PM +1100, Con Kolivas wrote:

> Ok I've had a look at the actual program now ;) Are you timing the time it 
> takes to completion of everything?
> 
> This part of your program:
> 	for (i= 0; i<8; i++)
> 		pthread_join(tid[i], NULL);
> 
> Cares about the order the threads finish. Do you think this might be affecting 
> your results?

I don't see why it should matter. Depending on the order the threads
finish, we will always wait in pthread_join until the last one
finishes, and then do between 0 and 7 more pthread_joins that should
return immediately (since the last one has already finished).

Cheers,
Muli
-- 
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/

