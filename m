Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281302AbRKLH4e>; Mon, 12 Nov 2001 02:56:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281307AbRKLH4Z>; Mon, 12 Nov 2001 02:56:25 -0500
Received: from coruscant.franken.de ([193.174.159.226]:40621 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S281302AbRKLH4R>; Mon, 12 Nov 2001 02:56:17 -0500
Date: Sun, 11 Nov 2001 23:38:12 +0100
From: Harald Welte <laforge@gnumonks.org>
To: linux-kernel@vger.kernel.org
Subject: Re: ip_conntrack & timing out of connections
Message-ID: <20011111233812.M875@naboo.gnumonks.org>
In-Reply-To: <20011106121947.A678@schmorp.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20011106121947.A678@schmorp.de>; from pcg@goof.com on Tue, Nov 06, 2001 at 12:19:47PM +0100
X-Operating-System: Linux naboo.gnumonks.org 2.4.9
X-Date: Today is Setting Orange, the 23rd day of The Aftermath in the YOLD 3167
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2001 at 12:19:47PM +0100,  Marc A. Lehmann  wrote:

> however, after some time, I get many of these messages:
> 
> Nov  6 02:39:55 doom kernel: ip_conntrack: table full, dropping packet. 
> 
> /proc/net/ip_conntrack has lots of connections like these:
> 
> tcp      6 430665 ESTABLISHED src=213.76.191.129 dst=217.227.148.85 sport=3881 dport=80 src=217.227.148.85 dst=213.76.191.129 sport=80 dport=388 1 [ASSURED] use=1 
> 
> that is, connections to port 80. a grep dport=80 in ip_conntrack gives me
> 3768 lines, where netstat -t only shows 159 connections, so it seems that
> conntrack has a problems with time-outs (or something similar).

connection tracking keeps all TCP conntrack entries for 120 seconds after
completion of FIN <-> FIN closedown.  This is the TIME_WAIT state of the
tcp protocol.

Maybe the linux tcp stack doesn't wait for 120 seconds, or some other 
condition in the tcp stack makes the sockets disappear from the netstat -t
list.

-- 
Live long and prosper
- Harald Welte / laforge@gnumonks.org               http://www.gnumonks.org/
============================================================================
GCS/E/IT d- s-: a-- C+++ UL++++$ P+++ L++++$ E--- W- N++ o? K- w--- O- M- 
V-- PS+ PE-- Y+ PGP++ t++ 5-- !X !R tv-- b+++ DI? !D G+ e* h+ r% y+(*)
