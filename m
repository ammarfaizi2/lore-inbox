Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267227AbRGYTYN>; Wed, 25 Jul 2001 15:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268614AbRGYTYD>; Wed, 25 Jul 2001 15:24:03 -0400
Received: from hera.cwi.nl ([192.16.191.8]:56730 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S267227AbRGYTXx>;
	Wed, 25 Jul 2001 15:23:53 -0400
From: Andries.Brouwer@cwi.nl
Date: Wed, 25 Jul 2001 19:23:55 GMT
Message-Id: <200107251923.TAA21053@vlet.cwi.nl>
To: Andries.BRouwer@cwi.nl, kuznet@ms2.inr.ac.ru
Subject: Re: ifconfig and SIOCSIFADDR
Cc: linux-kernel@vger.kernel.org, net-tools@lina.inka.de, philb@gnu.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

    From kuznet@mops.inr.ac.ru Wed Jul 25 18:37:10 2001

    > and the last ioctl destroys the information set by the previous two.

    Exactly.

    > I consider this a kernel bug,

    No. And even not a feature, but just the only eligible way.
    SIOCSIFADDR resets all previously set address information

Yes. It didn't in 2.0. It does in 2.2 and 2.4.

    BTW, if no address was selected before, setting netmask
    and broadcast etc. simply fails.
    So that you had some address set on the interface before
    you did the operation and that netmask is set for _that_ address_.

Yes. I liked such logic thirty years ago. That is Unix.
Today I am less sure that it is a good idea to expect users
to read the kernel and ifconfig sources, but I did and know.

Since you don't like changing the current behaviour, we should
probably document it (say, in ifconfig(8)).

Andries


ifconfig(8):
SYNOPSIS
...
       ifconfig interface [aftype] [address] options

OPTIONS
       Since options are read and transmitted to the kernel
       in the order given, and since giving an address parameter
       causes resetting address related information (such as
       netmask and broadcast address) to a default, any non-default
       such address related information should be given after the
       address parameter (if any).
