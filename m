Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264126AbTEORVb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 13:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264127AbTEORVb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 13:21:31 -0400
Received: from air-2.osdl.org ([65.172.181.6]:50092 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264126AbTEORV2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 13:21:28 -0400
Date: Thu, 15 May 2003 10:34:42 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Zwane Mwaikambo <zwane@linuxpower.ca>
cc: Andrew Morton <akpm@digeo.com>, <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: 2.5.69-mm5: reverting i8259-shutdown.patch
In-Reply-To: <Pine.LNX.4.50.0305150355210.19782-100000@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.44.0305151031210.9816-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Pat what do you say to some late shutdown callbacks? I'll drop you a 
> patch sometime tommorrow.

Bah. It would work, but it's a hack. We'll get caught in a game similar to 
the leap-frogging initcalls. In fact, we could just get really twisted and 
define various levels of exitcalls. [ Or, do them implicitly with some 
linkser-section-fu by calling the modules' exit functions in the reverse 
order in which they were initialized, but that's another story. ]

I just think that system level devices need to be treated specially in 
every case. They just don't work as normal devices because of the ordering 
issue. We can keep a separate list of them and deal with them explicitly 
after regular devices. It's not that bad of a change, but will take a few 
days, unless someone wants to take a stab at it..


	-pat


