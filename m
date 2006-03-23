Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932463AbWCWQQT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932463AbWCWQQT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 11:16:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030260AbWCWQQT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 11:16:19 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:45247 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S932120AbWCWQQS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 11:16:18 -0500
Message-ID: <4422C9BC.3090400@cosmosbay.com>
Date: Thu, 23 Mar 2006 17:15:56 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Jesper Dangaard Brouer <hawk@diku.dk>
CC: "David S. Miller" <davem@davemloft.net>, dipankar@in.ibm.com,
       Robert Olsson <Robert.Olsson@data.slu.se>, jens.laas@data.slu.se,
       hans.liss@its.uu.se, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org, mike.stroyan@hp.com,
       Suresh Bhogavilli <sbhogavilli@verisign.com>
Subject: Re: Kernel panic: Route cache, RCU, possibly FIB trie.
References: <Pine.LNX.4.61.0603211113550.15500@ask.diku.dk> <20060321.023705.26111240.davem@davemloft.net> <Pine.LNX.4.61.0603211538280.28173@ask.diku.dk> <20060321.132514.24407022.davem@davemloft.net> <Pine.LNX.4.61.0603231536180.29788@ask.diku.dk> <Pine.LNX.4.61.0603231637360.29788@ask.diku.dk>
In-Reply-To: <Pine.LNX.4.61.0603231637360.29788@ask.diku.dk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Thu, 23 Mar 2006 17:15:58 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Dangaard Brouer a écrit :

>> grep . /proc/sys/net/ipv4/route/*
>> /proc/sys/net/ipv4/route/error_burst:5000
>> /proc/sys/net/ipv4/route/error_cost:1000
>> grep: /proc/sys/net/ipv4/route/flush: Operation not permitted
>> /proc/sys/net/ipv4/route/gc_elasticity:8
>> /proc/sys/net/ipv4/route/gc_interval:60
>> /proc/sys/net/ipv4/route/gc_min_interval:0
>> /proc/sys/net/ipv4/route/gc_min_interval_ms:500
>> /proc/sys/net/ipv4/route/gc_thresh:65536
>> /proc/sys/net/ipv4/route/gc_timeout:300
>> /proc/sys/net/ipv4/route/max_delay:10
>> /proc/sys/net/ipv4/route/max_size:1048576
>> /proc/sys/net/ipv4/route/min_adv_mss:256
>> /proc/sys/net/ipv4/route/min_delay:2
>> /proc/sys/net/ipv4/route/min_pmtu:552
>> /proc/sys/net/ipv4/route/mtu_expires:600
>> /proc/sys/net/ipv4/route/redirect_load:20
>> /proc/sys/net/ipv4/route/redirect_number:9
>> /proc/sys/net/ipv4/route/redirect_silence:20480
>> /proc/sys/net/ipv4/route/secret_interval:600

I would say : Change the settings :)

echo 2 > /proc/sys/net/ipv4/route/gc_elasticity
echo 1 > /proc/sys/net/ipv4/route/gc_interval
echo 131072 > /proc/sys/net/ipv4/route/gc_thresh

and watch the output of :

rtstat -c 100 -i 1

(you might have to recompile lnstat/rtstat from iproute2 package from

http://developer.osdl.org/dev/iproute2/download/

Eric
