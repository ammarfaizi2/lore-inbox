Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261900AbUEAAOk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261900AbUEAAOk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 20:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261891AbUEAAOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 20:14:40 -0400
Received: from mail.tpgi.com.au ([203.12.160.59]:11915 "EHLO mail3.tpgi.com.au")
	by vger.kernel.org with ESMTP id S261897AbUEAAOi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 20:14:38 -0400
Date: Sat, 01 May 2004 10:03:26 +1000
From: "Nigel Cunningham" <ncunningham@linuxmail.org>
To: "Todd Poynor" <tpoynor@mvista.com>,
       "Russell King" <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH] Hotplug for device power state changes
Cc: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
       "Patrick Mochel" <mochel@digitalimplant.org>,
       linux-hotplug-devel@lists.sourceforge.net,
       "Linux Kernel list" <linux-kernel@vger.kernel.org>
Reply-To: ncunningham@linuxmail.org
References: <20040429202654.GA9971@dhcp193.mvista.com> <20040429224243.L16407@flint.arm.linux.org.uk> <40918375.2090806@mvista.com> <1083286226.20473.159.camel@gaston> <20040430093012.A30928@flint.arm.linux.org.uk> <4092B02C.5090205@mvista.com>
Content-Type: text/plain; format=flowed; delsp=yes; charset=us-ascii
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <opr7anr02fshwjtr@laptop-linux.wpcb.org.au>
In-Reply-To: <4092B02C.5090205@mvista.com>
User-Agent: Opera M2/7.50 (Linux, build 663)
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Sorry for getting in on this conversion a little late; I've only just  
noticed it.

The usual way in which userspace notification of suspending/resuming is  
handled at the moment is via scripts which are run prior to suspending and  
after resuming. As has been noted, the first thing the kernel side  
implementations does is freeze userspace, keeping things static until post  
resume. This seems to me to be a good, simple model. DHCP releases can be  
handled from user space, prior to echo 4 > /proc/acpi/sleep (or  
alternatives) and the whole difficulty regarding interactions between  
userspace and kernelspace just goes away.

Note too that the actual invocation of a suspend can still be in response  
to kernel events. An ACPI event can be sent to the userspace ACPI daemon,  
which does userspace preparations and then invokes the kernel suspend  
mechanism. After resume, it can also do userspace reinitialisation.

Given this model, I would suggest that hotplug should silently drop any  
events that happen while suspending, and queue events that occur while  
resuming until the kernelspace part of resuming is complete and userspace  
can run as normal. It shouldn't rely upon device suspend/resume  
notifications because they can and do happen while we're still in the  
process of suspending and resuming. The means to detect whether we're  
suspending or resuming or running normally could be implemented as a  
simple function that could test the status of the different suspend  
implementations.

Is that at all helpful?

Regards,

Nigel

-- 
Nigel Cunningham
C/- Westminster Presbyterian Church Belconnen
61 Templeton Street, Cook, ACT 2614, Australia.
+61 (2) 6251 7727 (wk)

At just the right time, while we were still powerless, Christ
died for the ungodly. (Romans 5:6)
