Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264285AbTJOUNg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 16:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264286AbTJOUNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 16:13:36 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:9140 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S264285AbTJOUNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 16:13:35 -0400
Message-ID: <3F8DAA6B.7060609@nortelnetworks.com>
Date: Wed, 15 Oct 2003 16:13:31 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: question on incoming packets and scheduler
References: <3F8CA55C.1080203@nortelnetworks.com> <Pine.LNX.4.56.0310151035480.2144@bigblue.dev.mdolabs.com> <3F8D8F3A.5040506@nortelnetworks.com> <Pine.LNX.4.56.0310151133030.2144@bigblue.dev.mdolabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> On Wed, 15 Oct 2003, Chris Friesen wrote:

>>It appears that 2.4.20 fixes this issue, but there is another one
>>remaining that the latency appears to be dependent on the number of
>>incoming packets.  See thread "incoming packet latency in 2.4.[18-20]"
>>for details.  This behaviour doesn't show up in 2.6, and I'm about to
>>test 2.4.22.

> Are you sure it's not a livelock issue during the burst?

I dunno, you tell me.

The test app simply sits in select() until a packet comes in, then it 
spins on recvmsg() until there are no more messages.  It uses 
SO_TIMESTAMP to find out when the packet got to the kernel, and does a 
gettimeofday() right after the recvmsg(), then calculates the delta for 
each packet and the overall average.

With 2.4.[18-20], the overall average goes up when the number of packets 
goes up.  For 2.6.0-test6, it stays constant.

Chris




-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

