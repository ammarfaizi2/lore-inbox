Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265197AbUELThg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265197AbUELThg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 15:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265203AbUELThQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 15:37:16 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:58106 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S265193AbUELTg3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 15:36:29 -0400
Message-ID: <40A27CB8.1010507@mvista.com>
Date: Wed, 12 May 2004 12:36:24 -0700
From: Todd Poynor <tpoynor@mvista.com>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ncunningham@linuxmail.org
CC: Greg KH <greg@kroah.com>, mochel@digitalimplant.org,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Hotplug events for system suspend/resume
References: <20040511010015.GA21831@dhcp193.mvista.com> <200405121216.02787.ncunningham@linuxmail.org> <40A18F94.4000607@mvista.com> <200405121359.50899.ncunningham@linuxmail.org>
In-Reply-To: <200405121359.50899.ncunningham@linuxmail.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham wrote:

> You're thinking ACPI drivers initiating a suspend? They would do it through 
> acpid, wouldn't they? At least that's the glue I use to get my sleep button 
> to initiate a suspend. I would assume thermal events would/should work the 
> same.

Hi, my main interest is embedded platforms that may or (usually) do not 
implement ACPI.  Therefore, part of what I've been generally driving at 
is that there may be value to adding support for these sorts of 
kernel-to-userspace notifiers in the generic power layer.  As I 
understand it (and I might be behind the times here, please do correct 
me if I'm wrong), acpid reads ACPI-specific power event notifiers, such 
as button pressed, thermal limit exceeded, etc. from the kernel via 
/proc, and acpid executes scripts in /etc/acpi/ to handle the event. 
Some of the embedded developers I deal with have asked for similar 
notifiers in a non-ACPI context.  The system suspend/resume notifiers 
discussed in this thread could be thought of as a general form of "sleep 
button pressed" type event.  (And I now realize it may have been better 
to implement and pitch it as such.)

So, independently of the merits of any particular event notification, it 
may be worth discussing whether there's advantages to using the hotplug 
mechanism for userspace notification and script execution for power 
events, and hooked into the generic power subsystem.  The likely 
alternative is that acpid continues doing things its way and non-ACPI 
systems do something rather different (we already have acpid-like event 
notifiers via sysfs attributes and I'm trying to get rid of them).  Not 
that this ranks among the most pressing of issues facing Linux today, 
but since a generic power subsystem has been created, and since it takes 
some steps toward abstracting away various ACPI specifics, I think 
there's arguably some benefit to taking this particular step as well. 
An acpid-like interface (or even directly adapting acpid) for non-ACPI 
systems is another possibility.

I'd be happy to discuss this further if there's interest.  Thanks -- Todd
