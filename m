Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265219AbUEMWqK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265219AbUEMWqK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 18:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265233AbUEMWqK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 18:46:10 -0400
Received: from mail8.fw-bc.sony.com ([160.33.98.75]:4068 "EHLO
	mail8.fw-bc.sony.com") by vger.kernel.org with ESMTP
	id S265219AbUEMWqB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 18:46:01 -0400
Message-ID: <40A3FAB4.7090401@am.sony.com>
Date: Thu, 13 May 2004 15:46:12 -0700
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Todd Poynor <tpoynor@mvista.com>, mochel@digitalimplant.org,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Hotplug events for system suspend/resume
References: <20040511010015.GA21831@dhcp193.mvista.com> <20040511230001.GA26569@kroah.com> <40A17251.2000500@mvista.com> <20040512150818.GE10924@kroah.com>
In-Reply-To: <20040512150818.GE10924@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

> On Tue, May 11, 2004 at 05:39:45PM -0700, Todd Poynor wrote:
> 
>>But again, I'll let the embedded system designers jump in here if they'd 
>>like to add some insight.  In both of the above cases, some ad-hoc 
>>method of kernel-to-userspace notification could be used, but I am 
>>trying to gauge interest in using hotplug as a generic notifier for these. 
> 
> Ok, I'm not going to accept this until some people who would actually
> use it step up and want to push for its inclusion.  None of this "patch
> by proxy" stuff...

Sony is one of MontaVista's customers that is keenly interested
in user-space notifiers for power management state changes.
We are interested in uniform handling of power-change events,
in user space, whether they are initiated by other user apps
or from kernel.

Here's one use case:
The system clock usually runs at 30MHz but it needs to run
at at 33MHz when I/O is performed on a particular compact flash
controller (but only when I/O is active).
Here are the state transitions:
         0. System Clock is running at 30MHz
	1. Compact Flash card is inserted
	2. CF controller is activated and detects CF I/O type
	3. kernel notifies that CF I/O is now activated, to
	user-space PM policy manager
	4. User-space PM policy manager changes the clock speed to 33 MHz

Here is another case, which is similar, but triggered by application
action:
         0. System Clock is running at 30MHz and the I/O mentioned above is
         turned off
	1. An application opens up I/O on the compact flash device
         2. device driver turns on the I/O, but cannot get operational
         state.
         3. kernel notifies that the CF I/O is now activated, to
	user-space PM policy manager
         4. user-space PM policy manager changes clock speed to 33MHz

Pardon the delay in responding, but these things take time to
translate, distill and pass on, in international organizations.
(And I'm still not sure I got the details right here, please bear
with me.)

Sony has experience with notifiers using /proc in a 2.4 kernel, so
I don't know if we can directly comment on the details of a hotplug-based
notification scheme.  But I can say that kernel-to-user notifications
is an important feature for us.

I hope this is helpful.

=============================
Tim Bird
Architecture Group Co-Chair
CE Linux Forum
Senior Staff Engineer
Sony Electronics
E-mail: Tim.Bird@am.sony.com
=============================

