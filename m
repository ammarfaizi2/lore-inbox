Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261480AbTC0XAr>; Thu, 27 Mar 2003 18:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261479AbTC0XAr>; Thu, 27 Mar 2003 18:00:47 -0500
Received: from [12.242.167.130] ([12.242.167.130]:17280 "EHLO
	waltsathlon.localhost.net") by vger.kernel.org with ESMTP
	id <S261482AbTC0XAp>; Thu, 27 Mar 2003 18:00:45 -0500
Message-ID: <3E83853A.6030900@comcast.net>
Date: Thu, 27 Mar 2003 15:11:54 -0800
From: Walt H <waltabbyh@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4a) Gecko/20030326
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Walt H <waltabbyh@comcast.net>
Cc: thunder7@xs4all.nl, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: vesafb problem
References: <3E8329D2.7040909@comcast.net> <20030327190222.GA4060@middle.of.nowhere> <3E837ADD.9080209@comcast.net>
In-Reply-To: <3E837ADD.9080209@comcast.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Walt H wrote:

> Well, I've answered my own question regarding highmem. Reserving 256MB 
> ram causes high-mem mapped IO to fail. I can have penguins, but no 
> filesystems or no penguins and a useable system. I'm guessing that I 
> could probably turn off HIGHMEM and HIGHMEM-IO and might be able to get 
> penguins back, but at the cost of reduced system performance. I'm not a 
> kernel hacker, but I might just see how bad I can break vesafb to remap 
> only the necessary memory for the requested video mode. Perhaps that 
> would fix the whole thing?
> 
> -Walt
> 

Well, here's what I've done. I've made a change in video/vesafb.c to 
change __init vesafb_init to only allocate the amount of memory required 
  for the requested framebuffer (I think). So far, it appears to work 
fine. I haven't tried many modes yet, but it's worked with what I've 
thrown at it. Thanks again,

The trivial change I made was changing this:

video_size	= screen_info.lfb_size * 65536;

to this:

video_size	= screen_info.lfb_width * screen_info.lfb_height * video_bpp;


-Walt

