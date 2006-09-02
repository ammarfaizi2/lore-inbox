Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751248AbWIBRtq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbWIBRtq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 13:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbWIBRtq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 13:49:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8875 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751248AbWIBRtq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 13:49:46 -0400
Message-ID: <44F9C430.1060308@osdl.org>
Date: Sat, 02 Sep 2006 10:49:36 -0700
From: Stephen Hemminger <shemminger@osdl.org>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: Matthias Hentges <oe@hentges.net>
CC: shogunx <shogunx@sleekfreak.ath.cx>,
       Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: sky2 hangs on me again: This time 200 kb/s IPv4 traffic, not
 easily reproducable
References: <Pine.LNX.4.44.0609012241230.9870-100000@sleekfreak.ath.cx> <1157217949.18988.1.camel@mhcln03>
In-Reply-To: <1157217949.18988.1.camel@mhcln03>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Hentges wrote:
> Am Freitag, den 01.09.2006, 22:41 -0400 schrieb shogunx:
>   
>>>> Has this not been fixed in the 2.6.18 git?
>>>>         
>>> Good question. I'll try 2.6.18-rc4-mm3 and report back.
>>>       
>> I am having no problems with 2.6.18-rc5, which I just built and tested.
>>     
>
> The NIC is up and running for about 9hrs now w/ -rc4-mm3, thanks for the
> heads up!
>   

My theory still unproven, is that there is a problem with transmit flow 
control and alignment. I have
no direct relation to Marvell, and they tell me nothing about the 
hardware bugs. But it took two
weeks to find a problem where receive flow control was busted when the 
receive buffer was not
aligned on 8 byte boundary. The receiver would stop and not resume. To 
workaround, the driver
ensures alignment of receive buffers. The only clue was that the receive 
DMA FIFO always
had a partial count left in it.

There may well be a similar problem on transmit; since driver has no 
control over transmit buffer
alignment, fixing it would require copying most transmit data, or a hack 
all the way up in protocols.
Maybe if the driver lied about the hard header length, it could fool the 
protocols.

Probably better just to always negotiate no transmit flow control.

-- 
VGER BF report: H 0.232987
