Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267427AbUIATgz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267427AbUIATgz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 15:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267429AbUIATgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 15:36:55 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:3046 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267427AbUIATgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 15:36:51 -0400
Subject: Re: [PATCH] Configure IDE probe delays
From: Lee Revell <rlrevell@joe-job.com>
To: Mark Lord <lkml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, bzolnier@milosz.na.pl,
       Greg Stark <gsstark@mit.edu>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Todd Poynor <tpoynor@mvista.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       tim.bird@am.sony.com, dsingleton@mvista.com
In-Reply-To: <4135EC84.6070407@rtr.ca>
References: <20040730191100.GA22201@slurryseal.ddns.mvista.com>
	 <200408272005.08407.bzolnier@elka.pw.edu.pl>
	 <1093630121.837.39.camel@krustophenia.net>
	 <200408272059.51779.bzolnier@elka.pw.edu.pl> <4135CC9E.5060905@rtr.ca>
	 <4135E017.1000901@pobox.com>  <4135EC84.6070407@rtr.ca>
Content-Type: text/plain
Message-Id: <1094067412.1970.48.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 01 Sep 2004 15:36:53 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-01 at 11:36, Mark Lord wrote:
> With good ADMA or host-queuing controllers that access system
> memory directly for their command blocks, then there's not much
> (if any) penalty for the extra LBA48 setup.  But for "normal"
> controllers (if such a beast even exists), the extra writes across
> the PCI bus can be costly.
> 
> Hardware write-buffer FIFOs between the CPU and the PCI bus
> can reduce the impact of this somewhat, but they are often
> only 2-4 entries deep, and will be filled by a normal (S)ATA
> command setup sequence.
> 
> This is one of those finer points that is very difficult to measure,
> since the I/O throughput is pretty much unaffected by it.  But CPU
> cycle count per-I/O setup is one way to measure it.
> 

The effect can be measured using a recent version of the voluntary
preemption patches, and disabling hardirq preemption.  In this situation
the IDE I/O completion is by far the longest non-preemptible code path,
so can be easily profiled from the latency traces.

Lee

