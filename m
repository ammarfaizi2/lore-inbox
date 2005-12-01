Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932375AbVLARz0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932375AbVLARz0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 12:55:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932376AbVLARzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 12:55:25 -0500
Received: from kirby.webscope.com ([204.141.84.57]:36007 "EHLO
	kirby.webscope.com") by vger.kernel.org with ESMTP id S932375AbVLARzZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 12:55:25 -0500
Message-ID: <438F38E6.7090303@m1k.net>
Date: Thu, 01 Dec 2005 12:54:46 -0500
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Perry Gilfillan <perrye@linuxmail.org>
CC: Linux and Kernel Video <video4linux-list@redhat.com>,
       Hartmut Hackmann <hartmut.hackmann@t.online.de>,
       Gene Heskett <gene.heskett@verizon.net>, Don Koch <aardvark@krl.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Gene's pcHDTV 3000 analog problem
References: <200511282205.jASM5YUI018061@p-chan.krl.com>	<c35b44d70511291548lcb10361ifd3a4ea0f239662d@mail.gmail.com>	<438CFFAD.7070803@m1k.net>	<200511300007.56004.gene.heskett@verizon.net>	<438D38B3.2050306@m1k.net>	<200511301553.jAUFrSQx026450@p-chan.krl.com>	<438E7107.3000407@linuxmail.org>	<438E8365.4020200@linuxmail.org> <438E84A4.8000601@m1k.net> <438E8A58.4010003@linuxmail.org> <438EBD43.3080400@linuxmail.org>
In-Reply-To: <438EBD43.3080400@linuxmail.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Perry Gilfillan wrote:

> I've been able to pinpoint the time when the v4l-dvb cvs failes for 
> the pcHDTV 3000 tuner!!
>
> This test is with gentoo-sources-2.6.13-r5, with v4l-dvb cvs.  As 
> Michael pointed out, 2.6.15 has bugs.  For my hardware, 2.6.13, and 14 
> have major issues as well...
>
> My procedure is to do a distclean in the v4l-dvb cvs directory, 
> checkout the repository for the given date, make, and install.  Then I 
> inspect the /lib/modules/.../media/video dirtree to be sure no old ko 
> files are lingering.  I do a cold boot to be sure the hardware is 
> fully initialized from a known state.  After many iterations, I've 
> narrowed it down to this change set:
>
> cvs as of 2005-10-17 16:01:
> Analog TV works, as well as composite and s-video.
>
> Changes made at 2005-10-17 16:02: bROKEN!!
>
> cvs as of 2005-10-17 16:10:
> Analog failes, s-video and composite work.
>
>
> I'll leave it to more capable persons to figure how it failed.

Hmm... These times of day don't coincide with any actual commits....

Anyhow, this was the day Hartmut added tda8275a support.  It broke many 
things, which we thought that we had eventually fixed.  Maybe there are 
still a few bugs as a result of this?

This is enough for me to put together a test patch for you, but I cant 
do it right now..... I'll try to email you an experimental patch tonight 
or tomorrow that will remove tda8275a support, just to confirm that this 
is in fact the problem.

If it turns out that I'm right, then we'll have to figure out a way to 
fix it, since reverting Hartmut's patch is NOT an option.

Thanks for the testing!

-Mike
