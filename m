Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261256AbTIKLl7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 07:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261254AbTIKLl7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 07:41:59 -0400
Received: from 1Cust146.tnt9.ber2.deu.da.uu.net ([149.225.160.146]:13572 "EHLO
	hell") by vger.kernel.org with ESMTP id S261256AbTIKLl6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 07:41:58 -0400
Date: Thu, 11 Sep 2003 13:41:47 +0200
From: Johannes Stezenbach <js@convergence.de>
To: Andrew de Quincey <adq_dvb@lidskialf.net>
Cc: linux-kernel@vger.kernel.org, linux-dvb@linuxtv.org, franck@nenie.org,
       eric@lammerts.org
Subject: Re: [linux-dvb] Possible kernel thread related crashes on 2.4.x
Message-ID: <20030911114147.GC668@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	Andrew de Quincey <adq_dvb@lidskialf.net>,
	linux-kernel@vger.kernel.org, linux-dvb@linuxtv.org,
	franck@nenie.org, eric@lammerts.org
References: <200309102303.34095.adq_dvb@lidskialf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309102303.34095.adq_dvb@lidskialf.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew de Quincey wrote:
> Hi, I've been having fatal oopses with some of my DVB receiver systems 
> when restarting streaming recently (i.e. opening/closing DVB devices). 
> I've only just got into the office with a debug cable to find out what has happening.
> 
> Anyway, here are the important parts of the oops (full oops at end of mail):
> Unable to handle kernel paging request at virtual address d905a984
> ...
> Trace; c011c79c <free_uid+2c/34>
> Trace; c011767b <release_task+2b/16c>
> Trace; c0118337 <sys_wait4+307/390>
> Trace; c0106c03 <system_call+33/38>
> 
> Does this look familiar to anyone? I mean specifically this thread on linux-dvb (among others):
> http://www.linuxtv.org/mailinglists/linux-dvb/2003/04-2003/msg00291.html

I get this crash from time to time, and it was also reported on the
linux-dvb list recently:
http://www.linuxtv.org/mailinglists/linux-dvb/2003/08-2003/msg00361.html

But AFAIK there aren't many people who get this, and I didn't find any
possible cause in the DVB drivers.

> Searching about found me this patch on LKML:
> http://hypermail.idiosynkrasia.net/linux-kernel/archived/2003/week04/0468.html
> 
> Which I applied to 2.4.21, and which appears to fix the problem. At least,
> I was able to continually restart streaming for 4 hours this afternoon without a problem. 
> Previously, I could crash it within 15 minutes.
> 
> It seems to be a bug related to kernel threads when starting/stopping them. The DVB drivers 
> now do this when a DVB device is opened/closed, although I'm sure they previously left 
> them running which would explain why I never saw this behaviour before.

Only the frontend driver core creates one thread per frontend for monitoring.

> My question is: is there a reason the patch has not yet made it into 2.4.x? It is not in 
> 2.4.22-pre3.

If this actually fixes kernel_thread() related crashes then please apply to -pre4.


Johannes
