Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932282AbVLLXyK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbVLLXyK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 18:54:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932328AbVLLXyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 18:54:10 -0500
Received: from [69.90.147.196] ([69.90.147.196]:60834 "EHLO mail.kenati.com")
	by vger.kernel.org with ESMTP id S932282AbVLLXyI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 18:54:08 -0500
Message-ID: <439E0E60.10008@kenati.com>
Date: Mon, 12 Dec 2005 15:57:20 -0800
From: Carlos Munoz <carlos@kenati.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Can't build loadable module for 2.6.kernel
References: <439DD4F8.3040709@kenati.com> <20051212205019.GB7656@mars.ravnborg.org>
In-Reply-To: <20051212205019.GB7656@mars.ravnborg.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

Thanks to your help and the kbuild documentation you referred me to I 
was able to build the module.

Thanks again,


Carlos Munoz

Sam Ravnborg wrote:

>On Mon, Dec 12, 2005 at 11:52:24AM -0800, Carlos Munoz wrote:
>  
>
>>Hi all,
>>
>>I hope this is the right forum for this question.
>>    
>>
>Yes.
>
>  
>
>>The makefile has the following rule to build apicnt.o:
>>apicnt.o: apicnt.o.shipped
>>   cp apicnt.o.shipped apicnt.o
>>    
>>
>
>This is wrong. kbuild has knowledge how to copy a file named:
>apicnt.o_shippd to apicnt.o
>So you renamed the supplied .o fiel to apicnt.o_shipped and delte your
>own rule.
>
>
>  
>
>>#
>># Makefile for the phone_mrvl driver loadable module
>>#
>>TARGET = phone_mrvl.o
>>
>>obj-$(CONFIG_PHONE_MARVELL) = phone_mrvl.o
>>
>>ifeq ($(CONFIG_PHONE_LEGERITY),y)
>>phone_mrvl-objs = mrvphone.o slic.o legerity.o vp_hal.o sys_service.o apicnt.o apiinit.o apiquery.o vp_api.o vp_api_common.o mvutils.o
>>endif
>>    
>>
>Please do:
>phone_mrvl-$(CONFIG_PHONE_LEGERITY) := mrvphone.o slic.o legerity.o 
>phone_mrvl-$(CONFIG_PHONE_LEGERITY) += vp_hal.o sys_service.o apicnt.o 
>phone_mrvl-$(CONFIG_PHONE_LEGERITY) += apiinit.o apiquery.o vp_api.o
>phone_mrvl-$(CONFIG_PHONE_LEGERITY) += vp_api_common.o mvutils.o
>
>  
>
>>ifeq ($(CONFIG_PHONE_PROSLIC),y)
>>phone_mrvl-objs = mrvphone.o proslic.o
>>endif
>>    
>>
>phone_mrvl-$(CONFIG_PHONE_PROSLIC) += mrvphone.o proslic.o
>
>  
>
>>CFLAGS += -D__linux__
>>EXTRA_CFLAGS += -Idrivers/telephony/mrvphone
>>EXTRA_CFLAGS += -DNDEBUG -Dlinux -D__linux__ -Dunix -DEMBED -DLINUX -DHOST_LE
>>
>>ifeq ($(CONFIG_PHONE_LEGERITY),y)
>>EXTRA_CFLAGS += -D__LEGERITY__
>>endif
>>ifeq ($(CONFIG_PHONE_PROSLIC),y)
>>EXTRA_CFLAGS += -D__PROSLIC__
>>endif
>>    
>>
>Here you could do:
>extra-cflags-$(CONFIG_PHONE_LEGERITY) += -D__LEGERITY__
>extra-cflags-$(CONFIG_PHONE_PROSLIC)  += -D__PROSLIC__
>EXTRA_CFLAGS += $(extra-cflags-y)
>
>Please delete the rest - it is not needed.
>  
>
>>all: $(TARGET)
>>
>>$(TARGET): $(OBJS)
>>	$(LD) -r $(OBJS) -o $(TARGET)
>>
>>clean:
>>	-rm -f $(TARGET) *.elf *.gdb *.o
>>
>>apicnt.o: apicnt.o.shipped
>>	cp apicnt.o.shipped apicnt.o
>>    
>>
>
>When you build your module use:
>make -C $PATH_TO_COMPILED_KERNEL M=`pwd`
>
>See also Documentation/kbuild/modules.txt for further reference.
>
>	Sam
>  
>

