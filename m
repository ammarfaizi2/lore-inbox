Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261543AbULNQG2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261543AbULNQG2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 11:06:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbULNQFA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 11:05:00 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:44686 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261537AbULNQEe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 11:04:34 -0500
Date: Tue, 14 Dec 2004 17:04:29 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Adam Denenberg <adam@dberg.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: bind() udp behavior 2.6.8.1
In-Reply-To: <1103038728.10965.12.camel@sucka>
Message-ID: <Pine.LNX.4.61.0412141700430.24308@yvahk01.tjqt.qr>
References: <1103038728.10965.12.camel@sucka>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hello,
>
> I am not subscribed to this list so please CC me personally in
>response. 
>
> I am noticing some odd behavior with linux 2.6.8.1 on a redhat 8 box
>when making udp requests.  It seems subsequent udp calls are all
>allocating the same source ephemeral udp port.  I believe the kernel
>should be randomizing these (or incrementing) these ports for subsequent
>requests.

No, you can have a fixed port for any socket. (It's just a question whether 
you actually get the socket, because it might be in use.)

See http://linux01.org:2222/f/UHXT/examples/src/fastsock.c , which contains an 
example on how to choose a fixed port.

>  We ran a test C program that just put a gethostbyname_r call
>in a for loop of 40 calls and all 40 requests used the same UDP source
>port (32789).

Looks normal to me. It might select a random port upon "libc invocation" and 
use it for all further requests. This is in fact very valid, because UDP is 
connectionless; packets can go from anywhere to anywhere without any 
pre-work.

>  This is causing our firewall to drop some packets since
>it thinks it already closed that connection due to too many transactions
>using same udp source/dest port passing thru in too short a time frame.

Then, the firewall UDP implementation is broken. Note, an UDP connection *can 
not be closed*, because it never was "open". If it's trying to do something 
like 
	iptables -p udp -m state --state RELATED
it is doing it wrong, because that is an impossible situation.


Jan Engelhardt
-- 
ENOSPC
