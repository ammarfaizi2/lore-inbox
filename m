Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262609AbTDHXrD (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 19:47:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262600AbTDHXrD (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 19:47:03 -0400
Received: from fed1mtao08.cox.net ([68.6.19.123]:34000 "EHLO
	fed1mtao08.cox.net") by vger.kernel.org with ESMTP id S262658AbTDHXqz (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 19:46:55 -0400
Message-ID: <3E936225.9090409@cox.net>
Date: Tue, 08 Apr 2003 16:58:29 -0700
From: "Kevin P. Fleming" <kpfleming@cox.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4a) Gecko/20030401
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 64-bit kdev_t - just for playing
References: <20030408195305.F19288@almesberger.net> <Pine.LNX.4.44.0304081607060.5766-100000@dlang.diginsite.com> <20030408204721.H18709@almesberger.net>
In-Reply-To: <20030408204721.H18709@almesberger.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Werner Almesberger wrote:
> Agreed, this is the difficult part. This probably means that the
> kernel will have to come with a default initrd-like setup that is
> built and attached by "make bzImage" and the like. I thought that
> people were quite actively working towards something like this ?
> 

Yes, this is being worked on actively. This will use the 2.5.x initramfs 
infrastructure, and when it's up and going there will be early-userspace tools 
included in the kernel tarball to do the basic things that need doing 
(essentially responding to hotplug events and creating/removing devices nodes as 
needed).

> By completely removing such policy from the kernel, we return to
> the status quo ante: user-visible names only need to be agreed on
> during early system bringup. After that, the "device file
> manager" takes over, and that one can just use a local device
> name database.

Yes, this is true. Ideally, the early-userspace version and the normal-userspace 
version will be the same tool (possibly compiled differently, but otherwise 
identical). The early-userspace version should not have to create many nodes for 
a "normal" kernel boot, so most of the remaining ones can be created once the 
user's preferred naming policy can be located and used. Really, the 
early-userspace version only needs to create two nodes that I can think of to 
satisfy the "normal" kernel boot process: /dev/console and /dev/root. However, 
both of these need to be created with knowledge of parameters passed on the 
kernel command line (as the kernel does now), so that when the hotplug process 
sees the appropriate device "appear" it can create the proper device node.

