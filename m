Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261587AbVCIUqA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261587AbVCIUqA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 15:46:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262396AbVCIUnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 15:43:41 -0500
Received: from [62.206.217.67] ([62.206.217.67]:33720 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S261587AbVCIUe7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 15:34:59 -0500
Message-ID: <422F5DF0.6060904@trash.net>
Date: Wed, 09 Mar 2005 21:34:56 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.5) Gecko/20050106 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Michal Vanco <vanco@satro.sk>
CC: netdev@oss.sgi.com, Andre Tomt <andre@tomt.net>,
       linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Subject: Re: 2.6.11 on AMD64 traps
References: <200503081900.18686.vanco@satro.sk> <422DF07D.7010908@tomt.net> <422F525F.90404@trash.net> <200503092124.35190.vanco@satro.sk>
In-Reply-To: <200503092124.35190.vanco@satro.sk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Vanco wrote:
> On Wednesday 09 March 2005 20:45, Patrick McHardy wrote:
>>
>>This patch should fix it. The crash is caused by stale pointers,
>>the pointers in fib_iter_state are not reloaded after seq->stop()
>>followed by seq->start(pos > 0).
> 
> Well. Trap vanished after applying this patch, but another weird thing occurs:
> 
> # ip route show | wc -l
> 156033
> # date; time ip route show > /dev/null; date; time netstat -rn > /dev/null
> Wed Mar  9 22:15:21 CET 2005
> 
> real    0m0.656s
> user    0m0.415s
> sys     0m0.242s
> Wed Mar  9 22:15:22 CET 2005
> 
> real    6m41.472s
> user    0m1.261s
> sys     6m40.143s

Yes, I know it is totally inefficient. Just use ip route, which doesn't
suffer from this problem.

Regards
Patrick
