Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964811AbVJaTuT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964811AbVJaTuT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 14:50:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964813AbVJaTuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 14:50:19 -0500
Received: from baldrick.bootc.net ([83.142.228.48]:50865 "EHLO
	baldrick.bootc.net") by vger.kernel.org with ESMTP id S964811AbVJaTuS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 14:50:18 -0500
Message-ID: <43667578.8010902@bootc.net>
Date: Mon, 31 Oct 2005 19:50:16 +0000
From: Chris Boot <bootc@bootc.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051014)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David R <david@unsolicited.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.14 and old versions of traceroute
References: <4366708B.4080900@unsolicited.net>
In-Reply-To: <4366708B.4080900@unsolicited.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David R wrote:
> I've noticed that old versions of traceroute no longer work properly
> with the latest kernel. 2.6.13.4 is OK. I've done a bit of strace and am
> posting the differences here. These are from a 64 bit kernel using
> traceroute 0.6.2 as shipped with most versions of SuSE. I have confirmed
> that the same problem is present in a 32 bit kernel on a different
> machine. A later traceroute 1.4a12 works properly.
> 
> 2.6.13.4
> 
> poll([{fd=6, events=POLLERR, revents=POLLERR}, {fd=3, events=POLLERR},
> {fd=4, events=POLLERR}, {fd=5, events=POLLERR}], 4, 1) = 1
> recvmsg(6, {msg_name(16)={sa_family=AF_INET, sin_port=htons(33443),
> sin_addr=inet_addr("69.10.132.115")}, msg_iov(0)=[], msg_controllen=80,
> {cmsg_len=32, cmsg_level=SOL_SOCKET, cmsg_type=0x1d /* SCM_??? */, ...},
> msg_flags=MSG_ERRQUEUE}, MSG_ERRQUEUE) = 0
> 
> 
> 2.6.14
> poll([{fd=3, events=POLLERR, revents=POLLERR}, {fd=4, events=POLLERR},
> {fd=5, events=POLLERR}, {fd=6, events=POLLERR}, {fd=7, events=POLLERR},
> {fd=8, events=POLLERR}], 6, 1) = 1
> recvmsg(3, 0x7fffffa30960, MSG_ERRQUEUE) = -1 EAGAIN (Resource
> temporarily unavailable)
> ....
> ....
> poll([{fd=3, events=POLLERR, revents=POLLERR}, {fd=4, events=POLLERR,
> revents=POLLERR}, {fd=5, events=POLLERR}, {fd=6, events=POLLERR}, {fd=7,
> events=POLLERR}, {fd=8, events=POLLERR}, {fd=9, events=POLLERR}], 7, 1) = 2
> recvmsg(3, 0x7fffffa30960, MSG_ERRQUEUE) = -1 EAGAIN (Resource
> temporarily unavailable)
> recvmsg(4, 0x7fffffa30960, MSG_ERRQUEUE) = -1 EFAULT (Bad address)
> 
> I'm up for more diagnostics if necessary.
> 
> Cheers
> David

Smells suspiciously similar to the BIND trouble that's been reported 
here in the last few days:

http://lkml.org/lkml/2005/10/29/247
http://lkml.org/lkml/2005/10/30/32

You might like to look into it on the netdev list.

HTH,
Chris

-- 
Chris Boot
bootc@bootc.net
http://www.bootc.net/
