Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261799AbTBEQru>; Wed, 5 Feb 2003 11:47:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261836AbTBEQru>; Wed, 5 Feb 2003 11:47:50 -0500
Received: from 216-239-45-4.google.com ([216.239.45.4]:57986 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id <S261799AbTBEQrt>; Wed, 5 Feb 2003 11:47:49 -0500
Message-ID: <3E414243.4090303@google.com>
Date: Wed, 05 Feb 2003 08:56:35 -0800
From: Ross Biro <rossb@google.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: alan@redhat.com, Stephan von Krawczynski <skraw@ithnet.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-pre4: PDC ide driver problems with shared interrupts
References: <20030202161837.010bed14.skraw@ithnet.com>	 <3E3D4C08.2030300@pobox.com> <20030202185205.261a45ce.skraw@ithnet.com>	 <3E3D6367.9090907@pobox.com>  <20030205104845.17a0553c.skraw@ithnet.com> <1044443761.685.44.camel@zion.wanadoo.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:

>>Okay, I had to watch for it a bit longer and it turns out that the kernel PDC driver has a problem in this shared interrupt setup. When loads get high it seems to run into some timing problem which causes things like:
>>
>>Feb  4 01:02:22 admin kernel: hde: dma_intr: status=0xd0 { Busy }
>>
>>    
>>
Since the busy bit is set, we know the drive must have received a 
command.  Since dma_intr thought the drive was not busy, an interrupt 
must have snuck through between the command being issued and the dma 
being started.  I think in my original patch, I had the dma start 
outside of the spinlock, that is a bug.  The command to the controller 
to start the dma must be inside of the spinlock.

I have not looked at 2.4.21-pre4 at all, so I could be entirely off base 
here.

    Ross

