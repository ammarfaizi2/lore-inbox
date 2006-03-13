Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932196AbWCMQXa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbWCMQXa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 11:23:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932220AbWCMQXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 11:23:30 -0500
Received: from tag.witbe.net ([81.88.96.48]:35032 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S932196AbWCMQX3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 11:23:29 -0500
From: "Paul Rolland" <rol@witbe.net>
To: "'Pierre Ossman'" <drzeus-list@drzeus.cx>,
       "'LKML'" <linux-kernel@vger.kernel.org>, <cramerj@intel.com>,
       <john.ronciak@intel.com>, <ganesh.venkatesan@intel.com>
Subject: Re: e1000 with serdes only shows a fiber port
Date: Mon, 13 Mar 2006 17:23:14 +0100
Organization: Witbe.net
Message-ID: <003401c646ba$6e113280$b600a8c0@cortex>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AcZGoN1pp8Rv4/OYQhymBT0njmwdGAAGS0MQ
In-Reply-To: <44157178.90507@drzeus.cx>
x-ncc-regid: fr.witbe
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> The device id of both controllers is 8086:107b, meaning 
> SERDES. However,
> if I look into e1000_ethtool.c:e1000_get_settings() I can see 
> a test for
> copper media, then and else assuming that the card is a fiber card.
> Since this card can do both I'm guessing this code is broken.

I think it simply means the card can only operate one of the two
modes at one time...

> Settings for eth0:
>         Supported ports: [ FIBRE ]
>         Supported link modes:   1000baseT/Full
>         Supports auto-negotiation: Yes
>         Advertised link modes:  1000baseT/Full
>         Advertised auto-negotiation: Yes
>         Speed: Unknown! (65535)
>         Duplex: Unknown! (255)
>         Port: FIBRE
>         PHYAD: 0
>         Transceiver: internal
>         Auto-negotiation: off
>         Supports Wake-on: umbg
>         Wake-on: d
>         Current message level: 0x00000007 (7)
>         Link detected: no

Did you try something like :
ethtool -s eth0 port tp
or
ethtool -s eth0 port mii

as the man page for ethtool says :
       port tp|aui|bnc|mii
              Select device port.

and ethtool indicates it supports :
        ethtool -s DEVNAME \
                [ speed 10|100|1000 ] \
                [ duplex half|full ]    \
                [ port tp|aui|bnc|mii|fibre ] \
where fibre is what you have selected right now (from your report...)

Paul

