Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275240AbTHMPg7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 11:36:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275239AbTHMPg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 11:36:59 -0400
Received: from fep05-svc.mail.telepac.pt ([194.65.5.209]:22939 "EHLO
	fep05-svc.mail.telepac.pt") by vger.kernel.org with ESMTP
	id S275251AbTHMPfv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 11:35:51 -0400
Message-ID: <3F3A5B06.7050103@vgertech.com>
Date: Wed, 13 Aug 2003 16:36:38 +0100
From: Nuno Silva <nuno.silva@vgertech.com>
Organization: VGER, LDA
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030714 Debian/1.4-2
X-Accept-Language: en-us, pt
MIME-Version: 1.0
To: Ken Savage <kens1835@shaw.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: High CPU load with kswapd and heavy disk I/O
References: <200308121136.11979.kens1835@shaw.ca> <200308121323.49081.kens1835@shaw.ca> <3F397CED.6060006@vgertech.com> <200308121714.36993.kens1835@shaw.ca>
In-Reply-To: <200308121714.36993.kens1835@shaw.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Ken Savage wrote:
> On Tue August 12 2003 16:49, Nuno Silva wrote:
> 
> 
>>My guess is that this is the cause. LOWMEM pressure because of very
>>large directories... Relating to this, linux-2.6.0-test3-mm1 has Ingo's
>>4G/4G memory split. Can you try this kernel, enable 4G/4G feature, and
>>report back?
> 
> 
> Something about the 2.6 (and the rmap patched 2.4) kernels causes
> lockouts on the server -- for reasons OTHER than kswapd.  The server

If you want to help, you could try to gather more info on that to help 
develope a better 2.6 ;)

FWIW, 2.6.0-test* with mm patches works well here... At least in a few 
boxes.


> running the delete-old-files process runs hundreds of other CPU and disk
> I/O intensive processes/threads, and it doesn't look like 2.6 is yet able
> to handle the load.  Unfortunately, the server is a production environment
> machine at a remote site, so lockouts/reboots/kernel panics are baaaad :(
> 
> I've seen other mentions of kswapd/kupdated problems in 2.4.xx, but
> few mentions of solutions.  Have people just learned to avoid the
> situations that trigger the mad thrashes?
> 


If you're sure that it's really kswapd you can send SIGSTOP and SIGCONT 
to kswapd's pid. Kswapd will honor those signals.

killall -STOP kswapd
<run your I/O intensive scripts>
killall -CONT kswapd

Sometimes I do this... For me it works well. If this makes your machine 
crash or loose data, don't blame me! ;)

Regards,
Nuno Silva


> Ken
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

