Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965055AbWJWTU3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965055AbWJWTU3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 15:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965065AbWJWTU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 15:20:29 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:19174 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965048AbWJWTU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 15:20:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=cqBfaPlahk9mo/F0gmTZjQdoZ2KeY/aVfswYleq4A5KonwrJtuJ0T7vozbGjbZEO8NdowMtpCXC9lxYBsMsKiZVkHBklrSjGo67WpnEVotavbR4I5HBjk/eCYxdb4iRVQFBZkk/YbhIic0feOitMgL6g8kgYSXcq6uvOJhaUYQw=
Message-ID: <6278d2220610231220r7cfd95b4ueac267e511162e0e@mail.gmail.com>
Date: Mon, 23 Oct 2006 20:20:26 +0100
From: "Daniel J Blueman" <daniel.blueman@gmail.com>
To: "Stephen Hemminger" <shemminger@osdl.org>
Subject: Re: [PATCH] sky2: 88E803X transmit lockup
Cc: "Linux Netdev" <netdev@vger.kernel.org>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger wrote:
> The reason sky2 driver was locking up on transmit on the Yukon-FE chipset
> is that it was misconfiguring the internal RAM buffer so the transmitter
> and receiver were sharing the same space.
>
> The code assumed there was 16K of RAM on Yukon-FE (taken from vendor driver
> sk98lin which is even more f*cked up on this). Then it assigned based on that.
> The giveaway was that the registers would only hold 9bits so both RX/TX
> had 0..1ff for space. It is a wonder it worked at all!
>
> This patch addresses this, and fixes an easily reproducible hang on Transmit.
> Only the Yukon-FE chip is Marvell 88E803X (10/100 only) are affected.
[snip]

This patch works great - without it, I get only a few minutes of use
from my home dir over NFS4 before the NIC stops transmitting. This is
on a recent Yonah Sony VGN-SZ notebook w/ 88E8036 Marvel Sk-Y2.

Thanks again Stephen!
-- 
Daniel J Blueman
