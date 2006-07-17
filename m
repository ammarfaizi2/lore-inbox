Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751205AbWGQVbQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbWGQVbQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 17:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbWGQVbQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 17:31:16 -0400
Received: from kurby.webscope.com ([204.141.84.54]:41921 "EHLO
	kirby.webscope.com") by vger.kernel.org with ESMTP id S1751205AbWGQVbP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 17:31:15 -0400
Message-ID: <44BC015A.5090104@linuxtv.org>
Date: Mon, 17 Jul 2006 17:30:02 -0400
From: Michael Krufky <mkrufky@linuxtv.org>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: Linux and Kernel Video <video4linux-list@redhat.com>
CC: Michael Krufky <mkrufky@linuxtv.org>, Andrew Morton <akpm@osdl.org>,
       Axel Thimm <Axel.Thimm@atrpms.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>,
       Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: bttv-driver.c:3964: error: void value not ignored as it ought
 to be
References: <20060717124505.GD7281@neu.nirvana> <44BBEAB0.3080105@linuxtv.org> <29495f1d0607171355s1858f109xab02c7cc437f180c@mail.gmail.com>
In-Reply-To: <29495f1d0607171355s1858f109xab02c7cc437f180c@mail.gmail.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nish Aravamudan wrote:
> On 7/17/06, Michael Krufky <mkrufky@linuxtv.org> wrote:
>> Axel Thimm wrote:
>> > latest hg fails on > 2.6.17 due to video_device_create_file being void
>> > but still being asked for a return value in bttv-driver.c
>> >
>> > linux/drivers/media/video/bt8xx/bttv-driver.c:
>> >
>> >    3963 #if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,17)
>> >    3964         ret = video_device_create_file(btv->video_dev,
>> class_device_attr_card);
>> >    3965         if (ret < 0)
>> >
>> >
>> > linux/include/media/v4l2-dev.h:
>> >
>> >     379 static inline void
>> >     380 video_device_create_file(struct video_device *vfd,
>> >     381                          struct class_device_attribute *attr)
>> >     382 {
>> >
> 
> <snip>
> 
>> Hmmm... This was caused by the "Check all __must_check warnings in
>> bttv." patch from Randy Dunlap (cc's from original thread added)
>>
>> I am aware that this was done for various reasons of sanity checking,
>> however, we cannot check the return value of a void ;-)
> 
> For the sanity checking, I don't think video_device_create_file()
> should be a void function. It probably should return
> class_device_create_file()'s return value, no? As it can fail...
> 

You are correct... I was merely pointing out the error, but now I see it
runs deeper than I had thought.  I will fix both
video_device_create_file and video_device_remove_file to return the
class_device_foo return values, then I'll push it over to Mauro.

Cheers,

Michael Krufky

