Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285927AbRLHUrK>; Sat, 8 Dec 2001 15:47:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285926AbRLHUrA>; Sat, 8 Dec 2001 15:47:00 -0500
Received: from shell.cyberus.ca ([216.191.240.114]:9467 "EHLO shell.cyberus.ca")
	by vger.kernel.org with ESMTP id <S285921AbRLHUqn>;
	Sat, 8 Dec 2001 15:46:43 -0500
Date: Sat, 8 Dec 2001 15:43:05 -0500 (EST)
From: jamal <hadi@cyberus.ca>
To: bert hubert <ahu@ds9a.nl>
cc: <lartc@mailman.ds9a.nl>, <linux-kernel@vger.kernel.org>,
        <kuznet@ms2.inr.ac.ru>, <netdev@oss.sgi.com>
Subject: Re: further CBQ/tc documentation ds9a.nl/lartc/manpages
In-Reply-To: <20011208205541.A15565@outpost.ds9a.nl>
Message-ID: <Pine.GSO.4.30.0112081513430.4764-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



For starters, i think you need a defintions sections. Look at:
http://www.ietf.org/internet-drafts/draft-ietf-diffserv-model-06.txt

(eg what is a shaper etc and how trhings are placed together). At least
that will ensure that you dont sday things like "Prio cant shape".

It is a good model but may be insufficient given Linux TCs
capabilities. Email me when unsure.

Some other things:
- In your comment "Do not confuse this classless simple qdisc with the
classful PRIO one!". This is misleading:
the default 3 band FIFO queue is conceptually the same as the
default prio qdisc (the priomaps are identical). 3 bands; same
prioritization schemes.
- You really need to fix ingress section:
 it works for both forwarding and packets coming in to local sockets.
More importantly, It takes advantages of _all_ filter schemes
available for TC as well as the policing functionality (which sadly seemed
to have been replicated by someone in netfilter, wrongly if i may add ;->).
- You keep saying "reodering" -- dont know what that means. Reordering is
generally considered a Bad Thing(tm).

- your description of the "peakrate" (same in TBF as well as policing)

Well captured. It took ages to get this into peoples heads. This also
applies to CBQ.

- your description of "MTU"
Not very good description:
This is just what it literally says; maximum transmit unit;
A packet larger than this will be dropped. Default is 2K. For ethernet,
MTUs of 1500 bytes, this is fine; however, you should put a cautionary
statement here in regards to people having MTUs smaller than 2K (example
the lo device); they might find that all their packets greater than 2K
being dropped.


More later if dont get distracted.

cheers,
jamal


