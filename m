Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272372AbRH3SAA>; Thu, 30 Aug 2001 14:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272384AbRH3R7u>; Thu, 30 Aug 2001 13:59:50 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:48633 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S272372AbRH3R7a>; Thu, 30 Aug 2001 13:59:30 -0400
Message-ID: <3B8E7F0D.3000503@redhat.com>
Date: Thu, 30 Aug 2001 13:59:41 -0400
From: Doug Ledford <dledford@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3+) Gecko/20010829
X-Accept-Language: en-us
MIME-Version: 1.0
To: "Kevin P. Fleming" <kevin@labsysgrp.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.9-ac1 RAID-5 resync causes PPP connection to be unusable
In-Reply-To: <05c501c13178$43e19ba0$6caaa8c0@kevin>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin P. Fleming wrote:

> I ran into a very strange problem yesterday... my server here, which is a
> 700 MHz Celeron, 256MiB RAM, four ~40G disks has two RAID-5 arrays (using
> the standard kernel MD driver) configured across those four drives. For some
> reason definitely related to operator error, the machine crashed and needed
> to resync the arrays after being rebooted.
> 
> Eveything was working fine, interactive response was just fine even though
> the drives were just cranking away doing their resync. I then brought up my
> PPP Internet connection, which came up just fine. However, I was _not_ able
> to actually communicate with any 'Net hosts.


[ snip ]


> I can probably reproduce this pretty easily, if anyone is interested and can
> give me some idea where to look for the cause...


Don't bother.  The problem is that your disks are IDE disks and you 
don't have IRQ unmasking enabled on some/all of them.  As long as that's 
the case, heavy disk activity (whether it's a RAID5 resync or a bonnie 
run or untar'ing a kernel archive) will always cause your PPP connection 
to quit working due to dropped serial data and therefore corrupted PPP 
packets.


-- 

  Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
       Please check my web site for aic7xxx updates/answers before
                       e-mailing me about problems

