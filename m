Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262373AbTEZX4U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 19:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262379AbTEZX4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 19:56:20 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:44303 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262373AbTEZX4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 19:56:19 -0400
Date: Mon, 26 May 2003 17:09:03 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Nick Piggin <piggin@cyberone.com.au>
cc: Jens Axboe <axboe@suse.de>, James Bottomley <James.Bottomley@SteelEye.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCHES] add ata scsi driver
In-Reply-To: <3ED2AA37.4000304@cyberone.com.au>
Message-ID: <Pine.LNX.4.44.0305261705070.15826-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 27 May 2003, Nick Piggin wrote:
>
> There is an elevator notifier which is called on request
> completion in Andrew's tree (needed for AS io scheduler). This
> can be used to do what you want.

Well, yeah, sure, you can use it to keep track of outstanding requests. 
But wouldn't it be nicer to see them in the first place?

The question being: how do you sanely avoid adding more requests to the 
queue if you start seeing starvation? Or if adding more requests, at least 
using an ordered tag or a barrier or whatever to make sure that you tell 
the disk that the new request must not be done before the old one has 
finally been satisfied?

I think you'd want to see the old requests in order to be able to make 
that decision reasonably well. 

This is clearly not a 2.6.x issue, btw.

			Linus

