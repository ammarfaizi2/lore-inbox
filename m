Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030308AbVIVNFz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030308AbVIVNFz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 09:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030302AbVIVNFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 09:05:54 -0400
Received: from gw1.cosmosbay.com ([62.23.185.226]:63673 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S1030308AbVIVNFx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 09:05:53 -0400
Message-ID: <4332AC2E.8000607@cosmosbay.com>
Date: Thu, 22 Sep 2005 15:05:50 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Harald Welte <laforge@netfilter.org>
CC: netdev@vger.kernel.org, netfilter-devel@lists.netfilter.org,
       linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 2/3] netfilter : 3 patches to boost ip_tables performance
References: <432EF0C5.5090908@cosmosbay.com> <200509191948.55333.ak@suse.de>	<432FDAC5.3040801@cosmosbay.com> <200509201830.20689.ak@suse.de>	<433082DE.3060308@cosmosbay.com> <43308324.70403@cosmosbay.com>	<4331D168.6090604@cosmosbay.com> <20050922124803.GH26520@sunbeam.de.gnumonks.org>
In-Reply-To: <20050922124803.GH26520@sunbeam.de.gnumonks.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Thu, 22 Sep 2005 15:05:51 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Harald Welte a écrit :
> On Wed, Sep 21, 2005 at 11:32:24PM +0200, Eric Dumazet wrote:
> 
>>Patch 2/3 (please apply after Patch 1/3)
>>
>>2) Loop unrolling
> 
> 
> First of all, thanks for your performance analysis and patches.  I'm
> very inclined of merging them.
> 
> 
>>It seems that with current compilers and CFLAGS, the code from
>>ip_packet_match() is very bad, using lot of mispredicted conditional branches I made some patches 
>>and generated code on i386 and x86_64
>>is much better.
> 
> 
> This only describes your "compare_if_lstrings()" changes, and I'm happy
> to merge them.
> 
> However, you also removed the use of the FWINV macro and replaced it by
> explicit code (including the bool1/bool2 variables, which are not really
> named intuitively).  Why was this neccessary?
> 

It was necessary to get the best code with gcc-3.4.4 on i386 and gcc-4.0.1 on 
x86_64

For example :

bool1 = FWINV(ret != 0, IPT_INV_VIA_OUT);
if (bool1) {

gives a better code than :

if (FWINV(ret != 0, IPT_INV_VIA_OUT)) {

(one less conditional branch)

Dont ask me why, it is shocking but true :(

Eric

