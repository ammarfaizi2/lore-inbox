Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030302AbWGMTVb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030302AbWGMTVb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 15:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030303AbWGMTVb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 15:21:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19867 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030302AbWGMTVa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 15:21:30 -0400
Date: Thu, 13 Jul 2006 12:21:05 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       sekharan@us.ibm.com, linux-kernel@vger.kernel.org, nagar@watson.ibm.com,
       balbir@in.ibm.com
Subject: Re: [patch] lockdep: annotate mm/slab.c
In-Reply-To: <1152817589.3024.64.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.64.0607131219220.5623@g5.osdl.org>
References: <1152763195.11343.16.camel@linuxchandra>  <20060713071221.GA31349@elte.hu>
 <20060713002803.cd206d91.akpm@osdl.org>  <20060713072635.GA907@elte.hu>
 <20060713004445.cf7d1d96.akpm@osdl.org>  <20060713124603.GB18936@elte.hu> 
 <Pine.LNX.4.64.0607131147530.5623@g5.osdl.org> <1152817589.3024.64.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 13 Jul 2006, Arjan van de Ven wrote:

> On Thu, 2006-07-13 at 11:50 -0700, Linus Torvalds wrote:
> > 
> > Why isn't the "on_slab_key" local to just the init_lock_keys()
> > function, 
> > and the #ifdef around it all?
> 
> it's the same net results; the variable is 0 bytes in size for !LOCKDEP 

That's not why I reacted. I reacted because the code is ugly, and would be 
much cleaner if it had everything in one place.

Btw, the variable size for !LOCKDEP is totally irrelevant: you need to 
have it inside the #ifdef LOCKDEP _anyway_, if only yo shut up gcc about 
unused static variables. Which you did do, by duplicating the function 
(once empty), and having an #else part to it all.

			Linus
