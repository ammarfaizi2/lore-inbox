Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751344AbWJEIpv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbWJEIpv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 04:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbWJEIpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 04:45:51 -0400
Received: from pfx2.jmh.fr ([194.153.89.55]:14301 "EHLO pfx2.jmh.fr")
	by vger.kernel.org with ESMTP id S1751344AbWJEIpu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 04:45:50 -0400
From: Eric Dumazet <dada1@cosmosbay.com>
To: Markus Wenke <M.Wenke@web.de>
Subject: Re: to many sockets ?
Date: Thu, 5 Oct 2006 10:45:46 +0200
User-Agent: KMail/1.9.4
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
References: <4523CD4E.10806@web.de> <200610050958.38036.dada1@cosmosbay.com> <4524C05D.6080305@web.de>
In-Reply-To: <4524C05D.6080305@web.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610051045.46919.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 October 2006 10:20, Markus Wenke wrote:
> Eric Dumazet schrieb:

> > Could you post here the result of these commands when your system is
> > using more than 100.000 connections (and before the OOM :) )
>
> Hi,
>
> here the results with 130001 connetions
>
> > cat /proc/meminfo
>
> MemTotal:      3108372 kB
> MemFree:       2114404 kB
> Buffers:          5112 kB
> Cached:          97804 kB
> SwapCached:          0 kB
> Active:         140552 kB
> Inactive:        38948 kB
> HighTotal:     2228160 kB
> HighFree:      2048108 kB
> LowTotal:       880212 kB
> LowFree:         66296 kB

See here ? you have 'only' 880212 kB of LOWMEM, and 66 MB free.
all kernel structures (you can see them in /proc/slabinfo) are lying on this 
zone, no matter you add RAM on your machine (more RAM end up in HighMEM zone, 
wich is basically unused on your setup)

Since you have a 64bits CPU, your best move would be to use a 64bits kernel 
(you can keep all user land in 32bits mode)

With a 64bits kernel, kernel land structures would not be constrained in a 
small area, but can use full RAM.

I'm curious you have so many sockets but few entries in route cache... 
basically all connections come from few machines ?

Eric
