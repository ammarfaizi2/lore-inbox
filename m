Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031519AbWLEVSS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031519AbWLEVSS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 16:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031531AbWLEVSS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 16:18:18 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:9829 "EHLO iradimed.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1031519AbWLEVSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 16:18:17 -0500
Message-ID: <4575E237.9090902@cfl.rr.com>
Date: Tue, 05 Dec 2006 16:18:47 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: "Raz Ben-Jehuda(caro)" <raziebe@gmail.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, linux-aio@kvack.org
Subject: Re: slow io_submit
References: <5d96567b0612010904s361b799t8db72accc287ca54@mail.gmail.com>  <20061201172749.GZ5400@kernel.dk>  <5d96567b0612011340m410a2294w9b02b619a62888da@mail.gmail.com>  <45744101.2040904@cfl.rr.com> <5d96567b0612050823n225d4c43j35c7210e228d26@mail.gmail.com>
In-Reply-To: <5d96567b0612050823n225d4c43j35c7210e228d26@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Dec 2006 21:18:31.0157 (UTC) FILETIME=[E9F26250:01C718B2]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.6.1039-14856.000
X-TM-AS-Result: No--8.870500-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Raz Ben-Jehuda(caro) wrote:
> thanks Phiilip
> But... hmmm ... should'nt an asynchronous operation act as
> "send and forget" . isn't  "queue full" a problem that aio must at
> least try and handle before returning to the user ?

It is handling it; by blocking until the queue is not full.  A better 
way of handling it would be to return in such a way that the caller 
knows the queue is full and needs to wait before it can submit more 
requests, possibly doing some computation or submitting requests to 
other devices in the mean time.


