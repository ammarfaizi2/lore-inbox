Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272421AbTGaGxW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 02:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272419AbTGaGxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 02:53:21 -0400
Received: from mx1.elte.hu ([157.181.1.137]:26272 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S272421AbTGaGxU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 02:53:20 -0400
Date: Thu, 31 Jul 2003 08:50:46 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: linas@austin.ibm.com
Cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: Race in 2.6.0-test2 timer code
In-Reply-To: <20030730150539.A28284@forte.austin.ibm.com>
Message-ID: <Pine.LNX.4.44.0307310849110.11798-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 30 Jul 2003 linas@austin.ibm.com wrote:

> cpu 1                                   cpu 2
> --------                                ---------
> mod_timer()  {                          
> 
> old_base = timer->base;
> if (old_base &&  ) { /* not taken */
> }
> else
> .                                       spin_lock(&cpu2_base->lock);


this race is not possible on 2.6. You are forgetting:

        spin_lock_irqsave(&timer->lock, flags);

which serializes the full mod_timer() operation. Ok?

	Ingo

