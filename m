Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268301AbUJDB52@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268301AbUJDB52 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 21:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268311AbUJDB52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 21:57:28 -0400
Received: from pimout7-ext.prodigy.net ([207.115.63.58]:62602 "EHLO
	pimout7-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S268301AbUJDB5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 21:57:24 -0400
Date: Sun, 3 Oct 2004 21:56:37 -0400 (EDT)
From: Vladimir Dergachev <volodya@mindspring.com>
X-X-Sender: volodya@node2.an-vo.com
Reply-To: Vladimir Dergachev <volodya@mindspring.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Jon Smirl <jonsmirl@gmail.com>, Dave Airlie <airlied@linux.ie>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Merging DRM and fbdev
In-Reply-To: <1096841964.16457.17.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0410032047040.18796@node2.an-vo.com>
References: <9e47339104100220553c57624a@mail.gmail.com> 
 <Pine.LNX.4.58.0410030824280.2325@skynet>  <9e4733910410030833e8a6683@mail.gmail.com>
  <Pine.LNX.4.61.0410031145560.17248@node2.an-vo.com>
 <1096841964.16457.17.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 3 Oct 2004, Alan Cox wrote:

> On Sul, 2004-10-03 at 16:50, Vladimir Dergachev wrote:
>> In particular, I can contribute the code that does Framebuffer->System Ram
>> transfers over PCI/AGP. It is currently GPL licensed, but there is no
>> problem if BSD folks want it too.
>
> This will do *wonders* to X render performance if used properly on those
> cards we can't do render in hardware.
>
>> This is also potentially useful for any Mesa functions that want to
>> transfer data back from video RAM - using plain reads for this is really slow.
>
> Agreed - and Mesa tends to skip even tricks like SSE2 that can quadruple
> read performance.

I am glad to see such enthusiasm :)

The code I have only does it on ATI cards (all radeons, all rage128, some 
mach64). The radeon code is the one that is known to work well.

My personal interest is that Framebuffer -> System Ram transfer is needed
if one wants to use Radeon GPUs for numerical computation. Thus, if there 
is an agreement on what needs to be done and what modifications are 
acceptable I can make this a priority.

What kind of interface would different projects want ? Should I wait for 
Jon's modifications to complete ? What people should we include on CC list ?

Also here is a short description of current km design:

     * km.[c,h] - this provides module registration and DMA queue
       virtualization (note: this is GUI_DMA queue, different from what
       DRM uses)

     * radeon.c, rage128.c, mach64.c - these are hardware specific
       functions

     * km_memory.[c,h] - this is v4l code for reverse mapping, I guess
       it is obsolete in 2.6.x kernels

     * km_api.[c,h] km_api_data.[c,h] - this is a new interface for
       video (and similar devices), an experiment to implement features
       not present in v4l or v4l2.
       ** I am not suggesting this be included. **

     * km_v4l.c - this is a client of km_api that provides v4l
       interface.

The first two pieces can be ported with ease - there are few modifications 
to be made, just cut the code that registers the driver.

The km_api piece will need to be replaced with interface everyone agrees 
on.

Please let me know your comments !

                         best

                            Vladimir Dergachev



>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
> Use IT products in your business? Tell us what you think of them. Give us
> Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
> http://productguide.itmanagersjournal.com/guidepromo.tmpl
> --
> _______________________________________________
> Dri-devel mailing list
> Dri-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/dri-devel
>
