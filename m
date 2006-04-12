Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751188AbWDLAcV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbWDLAcV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 20:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbWDLAcU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 20:32:20 -0400
Received: from mailer1.psc.edu ([128.182.58.100]:8954 "EHLO mailer1.psc.edu")
	by vger.kernel.org with ESMTP id S1751181AbWDLAcU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 20:32:20 -0400
Message-ID: <443C4A8C.8070407@psc.edu>
Date: Tue, 11 Apr 2006 20:32:12 -0400
From: John Heffner <jheffner@psc.edu>
User-Agent: Thunderbird 1.5 (Macintosh/20051201)
MIME-Version: 1.0
To: Daniel Drake <dsd@gentoo.org>
CC: Stephen Hemminger <shemminger@osdl.org>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.17 regression: Very slow net transfer from some hosts
References: <443C03E6.7080202@gentoo.org>	<443C024C.2070107@psc.edu>	<443C0B74.50305@gentoo.org>	<443C09A7.2040900@psc.edu>	<443C1738.20605@gentoo.org>	<443C178B.3030805@psc.edu>	<443C2BBA.5010804@gentoo.org> <20060411153315.4132b477@localhost.localdomain> <443C4471.7040407@gentoo.org>
In-Reply-To: <443C4471.7040407@gentoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Drake wrote:
> Stephen Hemminger wrote:
>> Turn off TCP window scaling, your performance will be limited but about
>> as good as you can get with a corrupting firewall in between.

[snip]

> For anyone else interested, the ISP is NTL (UK). The fix:
> 
>     echo "4096    16384   131072 " > /proc/sys/net/ipv4/tcp_wmem
>     echo "4096    87380   174760 " > /proc/sys/net/ipv4/tcp_rmem

For the record, I think Stephen's suggested workaround is better:

echo 0 > /proc/sys/net/ipv4/tcp_window_scaling

It will prevent the other end of the connection from using a window 
scale, so it "fixes" both directions of the connection, not just receiving.

Thanks,
   -John
