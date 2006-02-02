Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932178AbWBBRKg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbWBBRKg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 12:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932182AbWBBRKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 12:10:36 -0500
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:43676 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S932178AbWBBRKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 12:10:35 -0500
In-Reply-To: <6E8F349B-CD5A-473E-A2E1-21CFD949E83E@kernel.crashing.org>
References: <Pine.LNX.4.44.0602011911360.22854-100000@gate.crashing.org> <1138844838.5557.17.camel@localhost.localdomain> <A20324D8-446C-4760-9ECC-64FA9736E783@kernel.crashing.org> <6E8F349B-CD5A-473E-A2E1-21CFD949E83E@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <7A548B5C-4473-4786-93FF-BBAFADA906F8@kernel.crashing.org>
Cc: rmk+kernel@arm.linux.org.uk, LKML List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: 8250 serial console fixes -- issue
Date: Thu, 2 Feb 2006 11:10:38 -0600
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
X-Mailer: Apple Mail (2.746.2)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Feb 2, 2006, at 2:05 AM, Kumar Gala wrote:

>
> On Feb 1, 2006, at 11:54 PM, Kumar Gala wrote:
>
>>
>> On Feb 1, 2006, at 7:47 PM, Alan Cox wrote:
>>
>>> On Mer, 2006-02-01 at 19:21 -0600, Kumar Gala wrote:
>>>> This patch introduces an issue for me an embedded PowerPC SoC  
>>>> using the
>>>> 8250 driver.
>>>>
>>>> The simple description of my issue is this:  I'm using the  
>>>> serial port for
>>>> both a terminal and console.  I run fdisk on a /dev/hda.  Before  
>>>> this
>>>> patch I would get the prompt for fdisk immediately.  After this  
>>>> patch I
>>>> have to hit return before the prompt is displayed.
>>>>
>>>> I know that's not a lot of info, but just let me know what else  
>>>> you need
>>>> to help debug this.
>>>>
>>>> I'm guessing something about the UARTs on the PowerPC maybe bit  
>>>> a little
>>>> non-standard.
>>>
>>> I wonder if I've swapped one race for another. Can you revert  
>>> just the
>>> line which forces THRI on and test with the rest of the change  
>>> please.
>>
>> This doesn't seem to help.
>
> I realized a bit later that the kernel I build with your suggested  
> change wasn't the one I was testing.  After loading the proper  
> kernel this does make the issue I was seeing go away.

After some further testing with this change, the majority of issues I  
was seeing go away.  However, able to lock the console up. If I  
revert the wait_for_xmitr() to always use BOTH_EMPTY the lock up goes  
away.  (Obviously, this is effectively reverting the whole patch).

- kumar
