Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315859AbSEMHhY>; Mon, 13 May 2002 03:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315865AbSEMHhX>; Mon, 13 May 2002 03:37:23 -0400
Received: from adsl-196-233.cybernet.ch ([212.90.196.233]:28112 "HELO
	mailphish.drugphish.ch") by vger.kernel.org with SMTP
	id <S315859AbSEMHhV>; Mon, 13 May 2002 03:37:21 -0400
Message-ID: <3CDF6CE0.4080604@drugphish.ch>
Date: Mon, 13 May 2002 09:36:00 +0200
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/20020512
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Narancs v1 <narancs@narancs.tii.matav.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: net/ipv4/conf/* config order
In-Reply-To: <Pine.LNX.4.44.0205130845570.2881-100000@helka>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> sysctl -a|grep source
> net/ipv4/conf/eth2/accept_source_route = 1
> net/ipv4/conf/eth1/accept_source_route = 1
> net/ipv4/conf/eth0/accept_source_route = 1
> net/ipv4/conf/lo/accept_source_route = 1
> net/ipv4/conf/default/accept_source_route = 1
> net/ipv4/conf/all/accept_source_route = 0

Basically, accept_source_route says how to handle packets with the SRR 
option set. If 1 (default for a router) it accepts those packets, if 0 
(default for a host) it will drop them. [This is actually written in 
../Documentation/networking/ip-sysctl.txt]

> so does it mean, that source routed packets are all dropped in all
> interfaces, or does it mean that all accepted?

They will be dropped on all interfaces since /all/accept_source_route=0.
Now you need to know that:

/all/${var}     means: enable this feature ${var}
/default/${var} means: inherit /all/${var} on newly instances of a
                        physical interface

> Yes, I want to disable it, and some other parameters, too, so shall I set
> all of them respectively to 0 or 'all' = 0 will do the task?

all=0 should do the task.

Best regards,
Roberto Nibali, ratz

ps.: I don't think this question belongs to lkml, next time you should
      maybe choose linux-net@vger.kernel.org.
-- 
echo '[q]sa[ln0=aln256%Pln256/snlbx]sb3135071790101768542287578439snlbxq'|dc

