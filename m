Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313539AbSDHCvx>; Sun, 7 Apr 2002 22:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313540AbSDHCvw>; Sun, 7 Apr 2002 22:51:52 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:63239 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S313539AbSDHCvv>; Sun, 7 Apr 2002 22:51:51 -0400
Message-Id: <200204080251.g382p3997627@aslan.scsiguy.com>
To: Keith Owens <kaos@ocs.com.au>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.19-pre6 standardize {aic7xxx,aicasm}/Makefile 
In-Reply-To: Your message of "Sun, 07 Apr 2002 09:00:44 +1000."
             <25618.1018134044@ocs3.intra.ocs.com.au> 
Date: Sun, 07 Apr 2002 20:51:03 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>3) Why remove the ability to override the module target name?  I eventually
>>   renamed my driver's main file to avoid this issue because I will be adding
>>   a second driver to the aic7xxx/Makefile (U320), but this same thing
>>   will probably come up again.
>
>Your code was the only one that tried to override the module name and
>that was because your code was the only one that was breaking the
>kbuild rules.

My complaint is that kbuild mixes module naming convention with source
file names when they should be separate.  For instance, if RedHat want
to ship my driver as "aic7xxx_experimental.o", they have to rename files
instead of make a single line change to the Makefile.

>When a conglomerate object exists, all the objects that
>make up that conglomerate must have unique names.

I'm complaining about the install target, not the link or compile targets.
The user doesn't really care what the latter are so long as they can find
the module if they build it.

>For u320, ensure that the source is u320_core.c (not u320.c) and the
>conglomerate is u320.o and there will be no problems with the module
>name.

That convention is already being followed.

The only problem I have now is how to map your changes to aic7xxx/Makefile
when it has two targets.  What I'd done prior to your mail was:

1) Build each driver independently using AIC7XXX_OBJS and AIC79XX_OBJS and
   a final LD step.
2) Add each driver .o to obj-$(CONFIG_SCSI_AIC7XXX) and
   obj-$(CONFIG_SCSI_AIC79XX) respectively.
3) Set O_TARGET to aic7xxx_drv.o to handle the case of one or more being
   configured for static linkage.
4) Have scsi/Makefile pull in aic7xxx_drv.o as appropriate.

The version of the Makefile you changed is just an edited down copy of
the above.  Perhaps that explains partially why it was the way it was.
I'd be more than happy to fix this up some other way, but I don't think
I can use the obj-y stuff directly as you have proposed in your patch
once I add the second driver (as soon as we hit Beta which should be
~two weeks away).

--
Justin
