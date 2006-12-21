Return-Path: <linux-kernel-owner+w=401wt.eu-S1423146AbWLUX5Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423146AbWLUX5Q (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 18:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423153AbWLUX5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 18:57:16 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:40637 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423146AbWLUX5P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 18:57:15 -0500
Date: Fri, 22 Dec 2006 00:56:51 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Joe Perches <joe@perches.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: my handy-dandy, "coding style" script
In-Reply-To: <1166744416.14803.1.camel@localhost>
Message-ID: <Pine.LNX.4.61.0612220051050.3720@yvahk01.tjqt.qr>
References: <Pine.LNX.4.64.0612191044170.7588@localhost.localdomain> 
 <20061219164146.GI25461@redhat.com>  <b6c5339f0612190942l5a3ea48ft3315ab991ffd4f32@mail.gmail.com>
  <Pine.LNX.4.61.0612192125460.20733@yvahk01.tjqt.qr>  <4589BC6E.7040209@tmr.com>
  <Pine.LNX.4.61.0612212151450.3720@yvahk01.tjqt.qr>  <1166741599.27218.7.camel@localhost>
  <Pine.LNX.4.61.0612220019260.3720@yvahk01.tjqt.qr> <1166744416.14803.1.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 21 2006 15:40, Joe Perches wrote:
>On Fri, 2006-12-22 at 00:29 +0100, Jan Engelhardt wrote:
>> On Dec 21 2006 14:53, Joe Perches wrote:
>> >On Thu, 2006-12-21 at 21:52 +0100, Jan Engelhardt wrote:
>> >> http://lkml.org/lkml/2006/9/30/208
>> >@@ -1302,7 +1302,7 @@ static int acpi_battery_add(struct acpi_
>> > 		battery->init_state = 1;
>> > 	}
>> >-	(void)sprintf(dir_name, ACPI_BATTERY_DIR_NAME, id);
>> >+	sprintf(dir_name, ACPI_BATTERY_DIR_NAME, id);
>> >These casts can eliminate "return value unused" warnings.
>> 
>> But only when functions are tagged __must_check, and sprintf is not.
>
>or where -Wall is used.

00:50 takeshi:/dev/shm > cat bla.c
#include <stdio.h>
int main(void) {
    char foo[42];
    sprintf(foo, "bar");
    return 0;
}
00:52 takeshi:/dev/shm > cc bla.c -Wall
(no warnings)

In case you were talking about kernel code, the same (i.e. no warnings) 
happens:

00:54 takeshi:/dev/shm > make -C /lib/modules/2.6.18.5-jen40b-default/build M=$PWD
make: Entering directory `/usr/src/linux-2.6.18.5-jen40b-obj/i386/default'
make -C ../../../linux-2.6.18.5-jen40b O=../linux-2.6.18.5-jen40b-obj/i386/default
  CC [M]  /dev/shm/bla2.o
  Building modules, stage 2.
  MODPOST
  LD [M]  /dev/shm/bla2.ko
make: Leaving directory `/usr/src/linux-2.6.18.5-jen40b-obj/i386/default'
00:54 takeshi:/dev/shm > cat Makefile
EXTRA_CFLAGS += -Wall
obj-m += bla2.o




	-`J'
-- 
