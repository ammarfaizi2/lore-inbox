Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312962AbSFGAWf>; Thu, 6 Jun 2002 20:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313181AbSFGAWe>; Thu, 6 Jun 2002 20:22:34 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27399 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S312962AbSFGAWd>;
	Thu, 6 Jun 2002 20:22:33 -0400
Message-ID: <3CFFFC2D.8010104@mandrakesoft.com>
Date: Thu, 06 Jun 2002 20:19:57 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/00200205
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, lei_hu@ali.com.tw,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] update for ALi Audio Driver (0.14.10)
In-Reply-To: <200206062347.g56NlwZ17861@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>>Why?  Hardware semaphores are notorious for causing hangs.  Nobody is 
>>sharing the hardware under Linux, so I think we should enable access on 
>>init, and not disable access until driver close.  IMO the mixer should 
>>be guarded by a Linux kernel semaphore...  I have a patch from Thomas 
>>Sailer (I think) lying around somewhere that does just that to the via 
>>audio driver.  Maybe we can adapt it.
>>(I cc'd this little detail, in my ali/trident.c patch review, to you)
>>    
>>
>
>So add a timeout to it ?
>  
>
There is a problem in via audio, that seems to be present in trident.c 
too:  trident_ioctl_mixdev doesn't protect the call to 
codec->mixer_ioctl, which in turn can read and write to the AC97 codec.

I'm saying, (1) hardware semaphores are error prone and (2) are we using 
the hardware sem to work around this lack of locking on ->mixer_ioctl?

    Jeff




