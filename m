Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263830AbUDFORf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 10:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263827AbUDFORf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 10:17:35 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:15061 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S263830AbUDFORE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 10:17:04 -0400
Date: Tue, 6 Apr 2004 16:17:03 +0200 (MEST)
From: Jesper Dangaard Brouer <hawk@diku.dk>
To: linux-kernel@vger.kernel.org
Cc: dtor@mail.ru
Subject: Re: [NET_SCHED] BUG in qdisc TBF (token bucket filter)
In-Reply-To: <Pine.LNX.4.58.0403031323140.6655@ask.diku.dk>
Message-ID: <Pine.LNX.4.58.0404061609360.29179@pc-074.diku.dk>
References: <Pine.LNX.4.58.0403031323140.6655@ask.diku.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(...lets keep google updated ;-))

The error have been corrected in kernel 2.4.26-rc1, by

 Dmitry Torokhov:
  o [NET_SCHED]: Fix class reporting in TBF qdisc

--Hawk

On Wed, 3 Mar 2004, Jesper Dangaard Brouer wrote:

> BUG in qdisc TBF (token bucket filter).
>
>  Problem in    : Kernel 2.4.22 (and newer, tested till 2.4.25-rc2)
>  Problem NOT in: kernel 2.4.21 (and older)
>
> Problem:
> --------
>  After I add an tbf qdisc to an htb class, then the htb class disappear
>  from the output-listing "tc -s class ls dev ethX".
>
> tc-versions:
>  I have tested with different version of the "tc" utility.
>  And different versions of the htb patch.
>
>  "tc utility, iproute2-ss010824" (debian's iproute)
>  "tc utility, iproute2-ss020116" (with htb3.6-020525)
>
> I've not tested if the tfb qdisc and htb class still works, but only
> that the output-listing is wrong.  (I'm running 2.4.21 on my
> router/firewall to be on the safe side.)
>
> Howto reproduce:
> ----------------
>  #Removing previous 'root' handle/classification
>  /sbin/tc qdisc del dev eth0 root
>  #
>  /sbin/tc qdisc add dev eth0 root handle 1: htb default 10
>  #
>  /sbin/tc class add dev eth0 parent 1: classid 1:10 htb rate 500kbit
>
>  # output-listing of class'es
>  tc -s class ls dev eth0
>  #
>  # output:
>  class htb 1:10 root prio 0 rate 500Kbit ceil 500Kbit burst 2239b cburst 2239b
>   Sent 812 bytes 6 pkts (dropped 0, overlimits 0)
>   lended: 6 borrowed: 0 giants: 0
>   tokens: 27239 ctokens: 27239
>
>  # the tbf line
>  /sbin/tc qdisc add dev eth0 parent 1:10 handle 4210: tbf rate 500kbit \
>           latency 50ms burst 2239b
>
>  # output-listing of class'es
>  tc -s class ls dev eth0
>  #
>  # output:
>  <NOTHING>
>
> The output-listing of class'es returns, if I remove the tbf qdisc again.
>
> Diff between file /net/sched/sch_tbf.c in kernel 2.4.21 and 2.4.22 is
> attached.
>
>
> Hilsen
>   Jesper Brouer
>
> --
> -------------------------------------------------------------------
> System Administrator
> Dept. of Computer Science, University of Copenhagen
> E-mail: hawk@diku.dk, Direct Tel.: 353 21464
> -------------------------------------------------------------------
>

Hilsen
  Jesper Brouer

--
-------------------------------------------------------------------
System Administrator / Research Assistent
Dept. of Computer Science, University of Copenhagen
E-mail: hawk@diku.dk, Direct Tel.: 353 21464
-------------------------------------------------------------------
