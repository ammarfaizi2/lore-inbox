Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267741AbTBUWWW>; Fri, 21 Feb 2003 17:22:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267743AbTBUWWW>; Fri, 21 Feb 2003 17:22:22 -0500
Received: from dns.toxicfilms.tv ([150.254.37.24]:11161 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP
	id <S267741AbTBUWWV>; Fri, 21 Feb 2003 17:22:21 -0500
Date: Fri, 21 Feb 2003 23:32:29 +0100 (CET)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: Valdis.Kletnieks@vt.edu
Cc: Mika Liljeberg <mika.liljeberg@welho.com>,
       John Bradford <john@grabjohn.com>, linux-kernel@vger.kernel.org
Subject: Re: RFC3168, section 6.1.1.1 - ECN and retransmit of SYN 
In-Reply-To: <200302212205.h1LM5gCu016220@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.51.0302212330290.6800@dns.toxicfilms.tv>
References: <200302212040.h1LKejY3001679@81-2-122-30.bradfords.org.uk>     
       <1045863838.22625.121.camel@devil> <200302212205.h1LM5gCu016220@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It turns out that I *CAN* do it all with iptables *IF* the following
> untested code actually works (this assumes that mangle is re-called on
> a retransmit)
>
> # If we've already marked this packet, strip/log/send...
> iptables -t mangle -A OUTPUT -p tcp --syn -m mark --mark 99 --ecn-tcp-remove
iptables -t mangle -A OUTPUT -p tcp --syn -m mark --mark 99 -j ECN \
	--ecn-tcp-remove

> iptables -t mangle -A OUTPUT -p tcp --syn -m mark --mark 99 -j LOG
> iptables -t mangle -A OUTPUT -p tcp --syn -m mark --mark 99 -j ACCEPT
> # Else tag it - if it makes it on the first try, good. If not, re-enter above
> iptables -t mangle -A OUTPUT -p tcp --syn -m mark --set-mark 99
>
> Does the mangle/output chain get called again for a retransmitted
> packet, or only once?
For every retransmitted packet.

> /Valdis
Maciej
