Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266459AbUG0QXx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266459AbUG0QXx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 12:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266449AbUG0QWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 12:22:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45961 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266459AbUG0QWM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 12:22:12 -0400
Message-ID: <41068126.3000009@pobox.com>
Date: Tue, 27 Jul 2004 12:21:58 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dominik Karall <dominik.karall@gmx.net>
CC: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Daniele Venzano <webvenza@libero.it>
Subject: Re: SiS900: NULL pointer encountered in Rx ring, skipping
References: <200407232052.06616.dominik.karall@gmx.net> <41067418.9020000@pobox.com> <200407271814.59859.dominik.karall@gmx.net>
In-Reply-To: <200407271814.59859.dominik.karall@gmx.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dominik Karall wrote:
> On Tuesday 27 July 2004 17:26, Jeff Garzik wrote:
> 
>>Dominik Karall wrote:
>>
>>>After a few hours my network doesn't work on my laptop. There appear a
>>>lot of those messages:
>>>
>>>eth0: NULL pointer encountered in Rx ring, skipping
>>>eth0: NULL pointer encountered in Rx ring, skipping
>>>eth0: NULL pointer encountered in Rx ring, skipping
>>>eth0: NULL pointer encountered in Rx ring, skipping
>>>eth0: NULL pointer encountered in Rx ring, skipping
>>>eth0: NULL pointer encountered in Rx ring, skipping
>>>eth0: NULL pointer encountered in Rx ring, skipping
>>>eth0: NULL pointer encountered in Rx ring, skipping
>>>eth0: NULL pointer encountered in Rx ring, skipping
>>>eth0: NULL pointer encountered in Rx ring, skipping
>>>
>>>It works again after restarting network. I'm using 2.6.8-rc2 now. It was
>>>the same problem in 2.6.7, but I didn't test it with earlier kernels.
>>
>>A NULL appears when the machine is temporarily unable to allocate room
>>for a new skb.  Your machine's atomic memory pools are getting too low...
>>
>>	Jeff
> 
> 
> Yes, I took a look at the code and found the debug message. But isn't there 
> any way to avoid network stop working? Because after a network restart it 
> works again, maybe there could be used any "soft reset" to make network 
> working again after such an error.

The OOM problem is completely unrelated to the network, therefore no 
reset should ever be considered for this condition.

The driver should properly handle the 'NULL in rx ring' condition as a 
normal occurence.  It should skip to the next available skb in the ring. 
  If no skbs are remain, it should drop the skb.

See natsemi.c for additional -- and optional -- OOM handling techniques.

	Jeff


