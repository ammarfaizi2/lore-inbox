Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267623AbTAHR45>; Wed, 8 Jan 2003 12:56:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267777AbTAHR45>; Wed, 8 Jan 2003 12:56:57 -0500
Received: from port5.ds1-sby.adsl.cybercity.dk ([212.242.169.198]:17532 "EHLO
	trider-g7.fabbione.net") by vger.kernel.org with ESMTP
	id <S267623AbTAHR44>; Wed, 8 Jan 2003 12:56:56 -0500
Date: Wed, 8 Jan 2003 19:05:36 +0100 (CET)
From: Fabio Massimo Di Nitto <fabbione@fabbione.net>
To: Wichert Akkerman <wichert@wiggy.net>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: ipv6 stack seems to forget to send ACKs
In-Reply-To: <20030108130850.GQ22951@wiggy.net>
Message-ID: <Pine.LNX.4.51.0301081849550.564@diapolon.int.fabbione.net>
References: <20030108130850.GQ22951@wiggy.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I was able to reproduce the problem again. I have been using ethereal to
sniff instead of tcpdump and gave out some more info.

basically the icecast server at certain time (but i can't predict
exactly in which situations) just send a FIN, ACK packet to the client.
Basically to close the connection and after a few packets the client of
course answer.What is strange that in the meanwhile there are still 3/4
data packets coming from the server to the client.

Regarding the network side I noticed the following:

an average of 500ms to ping6 the server and 0 pkt loss
few seconds before the FIN, ACK (server->client) and for about 6 pkts the
average jumped to 2000ms

I suspect that this network flap made the server thinking about
<insert_here_whatever_term_is_more_appropriate> and decided to close
the connection.

The full ethereal dump is available at
http://www.fabbione.net/ice-xmms-ipv6.dump.bz2

but PLEASE note that it is a 10MB file and Im on a slow adsl line so be
"nice".

Fabio

PS Im afraid/happy that anyway the problem is not related to the kernel
version we are running.

-- 
vega:~# apt-get install life
Reading Package Lists... Done
Building Dependency Tree... Done
E: Couldn't find package life
