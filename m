Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270970AbTGVR50 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 13:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270974AbTGVR5Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 13:57:25 -0400
Received: from 64-60-248-67.cust.telepacific.net ([64.60.248.67]:29983 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S270970AbTGVR5Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 13:57:24 -0400
Message-ID: <3F1D7D43.5070401@rackable.com>
Date: Tue, 22 Jul 2003 11:06:59 -0700
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Hunter <matthew@infodancer.org>
CC: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
Subject: Re: 2.4.21, NFS v3, and 3com 920
References: <20030722054245.GA768@infodancer.org> <200307221319.h6MDJVgf007961@turing-police.cc.vt.edu>
In-Reply-To: <200307221319.h6MDJVgf007961@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Jul 2003 18:12:23.0436 (UTC) FILETIME=[CC8B64C0:01C3507C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:

>On Tue, 22 Jul 2003 00:42:45 CDT, Matthew Hunter <matthew@infodancer.org>  said:
>
>  
>
>>Running more tests, it turns out the speed problem is isolated to 
>>the one machine, and only to *receiving* data.  Sending goes at 
>>8 M/s to other machines from the client machine.  Sending from 
>>any machine to the client machine is slowed down, not just from 
>>the server.
>>    
>>
>
>These symptoms sound suspiciously like a 100BaseT auto-negotiation
>problem.  With some combinations of gear, if one end is set to auto-negotiate
>and the other end is nailed to full/half duplex (sorry, can't remember which and
>I've not my caffiene yet), things go horribly wrong and many packets
>dissapear silently on transmission, forcing retransmit timeouts and bad
>throughput.  Basically, you end up with one end thinking it's full duplex,
>the other end at half - and if the full duplex side ever sends a packet while
>the half side is sending, the packet's lost.
>
>Try nailing the devices on both ends of the cat-5 to the same thing (full or
>half).  This can of course be interesting if you have an unmanaged hub that
>doesn't give you a choice...
>
>
>
>  
>

  You should be able to use mii-tool, or ethtool (one or both should 
work) to check the state your ethernet controller thinks it is set to, 
and change the settings.

[root@sflory cujo]# mii-tool -v eth0
eth0: negotiated 100baseTx-FD, link ok
  product info: vendor 00:aa:00, model 51 rev 0
  basic mode:   autonegotiation enabled
  basic status: autonegotiation complete, link ok
  capabilities: 100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD
  advertising:  100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD flow-control
  link partner: 100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD
[root@sflory cujo]# ethtool eth0
Settings for eth0:
        Supported ports: [ TP MII ]
        Supported link modes:   10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
        Supports auto-negotiation: Yes
        Advertised link modes:  10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
        Advertised auto-negotiation: Yes
        Speed: 100Mb/s
        Duplex: Full
        Port: Twisted Pair
        PHYAD: 1
        Transceiver: internal
        Auto-negotiation: on
        Supports Wake-on: puag
        Wake-on: g
        Link detected: yes
[root@sflory cujo]#

-- 
Once you have their hardware. Never give it back.
(The First Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>


