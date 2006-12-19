Return-Path: <linux-kernel-owner+w=401wt.eu-S1751007AbWLSNIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751007AbWLSNIK (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 08:08:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbWLSNIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 08:08:09 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:34519 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751005AbWLSNII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 08:08:08 -0500
Date: Tue, 19 Dec 2006 14:07:17 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Patrick McHardy <kaber@trash.net>
cc: Netfilter Developer Mailing List 
	<netfilter-devel@lists.netfilter.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] xt_request_find_match
In-Reply-To: <4587D227.1000003@trash.net>
Message-ID: <Pine.LNX.4.61.0612191405160.24179@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0612161851180.30896@yvahk01.tjqt.qr>
 <4587D227.1000003@trash.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 19 2006 12:51, Patrick McHardy wrote:
>> Reusing code is a good idea, and I would like to do so from my 
>> match modules. netfilter already provides a xt_request_find_target() but 
>> an xt_request_find_match() does not yet exist. This patch adds it.
>
>Why does your match module needs to lookup other matches?

To use them?

I did not want to write


some_xt_target() {
    if(skb->nh.iph->protocol == IPPROTO_TCP)
        do_this();
    else
        do_that();
}

since the xt_tcpudp module provides far more checks than just the protocol
(TCP/UDP), like

    /* To quote Alan:

       Don't allow a fragment of TCP 8 bytes in. Nobody normal
       causes this. Its a cracker trying to break in by doing a
       flag overwrite to pass the direction checks.
    */

(see xt_tcpudp.c)



	-`J'
-- 
