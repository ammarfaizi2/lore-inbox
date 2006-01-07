Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752593AbWAGWi2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752593AbWAGWi2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 17:38:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752595AbWAGWi2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 17:38:28 -0500
Received: from smtp.osdl.org ([65.172.181.4]:16585 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752593AbWAGWi1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 17:38:27 -0500
Date: Sat, 7 Jan 2006 14:37:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: Joel Schopp <jschopp@austin.ibm.com>
Cc: olof@lixom.net, mingo@elte.hu, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, arjan@infradead.org, nico@cam.org,
       jes@trained-monkey.org, viro@ftp.linux.org.uk, oleg@tv-sign.ru,
       dhowells@redhat.com, alan@lxorguk.ukuu.org.uk, hch@infradead.org,
       ak@suse.de, rmk+lkml@arm.linux.org.uk, anton@samba.org,
       linuxppc64-dev@ozlabs.org
Subject: Re: PowerPC fastpaths for mutex subsystem
Message-Id: <20060107143722.25afd85d.akpm@osdl.org>
In-Reply-To: <43BFFF1D.7030007@austin.ibm.com>
References: <20060104144151.GA27646@elte.hu>
	<43BC5E15.207@austin.ibm.com>
	<20060105143502.GA16816@elte.hu>
	<43BD4C66.60001@austin.ibm.com>
	<20060105222106.GA26474@elte.hu>
	<43BDA672.4090704@austin.ibm.com>
	<20060106002919.GA29190@pb15.lixom.net>
	<43BFFF1D.7030007@austin.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Schopp <jschopp@austin.ibm.com> wrote:
>
> This is the second pass at optimizing the fastpath for the new mutex subsystem 
>  on PowerPC.  I think it is ready to be included in the series with the other 
>  mutex patches now.  Tested on a 4 core (2 SMT threads/core) Power5 machine with 
>  gcc 3.3.2.
> 
>  Test results from synchro-test.ko:
> 
>  All tests run for default 5 seconds
>  Threads semaphores  mutexes     mutexes+attached
>  1       63,465,364  58,404,630  62,109,571
>  4       58,424,282  35,541,297  37,820,794
>  8       40,731,668  35,541,297  40,281,768
>  16      38,372,769  37,256,298  41,751,764
>  32      38,406,895  36,933,675  38,731,571
>  64      37,232,017  36,222,480  40,766,379
> 

Doens't this mean that the sped-up mutexes are still slower than semaphores?
