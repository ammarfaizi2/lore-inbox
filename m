Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbVLLTtO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbVLLTtO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 14:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbVLLTtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 14:49:14 -0500
Received: from [69.90.147.196] ([69.90.147.196]:43938 "EHLO mail.kenati.com")
	by vger.kernel.org with ESMTP id S932164AbVLLTtN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 14:49:13 -0500
Message-ID: <439DD4F8.3040709@kenati.com>
Date: Mon, 12 Dec 2005 11:52:24 -0800
From: Carlos Munoz <carlos@kenati.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Can't build loadable module for 2.6.kernel
Content-Type: multipart/mixed;
 boundary="------------050200050601060007090403"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050200050601060007090403
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

I hope this is the right forum for this question.

I'm trying to build a loadable module for a telephony card that includes 
several files. Some of the files are source files (written by me) and 
some are object files (provided by the chip vendor). I'm unable to link 
the vendor object files with the target.

Make displays the following error:
make[4]: *** No rule to make target 
`drivers/telephony/mrvphone/apicnt.s', needed by 
`drivers/telephony/mrvphone/apicnt.o'.  Stop.

The makefile has the following rule to build apicnt.o:
apicnt.o: apicnt.o.shipped
    cp apicnt.o.shipped apicnt.o

I have also included the whole Makefile with this email.

Thanks in advance,


Carlos Munoz


--------------050200050601060007090403
Content-Type: text/plain;
 name="Makefile"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Makefile"

#
# Makefile for the phone_mrvl driver loadable module
#
TARGET = phone_mrvl.o

obj-$(CONFIG_PHONE_MARVELL) = phone_mrvl.o

ifeq ($(CONFIG_PHONE_LEGERITY),y)
phone_mrvl-objs = mrvphone.o slic.o legerity.o vp_hal.o sys_service.o apicnt.o apiinit.o apiquery.o vp_api.o vp_api_common.o mvutils.o
endif

ifeq ($(CONFIG_PHONE_PROSLIC),y)
phone_mrvl-objs = mrvphone.o proslic.o
endif

CFLAGS += -D__linux__
EXTRA_CFLAGS += -Idrivers/telephony/mrvphone
EXTRA_CFLAGS += -DNDEBUG -Dlinux -D__linux__ -Dunix -DEMBED -DLINUX -DHOST_LE

ifeq ($(CONFIG_PHONE_LEGERITY),y)
EXTRA_CFLAGS += -D__LEGERITY__
endif
ifeq ($(CONFIG_PHONE_PROSLIC),y)
EXTRA_CFLAGS += -D__PROSLIC__
endif

all: $(TARGET)

$(TARGET): $(OBJS)
	$(LD) -r $(OBJS) -o $(TARGET)

clean:
	-rm -f $(TARGET) *.elf *.gdb *.o

apicnt.o: apicnt.o.shipped
	cp apicnt.o.shipped apicnt.o

--------------050200050601060007090403--
