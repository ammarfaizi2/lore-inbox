Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264015AbTDNWW7 (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 18:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264017AbTDNWW4 (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 18:22:56 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:31872 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S264015AbTDNWWt convert rfc822-to-8bit (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 18:22:49 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Stekloff <dsteklof@us.ibm.com>
To: Patrick Mochel <mochel@osdl.org>, "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: [patch] printk subsystems
Date: Mon, 14 Apr 2003 15:33:18 -0700
User-Agent: KMail/1.4.1
Cc: Martin Hicks <mort@wildopensource.com>, <hpa@zytor.com>, <pavel@ucw.cz>,
       <jes@wildopensource.com>, <linux-kernel@vger.kernel.org>,
       <wildos@sgi.com>
References: <Pine.LNX.4.44.0304141325010.14087-100000@cherise>
In-Reply-To: <Pine.LNX.4.44.0304141325010.14087-100000@cherise>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200304141533.18779.dsteklof@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 April 2003 11:33 am, Patrick Mochel wrote:
> > I don't like the #define DEBUG approach.  It's useless for users; it's a
> > developer debug tool.  It won't allow some support staff to ask users to
> > enable module debugging (or subsystem debugging) and see what gets
> > printed.
>
> Agreed. Having a runtime-tweakable field would be very handy, and
> something that's been requested many times over.
>
> > Martin, you are ahead of my schedule, but I was planning to use sysfs
> > to add a 'debug' flag/file that could be dynamically altered on a
> > per-module basis.
>
> Something I've pondered in the past is a per-subsystem (as in struct
> subsystem) debug field and log buffer. When the subsystem is registered, a
> sysfs 'debug' file is created, from which the user can set the noisiness
> level.


Would the debug level be for the entire subsystem? Do you think people would 
like to be able to set debug/logging level per driver or device, and not just 
subsystem? 

Is debugging level here the same as logging level? 

I like the idea of having logging levels, which include debug, defined by 
subsystem. Each subsystem will have separate requirements for logging. 
Networking, for instance, already has the NETIF_MSG* levels defined in 
netdevice.h that can be set with Ethtool. I can see, for example, having the 
msg_enable not in the private data as it is now but in the subsystem or class 
structure for that device, such as in struct net_device. This could easily be 
exported through sysfs. 

Thanks,

Dan


> From there, each subsystem can specify the size of a log buffer, which
> would be allocated also when the subsystem is registered. Messages from
> the subsystem, and kobjects belonging to it, would be copied into the
> local log buffer.
>
> Wrapper functions can be created, similar to the dev_* functions, which
> take a kobject as the first parameter. From this, the subsystem and log
> buffer, can be derived (or rather, passed to a lower-level helper).
>
> This all falls under the 'gee-whiz-this-might-be-neat' category, and may
> inherently suck; I haven't tried it. Doing the core code is < 1 day's
> work, though there would be nothing that actually used it..
>
>
> 	-pat

