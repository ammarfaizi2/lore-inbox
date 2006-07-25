Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751402AbWGYH5W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402AbWGYH5W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 03:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbWGYH5V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 03:57:21 -0400
Received: from nz-out-0102.google.com ([64.233.162.203]:37147 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751402AbWGYH5V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 03:57:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=s7z1W+Bh45EM6hQqrFsgfrtYGDQyIsI1kho/LPwoiLllLDRgAgf+d11/QbuuJQlzFGCjj7+nliSw93ZzP3wVQK025Wp96jp8rvDQk9gqniuAbbHKacHWmzlfyKYNHB0fl5LTjde56eXwUoEL/zUjzjnKzXi8XkDoG50ZsbslySI=
Message-ID: <44C5CED7.4000801@gmail.com>
Date: Tue, 25 Jul 2006 11:57:11 +0400
From: Manu Abraham <abraham.manu@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Mauro Carvalho Chehab <mchehab@infradead.org>, robfitz@273k.net,
       video4linux-list@redhat.com, 76306.1226@compuserve.com,
       fork0@t-online.de, greg@kroah.com, linux-kernel@vger.kernel.org,
       rdunlap@xenotime.net, v4l-dvb-maintainer@linuxtv.org,
       shemminger@osdl.org
Subject: Re: [v4l-dvb-maintainer] Re: [PATCH] V4L: struct video_device corruption
References: <200607130047_MC3-1-C4D3-43D6@compuserve.com>	<20060713050541.GA31257@kroah.com>	<20060712222407.d737129c.rdunlap@xenotime.net>	<20060712224453.5faeea4a.akpm@osdl.org>	<20060715230849.GA3385@localhost> <1153013464.4755.35.camel@praia> <20060724200855.603be3bb.akpm@osdl.org>
In-Reply-To: <20060724200855.603be3bb.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Sat, 15 Jul 2006 22:31:04 -0300
> Mauro Carvalho Chehab <mchehab@infradead.org> wrote:
> 
>> Em Sáb, 2006-07-15 às 23:08 +0000, Robert Fitzsimons escreveu:
>>> The layout of struct video_device would change depending on whether
>>> videodev.h (V4L1) was include or not before v4l2-dev.h, which caused
>>> the structure to get corrupted.  
>> Hmm... good point! However, I the proper solution would be to trust on
>> CONFIG_VIDEO_V4L1_COMPAT or CONFIG_VIDEO_V4L1 instead. it makes no sense
>> to keep a pointer to an unsupported callback, when V4L1 is not selected.
>>
> 
> So I've lost the plot with all of this.  Does the current git-dvb contain
> the desired fixes?
> 
> Do we expect this will fix the various DVB crashes which people (including
> Alex) have reported?

I believe you are referring to the "oops in bttv" thread.

As i understood, the case that Alex reported in was a null pointer issue 
due to which modprobe bttv crashes, rather than a DVB issue.

Call Trace:
  [<c018763c>] sysfs_create_file+0x26/0x28
  [<c0220cc3>] class_device_create_file+0x14/0x1a
  [<f9bc3073>] bttv_register_video+0x8c/0x147 [bttv]
  [<f9bc35de>] bttv_probe+0x4ab/0x593 [bttv]


Therefore the V4L fixes should probably fix the same as well.


Regards,
Manu
