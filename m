Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267510AbUIATtj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267510AbUIATtj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 15:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267447AbUIATrt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 15:47:49 -0400
Received: from the-village.bc.nu ([81.2.110.252]:7052 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267435AbUIATpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 15:45:34 -0400
Subject: Re: [PATCH] Configure IDE probe delays
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Mark Lord <lkml@rtr.ca>, Jeff Garzik <jgarzik@pobox.com>,
       bzolnier@milosz.na.pl, Greg Stark <gsstark@mit.edu>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Todd Poynor <tpoynor@mvista.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       tim.bird@am.sony.com, dsingleton@mvista.com
In-Reply-To: <1094067412.1970.48.camel@krustophenia.net>
References: <20040730191100.GA22201@slurryseal.ddns.mvista.com>
	 <200408272005.08407.bzolnier@elka.pw.edu.pl>
	 <1093630121.837.39.camel@krustophenia.net>
	 <200408272059.51779.bzolnier@elka.pw.edu.pl> <4135CC9E.5060905@rtr.ca>
	 <4135E017.1000901@pobox.com>  <4135EC84.6070407@rtr.ca>
	 <1094067412.1970.48.camel@krustophenia.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094064126.3100.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 01 Sep 2004 19:42:09 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-09-01 at 20:36, Lee Revell wrote:
> The effect can be measured using a recent version of the voluntary
> preemption patches, and disabling hardirq preemption.  In this situation
> the IDE I/O completion is by far the longest non-preemptible code path,
> so can be easily profiled from the latency traces.

A lot of IDE controllers hold off the CPU for long times when you do I/O
cycles. The other factor is PIO which defaults to IRQ masking for safety
on old controllers. For PCI we should probably default the other way.

