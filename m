Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263230AbVGaOFs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263230AbVGaOFs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 10:05:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263231AbVGaOFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 10:05:48 -0400
Received: from hulk.hostingexpert.com ([69.57.134.39]:62326 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S263230AbVGaOFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 10:05:47 -0400
Message-ID: <42ECDAC1.5050305@m1k.net>
Date: Sun, 31 Jul 2005 10:05:53 -0400
From: Michael Krufky <mkrufky@m1k.net>
Reply-To: mkrufky@m1k.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [HOWTO] set extra_cflags to indicate compilation against -mm
 kernels
References: <42EBF131.60507@m1k.net> <20050731084406.GA8588@mars.ravnborg.org>
In-Reply-To: <20050731084406.GA8588@mars.ravnborg.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:

>On Sat, Jul 30, 2005 at 05:29:21PM -0400, Michael Krufky wrote:
>  
>
>>With the addition of topdir-mm.patch into the -mm tree (since 
>>2.6.13-rc3-mm2), it is now possible for Makefile to detect whether a cvs 
>>subtree is being built against -mm or not...  -mm kernels now have a .mm 
>>file in the top level directory.
>>
>>inside Makefile:
>>
>>mm-kernel := $(TOPDIR)/.mm
>>ifneq ($(mm-kernel),)
>>MM_KERNEL_CFLAGS	:= -DMM_KERNEL=$(shell cat $(mm-kernel) 2> /dev/null)
>>ifneq ($(MM_KERNEL_CFLAGS),-DMM_KERNEL=)
>>EXTRA_CFLAGS		+= $(MM_KERNEL_CFLAGS)
>>endif
>>endif
>>    
>>
>
>Hi Michael.
>The content of the .mm file seems to be insignificant - '1'. The important
>issue is that the file is present.
>Also please do not use $(TOPDIR) - it is deprecated.
>
>The following is enough:
>EXTRA_CFLAGS += $(if $(wildcard $(srctree)/.mm), -DMM_KERNEL)
>
>If the file exist in the root of the kernel src tree MM_KERNEL will be
>added to EXTRA_CFLAGS.
>
Sam-

Thank you!  I knew there might be a more efficient way to do that, so 
I'm glad I sent that to LKML for you to see ;-)

Still, I think it should be added into the documentation somewhere... 
I'd be happy to submit a patch, I just don't know where it should go.  
Obviously, this is specific to -mm kernels only.  Do you know?

-- 
Michael Krufky

