Return-Path: <linux-kernel-owner+w=401wt.eu-S1751161AbWLMVYy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbWLMVYy (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 16:24:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbWLMVYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 16:24:54 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:38734 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751114AbWLMVYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 16:24:53 -0500
Date: Wed, 13 Dec 2006 22:22:13 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Linus Torvalds <torvalds@osdl.org>, Greg KH <gregkh@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] more Driver core patches for 2.6.19
In-Reply-To: <1166044471.11914.195.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0612132219480.32433@yvahk01.tjqt.qr>
References: <20061213195226.GA6736@kroah.com>  <Pine.LNX.4.64.0612131205360.5718@woody.osdl.org>
 <1166044471.11914.195.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>You can simply mask it, have it handled by userspace and re-enable it
>when that's done. Though say hello to horrible interrupt latencies and
>hope you aren't sharing it with anything critical...

For the sharing case, some sort of softirq should be created. That is, when a
hard interrupt is generated and the irq handler is executed, set a flag that at
some other point in time, the irq is delivered to userspace. Like you do with
signals in userspace:

 void sighandler(int s) {
     exit_main_loop_soon = 1;
 }

something similar could be done in kernelspace without interrupting important
devices/irq_handlers sharing the same IRQ. 


	-`J'
-- 
