Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267399AbUIAQaZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267399AbUIAQaZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 12:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267475AbUIAQWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 12:22:11 -0400
Received: from the-village.bc.nu ([81.2.110.252]:43915 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266666AbUIAQMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 12:12:17 -0400
Subject: Re: [PATCH] Configure IDE probe delays
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mark Lord <lkml@rtr.ca>
Cc: bzolnier@milosz.na.pl, Lee Revell <rlrevell@joe-job.com>,
       Greg Stark <gsstark@mit.edu>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Todd Poynor <tpoynor@mvista.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       tim.bird@am.sony.com, dsingleton@mvista.com
In-Reply-To: <4135CC9E.5060905@rtr.ca>
References: <20040730191100.GA22201@slurryseal.ddns.mvista.com>
	 <200408272005.08407.bzolnier@elka.pw.edu.pl>
	 <1093630121.837.39.camel@krustophenia.net>
	 <200408272059.51779.bzolnier@elka.pw.edu.pl>  <4135CC9E.5060905@rtr.ca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094051215.2777.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 01 Sep 2004 16:06:57 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-09-01 at 14:20, Mark Lord wrote:
> LBA48 is only needed when (1) the sector count is greater than 256,
> and/or (2) the ending sector number >= (1<<28).

I've played with this a bit and in the -ac IDE code it can drop back
to LBA28 for devices that are small enough not to need LBA48 when the
controller only supports PIO for LBA48 modes (eg some ALi) as 2.4-ac
did. 

> I regularly include this optimisation in the drivers I have been
> working on since LBA48 first appeared.

It isn't always a win. You get cut down to 256 sectors per I/O which for
some workloads has a cost and you need to factor that into the command
issue choice as well as the last sector number being accessed.

Alan

