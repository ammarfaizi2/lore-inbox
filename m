Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262201AbTBLAUE>; Tue, 11 Feb 2003 19:20:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266718AbTBLAUE>; Tue, 11 Feb 2003 19:20:04 -0500
Received: from 60.54.252.64.snet.net ([64.252.54.60]:23772 "EHLO
	hotmale.blue-labs.org") by vger.kernel.org with ESMTP
	id <S262201AbTBLAUC>; Tue, 11 Feb 2003 19:20:02 -0500
Message-ID: <3E4994BE.2040101@blue-labs.org>
Date: Tue, 11 Feb 2003 19:26:38 -0500
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030209
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
CC: Kay Sievers <lkml@vrfy.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.60 defconfig+CONFIG_MODVERSIONS=y -> syntax error
References: <Pine.LNX.4.44.0302101523130.3320-100000@chaos.physics.uiowa.edu>
In-Reply-To: <Pine.LNX.4.44.0302101523130.3320-100000@chaos.physics.uiowa.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

$ sed --version
GNU sed version 4.0.5

(patch works for me too)

-d

Kai Germaschewski wrote:

>On Mon, 10 Feb 2003, Kay Sievers wrote:
>
>  
>
>>On Mon, Feb 10, 2003 at 02:49:36PM -0600, Kai Germaschewski wrote:
>>    
>>
>>>On Mon, 10 Feb 2003, Kay Sievers wrote:
>>>      
>>>
>>>>  ld:arch/i386/kernel/.tmp_time.ver:1: syntax error
>>>>        
>>>>
>>>Interesting. Thanks for testing CONFIG_MODVERSIONS. I cannot reproduce it
>>>here, unfortunately (not even with the same .config). What does
>>>arch/i386/kernel/.tmp_time.ver look like?
>>>      
>>>
>>pim:/usr/src/linux-2.5.60# cat arch/i386/kernel/.tmp_time.ver
>>__crc_i = 0x_lock ;     ac2d2492
>>    
>>
>
>Okay, that's not a problem with ld, but (most likely) sed.
>
>I hope the appended patch fixes it. For the record, what version of sed do 
>you have? (sed -V)
>
>--Kai
>
>
>===== scripts/Makefile.build 1.27 vs edited =====
>--- 1.27/scripts/Makefile.build	Sat Feb  8 14:30:33 2003
>+++ edited/scripts/Makefile.build	Mon Feb 10 15:25:44 2003
>@@ -94,7 +94,7 @@
> 	else								      \
> 		$(CPP) -D__GENKSYMS__ $(c_flags) $<			      \
> 		| $(GENKSYMS) -k $(VERSION).$(PATCHLEVEL).$(SUBLEVEL)	      \
>-		| sed -n 's/\#define __ver_\(\w*\)\W*\(\w*\)/__crc_\1 = 0x\2 ;/gp' \
>+		| sed -n 's/\#define __ver_\([^ 	]*\)[ 	]*\([^ 	]*\)/__crc_\1 = 0x\2 ;/gp' \
> 		> $(@D)/.tmp_$(@F:.o=.ver);				      \
> 									      \
> 		$(LD) $(LDFLAGS) -r -o $@ $(@D)/.tmp_$(@F) 		      \
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>

-- 
I may have the information you need and I may choose only HTML.  It's up to you. Disclaimer: I am not responsible for any email that you send me nor am I bound to any obligation to deal with any received email in any given fashion.  If you send me spam or a virus, I may in whole or part send you 50,000 return copies of it. I may also publically announce any and all emails and post them to message boards, news sites, and even parody sites.  I may also mark them up, cut and paste, print, and staple them to telephone poles for the enjoyment of people without internet access.  This is not a confidential medium and your assumption that your email can or will be handled confidentially is akin to baring your backside, burying your head in the ground, and thinking nobody can see you butt nekkid and in plain view for miles away.  Don't be a cluebert, buy one from K-mart today.

When it absolutely, positively, has to be destroyed overnight.
                           AIR FORCE


