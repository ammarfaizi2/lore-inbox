Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030223AbWGMTAn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030223AbWGMTAn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 15:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030235AbWGMTAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 15:00:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3733 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030223AbWGMTAm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 15:00:42 -0400
Date: Thu, 13 Jul 2006 11:56:51 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Pekka Enberg <penberg@cs.helsinki.fi>
cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       sekharan@us.ibm.com, linux-kernel@vger.kernel.org, nagar@watson.ibm.com,
       balbir@in.ibm.com, arjan@infradead.org
Subject: Re: [patch] lockdep: annotate mm/slab.c
In-Reply-To: <84144f020607130858l60792ac0t5f9cdabf1902339c@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0607131156060.5623@g5.osdl.org>
References: <1152763195.11343.16.camel@linuxchandra>  <20060713071221.GA31349@elte.hu>
  <20060713002803.cd206d91.akpm@osdl.org> <20060713072635.GA907@elte.hu> 
 <20060713004445.cf7d1d96.akpm@osdl.org>  <20060713124603.GB18936@elte.hu>
 <84144f020607130858l60792ac0t5f9cdabf1902339c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 13 Jul 2006, Pekka Enberg wrote:
> 
> What's "nested lock" btw? If I understood from the other patch, you're
> talking about ac->lock. Surely you can't take the same lock twice but
> it's perfectly legal to take lock as long as the ac instance is
> different...

Normally, no. You can't take another lock just because the instance is 
different. That causes ABBA deadlocks unless you have some underlying 
_ordering_ of the different lock instances.

		Linus
