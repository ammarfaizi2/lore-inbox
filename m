Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265086AbUELAlr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265086AbUELAlr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 20:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265080AbUELAlq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 20:41:46 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:21756 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S265086AbUELAjw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 20:39:52 -0400
Message-ID: <40A17251.2000500@mvista.com>
Date: Tue, 11 May 2004 17:39:45 -0700
From: Todd Poynor <tpoynor@mvista.com>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: mochel@digitalimplant.org, linux-hotplug-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: Hotplug events for system suspend/resume
References: <20040511010015.GA21831@dhcp193.mvista.com> <20040511230001.GA26569@kroah.com>
In-Reply-To: <20040511230001.GA26569@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

> I still do not see the need for this.  As a user, you caused the
> suspend/resume event to happen, why get notified of it again?  :)

The idea is to notify the "power management application" of impending 
suspend and just-completed resume, regardless of who or what asked for 
the suspend.  Actions taken at suspend might include dropping network 
connections and saving application state to stable storage.

The reasons for which this was requested of me as a kernel-to-userspace 
notifier, that I am aware of, are:

(a) some embedded platforms currently trigger suspend within kernel 
drivers (in response to a button press or some sort of device timeout).

(b) the system designer wants to make sure certain actions are always 
taken regardless of the interface used to suspend (not only in the case 
of a certain application that incorporates these actions and triggers 
the suspend via the standard interfaces at the appropriate time).  For 
example, a user manually enters a command from a shell prompt.

But again, I'll let the embedded system designers jump in here if they'd 
like to add some insight.  In both of the above cases, some ad-hoc 
method of kernel-to-userspace notification could be used, but I am 
trying to gauge interest in using hotplug as a generic notifier for these.

Thanks -- Todd
