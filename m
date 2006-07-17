Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751190AbWGQUzv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbWGQUzv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 16:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbWGQUzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 16:55:51 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:53028 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751190AbWGQUzu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 16:55:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rGNHpPccmZeNKiI4zhC8YqYv3QfTQbeT9MkzqIXjBU4gA7C46g75wyStimX0L8KRjgvgc/tmvxrnrWroLFhnvohDmVa8TIslCqj5/379BYWajSezz97QTBovD4cc2Q/mT0AvkrA5RCyp2kSB6Xvly4DUog7HBTJeXdY8q19ap0E=
Message-ID: <29495f1d0607171355s1858f109xab02c7cc437f180c@mail.gmail.com>
Date: Mon, 17 Jul 2006 13:55:49 -0700
From: "Nish Aravamudan" <nish.aravamudan@gmail.com>
To: "Michael Krufky" <mkrufky@linuxtv.org>
Subject: Re: bttv-driver.c:3964: error: void value not ignored as it ought to be
Cc: "Linux and Kernel Video" <video4linux-list@redhat.com>,
       "Randy Dunlap" <rdunlap@xenotime.net>, "Andrew Morton" <akpm@osdl.org>,
       "Mauro Carvalho Chehab" <mchehab@infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "Axel Thimm" <Axel.Thimm@atrpms.net>
In-Reply-To: <44BBEAB0.3080105@linuxtv.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060717124505.GD7281@neu.nirvana> <44BBEAB0.3080105@linuxtv.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/06, Michael Krufky <mkrufky@linuxtv.org> wrote:
> Axel Thimm wrote:
> > latest hg fails on > 2.6.17 due to video_device_create_file being void
> > but still being asked for a return value in bttv-driver.c
> >
> > linux/drivers/media/video/bt8xx/bttv-driver.c:
> >
> >    3963 #if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,17)
> >    3964         ret = video_device_create_file(btv->video_dev, class_device_attr_card);
> >    3965         if (ret < 0)
> >
> >
> > linux/include/media/v4l2-dev.h:
> >
> >     379 static inline void
> >     380 video_device_create_file(struct video_device *vfd,
> >     381                          struct class_device_attribute *attr)
> >     382 {
> >

<snip>

> Hmmm... This was caused by the "Check all __must_check warnings in
> bttv." patch from Randy Dunlap (cc's from original thread added)
>
> I am aware that this was done for various reasons of sanity checking,
> however, we cannot check the return value of a void ;-)

For the sanity checking, I don't think video_device_create_file()
should be a void function. It probably should return
class_device_create_file()'s return value, no? As it can fail...

Thanks,
Nish
