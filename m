Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932081AbVIDRbc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbVIDRbc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 13:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932080AbVIDRbc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 13:31:32 -0400
Received: from mail.collax.com ([213.164.67.137]:59111 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S932078AbVIDRbb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 13:31:31 -0400
Message-ID: <431B2F6E.9070401@trash.net>
Date: Sun, 04 Sep 2005 19:31:26 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: Andrew Morton <akpm@osdl.org>, jmcgowan@inch.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       davem@davemloft.net
Subject: Re: Kernel 2.6.13 breaks libpcap (and tcpdump).
References: <E1EBpkT-0001RP-00@gondolin.me.apana.org.au> <431B2985.1060502@trash.net>
In-Reply-To: <431B2985.1060502@trash.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick McHardy wrote:
> Herbert Xu wrote:
> 
>> We aren't handling the reading of specific fields like the IP protocol
>> field correctly.  This patch should make it work again.
> 
> 
> I can't spot the problem, could you give me a hint?

Never mind, I got it, we never fall through to the second switch
statement anymore. I think we could simply break when load_pointer
returns NULL. The switch statement will fall through to the default
case and return 0 for all cases but 0 > k >= SKF_AD_OFF.
