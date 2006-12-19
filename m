Return-Path: <linux-kernel-owner+w=401wt.eu-S1751976AbWLSN3D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751976AbWLSN3D (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 08:29:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751787AbWLSN3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 08:29:03 -0500
Received: from stinky.trash.net ([213.144.137.162]:50801 "EHLO
	stinky.trash.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751784AbWLSN3B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 08:29:01 -0500
Message-ID: <4587E91A.2020903@trash.net>
Date: Tue, 19 Dec 2006 14:28:58 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: Netfilter Developer Mailing List 
	<netfilter-devel@lists.netfilter.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] xt_request_find_match
References: <Pine.LNX.4.61.0612161851180.30896@yvahk01.tjqt.qr> <4587D227.1000003@trash.net> <Pine.LNX.4.61.0612191405160.24179@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0612191405160.24179@yvahk01.tjqt.qr>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
> On Dec 19 2006 12:51, Patrick McHardy wrote:
> 
>>>Reusing code is a good idea, and I would like to do so from my 
>>>match modules. netfilter already provides a xt_request_find_target() but 
>>>an xt_request_find_match() does not yet exist. This patch adds it.
>>
>>Why does your match module needs to lookup other matches?
> 
> 
> To use them?
> 
> I did not want to write
> 
> 
> some_xt_target() {
>     if(skb->nh.iph->protocol == IPPROTO_TCP)
>         do_this();
>     else
>         do_that();
> }

I don't think

xt_request_find_match(match->family, "tcp", 0)->match(lots of arguments)

is better than a simple comparison. Besides that the tcp match itself
expects that the protocol match already checked for IPPROTO_TCP, so
you'd still have to do it.

> since the xt_tcpudp module provides far more checks than just the protocol
> (TCP/UDP), like
> 
>     /* To quote Alan:
> 
>        Don't allow a fragment of TCP 8 bytes in. Nobody normal
>        causes this. Its a cracker trying to break in by doing a
>        flag overwrite to pass the direction checks.
>     */

This check makes sure the flags are not overwritten _after you
matched on them_. It doesn't matter at all if you're only
interested in the protocol since the user didn't tell you to care.

