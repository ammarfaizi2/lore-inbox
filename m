Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261209AbULHN11@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261209AbULHN11 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 08:27:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261210AbULHN11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 08:27:27 -0500
Received: from mx03.cybersurf.com ([209.197.145.106]:5506 "EHLO
	mx03.cybersurf.com") by vger.kernel.org with ESMTP id S261209AbULHN1W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 08:27:22 -0500
Subject: Re: _High_ CPU usage while routing (mostly) small UDP packets
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: Karsten Desler <kdesler@soohrt.org>
Cc: Willy Tarreau <willy@w.ods.org>, P@draigBrady.com,
       "David S. Miller" <davem@davemloft.net>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20041208130845.GA5036@soohrt.org>
References: <20041206205305.GA11970@soohrt.org>
	 <20041206134849.498bfc93.davem@davemloft.net>
	 <20041206224107.GA8529@soohrt.org> <41B58A58.8010007@draigBrady.com>
	 <20041207112139.GA3610@soohrt.org>
	 <20041208053953.GC17946@alpha.home.local>
	 <20041208130845.GA5036@soohrt.org>
Content-Type: text/plain
Organization: jamalopolous
Message-Id: <1102512438.1050.61.camel@jzny.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 08 Dec 2004 08:27:18 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-08 at 08:08, Karsten Desler wrote:

> I was running mit ITR=3000, but as a test to see if NAPI works, I
> disabled ITR on eth0 bringing the int/s rate up to 50k.
> Is that normal? I always though NAPI was supposed to kick in way earlier.
> Anyways, I'm going to try different ITR settings to see if they make any
> difference.
> 

The one time you would need this ITR crap is when you are running low
traffic (relatively speaking: which could mean anything below 100Kpps
depending on h/ware). NAPI will consume a little more CPU
otherwise - given it does an extra IO (if it kicks in and out on every
packet or two). Granted you are doing some new types of tests, so
you may be seeing some things we havent experienced before.

Can you put a printk in ->open() of e1000 with
#if napi is defined
printk("%s: NAPI is on\n",dev->name);
#endif

This should print on ifconfig up and indicate whether NAPI is on or not.

cheers,
jamal

