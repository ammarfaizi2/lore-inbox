Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261679AbULZPne@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261679AbULZPne (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 10:43:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261687AbULZPm6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 10:42:58 -0500
Received: from [62.206.217.67] ([62.206.217.67]:28857 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S261679AbULZPkW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 10:40:22 -0500
Message-ID: <41CEDB2B.7080309@trash.net>
Date: Sun, 26 Dec 2004 16:39:23 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
MIME-Version: 1.0
To: lists@naasa.net
CC: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.10 with IPSEC problems?
References: <200412261553.24178.lists@naasa.net>
In-Reply-To: <200412261553.24178.lists@naasa.net>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Platte wrote:
> Hi!
> 
> After an upgrade from 2.6.9 to 2.6.10 my IPSEC tunnel does not work as usual. 
> My computer and the VPN-gateway can negotiate and build a tunnel and packets 
> can use the tunnel. But then packets which must be routed get lost somewhere 
> inside the kernel. tcpdump shows them first encrypted in ESP packets and then 
> the unencrypted payload on the same interface. But they do not leave the 
> kernel on the destination interface. Only packets with my computer as 
> destination are processed. I did not change my IPSEC configuration and the 
> kernel was configured using "make oldconfig".
> 
> Is there a problem in the routing layer somewhere inside the kernel or an 
> internal change which requires a configuration change on my side? How can I 
> determine, where and why the packets inside the kernel are thrown away?
> 
> To verify the problem I build a 2.6.10 kernel on the VPN gateway. And this 
> kernel seems to have the same problem. Previously encrypted packets are not 
> routed to th destination.
> 
> Downgrading to 2.6.9 solved the problem in both cases...

Since Linux 2.6.10-rcX. packets from a tunnel-mode SA are dropped if
no policy exists. You most likely only have an input policy, but no
forward policy. If you use setkey to configure your policies,
duplicate the input policy and replace "-P in" with "-P fwd". If you
let racoon generate the policy you need to upgrade to the latest
version. pluto should already get it right.

Regards
Patrick



> 
> Regards,
> Jörg
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

