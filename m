Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264955AbUELCot@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264955AbUELCot (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 22:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264952AbUELCot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 22:44:49 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:55288 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S264955AbUELCoq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 22:44:46 -0400
Message-ID: <40A18F94.4000607@mvista.com>
Date: Tue, 11 May 2004 19:44:36 -0700
From: Todd Poynor <tpoynor@mvista.com>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ncunningham@linuxmail.org
CC: Greg KH <greg@kroah.com>, mochel@digitalimplant.org,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Hotplug events for system suspend/resume
References: <20040511010015.GA21831@dhcp193.mvista.com> <20040511230001.GA26569@kroah.com> <40A17251.2000500@mvista.com> <200405121216.02787.ncunningham@linuxmail.org>
In-Reply-To: <200405121216.02787.ncunningham@linuxmail.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham wrote:

> Unless I'm missing something, this will break all existing implementations of 
> S3 and S4 because they all freeze userspace processes prior to suspending 
> drivers. They do this because they assume it is the responsibility of 
> userspace to handle these actions prior to telling the kernel to suspend.

The patch hooks into the power subsystem prior to freezing processes and 
after unfreezing processes, so I don't think it's a concern (unless 
something is using the power subsystem rather oddly).  This patch sends 
a single notification of system suspend and a single notification of 
system resume, in case there's any confusion with the individual device 
state change notifiers also recently discussed.  It's been run 
successfully on one ACPI system and one non-ACPI system.

> In my mind, this approach is simpler and makes more sense: userspace should 
> worry about userspace actions related to suspending before calling 
> kernelspace. Kernel space should then only worry about saving and restoring 
> driver states and should be transparent to user space. ...

Agreed, with the minor reservations listed in a previous email (suspend 
initiated by drivers must coordinate ad-hoc with userspace, etc.).

I'll let anybody who cares more deeply about this speak up now, 
otherwise this isn't a battle I'll be fighting on behalf of others any 
more.  Thanks -- Todd

