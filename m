Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263667AbTJ0XJd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 18:09:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263675AbTJ0XJc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 18:09:32 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:12022 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S263667AbTJ0XJa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 18:09:30 -0500
Message-ID: <3F9DA5A6.3020008@mvista.com>
Date: Mon, 27 Oct 2003 16:09:26 -0700
From: Mark Bellon <mbellon@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Patrick Mochel <mochel@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net
Subject: Re: ANNOUNCE: User-space System Device Enumeration (uSDE)
References: <Pine.LNX.4.44.0310271343170.13116-100000@cherise>
In-Reply-To: <Pine.LNX.4.44.0310271343170.13116-100000@cherise>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>How does uSDE relate to udev? You do not mention it in your email, though it claims to implement similar, if not identical functionality. Is it related? Is it built on top of it?
>
The uSDE is not built on top of udev.

The uSDE and udev are similar in some respects. They both create device 
nodes. There is a lot more to handling devices than managing device nodes.

Some differences between uSDE and udev that come to mind as I type (a 
good deal of this is part of the INTRO in the uSDE tarball):

Devices are classified and an explicit, ordered list of policies are 
invoked on behalf of the devices based on that classification.

Policies are implemented as open plug-ins that have complete control 
(e.g. naming, configuration, special needs) over a device.

Multiple policies can be executed concurrently; they can be independent 
or cooperative.

All device types are embraced - ethernet, disks, cdroms, floppies, MD, 
LVM and so on. Policies can analyze data and handle complex situations 
such as ethernet interface anchoring, multiported disk handling and 
automatic multipath device management.

The concept of service agents who provide critical information to the 
enumeration framework allowing policies to handle extremely diverse 
hardware situations such as multiple chassis and geographical addressing.

The uSDE sample policies implement basic device replacement and 
relocation strategies, something that the community has been asking 
about for some time.

If you want to learn more about that differences, download the tarball 
and try it out...

The uSDE was built in response to a set of telco and embedded community 
requirements. We found it difficult to express our ideas. Everyone 
wanted to see code and documentation. Here is the code and the initial 
documentation. This is a starting point...

>If not, are you planning on merging your efforts with udev in the future?
>
It is to everyone's advantage to converge on an implementation of 
enumeration that meets all of the requirements.

>Are you using the libsysfs library for accessing sysfs data? If not, I 
>highly recommend it.
>
The uSDE is not currently using the libsysfs library. The project will 
look into this in the near future.

Patches gladly accepted. :)

>I would also recommend sending email to the linux-hotplug list, as most of 
>the hotplug-related applications are discussed and developed via that 
>list.
>
>
>	Pat
>
Thanks, I'll copy them.

mark


