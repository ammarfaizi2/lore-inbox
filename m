Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271798AbRIYWGH>; Tue, 25 Sep 2001 18:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271809AbRIYWF6>; Tue, 25 Sep 2001 18:05:58 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:2826 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S271747AbRIYWFq>; Tue, 25 Sep 2001 18:05:46 -0400
Date: Tue, 25 Sep 2001 19:05:58 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Jens Petersohn <jkp@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: protocol is buggy?
Message-ID: <20010925190557.A4286@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Jens Petersohn <jkp@sgi.com>, linux-kernel@vger.kernel.org
In-Reply-To: <XFMail.20010925124235.jkp@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <XFMail.20010925124235.jkp@sgi.com>; from jkp@sgi.com on Tue, Sep 25, 2001 at 12:42:35PM -0500
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Sep 25, 2001 at 12:42:35PM -0500, Jens Petersohn escreveu:

> getting the following in dmesg. Don't know if it's iptables related or
> not. The ethernet card in question is a Intel EtherPRO 100 with the stock
> 2.4.8 driver. Everything is working great, but I'm mostly curious why
> these messages appear. A search in Google or LKM didn't turn anything
> immidiately, but I might have missed something.
 
> protocol 0008 is buggy, dev eth1
> protocol 0008 is buggy, dev eth1
> protocol 0008 is buggy, dev eth1
> protocol 0008 is buggy, dev eth1
> NET: 16 messages suppressed.
> protocol 0008 is buggy, dev eth1
 
> /proc/pci:
>   Bus  0, device  19, function  0:
>     Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 2).
>       IRQ 5.
>       Master Capable.  Latency=64.  Min Gnt=8.Max Lat=56.
>       Prefetchable 32 bit memory at 0xe4100000 [0xe4100fff].
>       I/O at 0x7400 [0x741f].
>       Non-prefetchable 32 bit memory at 0xe4000000 [0xe40fffff].
 
> The card in question is the "public/internet" side of the firewall.
> There are two additional interfaces, eth0 (private ethernet) and eth2,
> a radio LAN.

probably related to eth_type_trans not being called, or something else that
doesn't properly set skb2->nh.raw, I've experienced this while hacking on
802.2/NetBEUI, the message comes from net/core/dev.c, function
dev_queue_xmit_nit, line 882 in 2.4.9. I'll take a look now, but I'm in a
hurry, so don't hold your breath.

- Arnaldo
