Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261718AbVC1M6r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261718AbVC1M6r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 07:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261695AbVC1M6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 07:58:47 -0500
Received: from relay1.tiscali.de ([62.26.116.129]:51923 "EHLO
	webmail.tiscali.de") by vger.kernel.org with ESMTP id S261718AbVC1M55
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 07:57:57 -0500
Message-ID: <4247FE6C.3060805@tiscali.de>
Date: Mon, 28 Mar 2005 14:54:04 +0200
From: Matthias-Christian Ott <matthias.christian@tiscali.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050108)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Jean Delvare <khali@linux-fr.org>
CC: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: Re: Do not misuse Coverity please (Was: sound/oss/cs46xx.c: fix a
 check after use)
References: <20050327205014.GD4285@stusta.de>	<20050327232158.46146243.khali@linux-fr.org>	<20050327214323.GH4285@stusta.de> <20050328003401.7b3cf380.khali@linux-fr.org>
In-Reply-To: <20050328003401.7b3cf380.khali@linux-fr.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Delvare schrieb:

>Hi Adrian,
>
>  
>
>>There are two cases:
>>1. NULL is impossible, the check is superfluous
>>2. this was an actual bug
>>    
>>
>
>Agreed.
>
>  
>
>>In the first case, my patch doesn't do any harm (a superfluous isn't
>>a real bug).
>>    
>>
>
>The fact that it isn't a bug does not imply that the patch doesn't harm.
>Tricking the reader into thinking that something can happen when it in
>fact cannot does possibly harm in the long run.
>
>  
>
>>In the second case, it fixed a bug.
>>It might be a bug not many people hit because it might be in some
>>error path of some esoteric driver.
>>    
>>
>
>True, except that e.g. the sg_mmap() function of scsi/sg hardly falls
>into this category. Same for fbcon_init() in video/console/fbcon. You
>don't seem to treat core code any differently than esoteric drivers.
>
>  
>
>>If a maintainer of a well-maintained subsystem like i2c says
>>"The check is superfluous." that's the perfect solution.
>>
>>But in less maintained parts of the kernel, even a low possibility
>>that it fixes a possible bug is IMHO worth making such a riskless
>>patch.
>>    
>>
>
>This is where my opinion strongly differs.
>
>The very fact that these "check after use" cases were not fixed yet
>means that they are not hit frequently, if ever, regardless of how
>popular the driver is. This means that we have (relatively) plenty of
>time to fix them. At least Coverity or a similar tool will keep
>reminding us to take a look and decide what must be done after we
>carefully checked the code. Your approach will not let us do that.
>Mass-posting these patches here is likely to make them end in Andrew's
>tree soon and to Linus' right after that is nobody objects, right?
>
>If you can make sure that none of these patches ever reaches Linus' tree
>without their respective driver maintainer having confirmed that they
>were the right thing to do, then fine with me, but it doesn't look like
>the way things will go. I think that you'd be better just telling the
>maintainers about the problem without providing an arbitrary patch, so
>that they will actually look into the problem with their advanced
>knowledge of the driver, rather than merely ack'ing that the patch looks
>OK, which I think is what will happen with your method. (I'd love to be
>proven wrong though.)
>
>Thanks,
>  
>
Hi!
I fully disagree with you opinion.

   1. Adrian sent this patches to the LKML _and_ to their maintainers.
      So the patches can be proved by 2 instances and not Adrian has to
      do this (of course he has to filter non-sense patches (I   think
      he did so)).
   2. I don't know in which case NULL pointers are usefull, but it seems
      they're.
   3. Not only Maintainers have knowledge about the driver and can
      decide whether a patch is useful or not (this hierarchical
      structure is outdated (it's adapeted from the middle ages and a
      reason why many developers (like me) don't want to waste their
      time on fixing little Kernel bugs (in most cases you have to
      resend your patch several times to get it appllied))). This only
      elongates the development time and is not necessary because as
      mentioned above it's sent to the LKML and the maintainers have
      subscribed the LKML and can give their comment here and not in a
      private discussion.

Because of this I recommend everybody to use such tools and sent such 
patches, increasing the quality of the source and fixing problems like 
the problems Adrians patches fix, to the LKML.

Matthias-Christian Ott



