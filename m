Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268861AbUIACJK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268861AbUIACJK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 22:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268868AbUIACJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 22:09:09 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:47840 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268776AbUIACGW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 22:06:22 -0400
Subject: Re: [patch] kernel sysfs events layer
From: Daniel Stekloff <dsteklof@us.ibm.com>
To: Robert Love <rml@ximian.com>
Cc: greg@kroah.com, akpm@osdl.org, kay.sievers@vrfy.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <1093988576.4815.43.camel@betsy.boston.ximian.com>
References: <1093988576.4815.43.camel@betsy.boston.ximian.com>
Content-Type: text/plain
Message-Id: <1094004324.1916.63.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 31 Aug 2004 19:05:24 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-31 at 14:42, Robert Love wrote:
> Here is the Kernel Events Layer rewritten as more of an asynchronous
> sysfs change notifier.  The concept of object and payload have been
> removed.  Instead, events are modeled as signals emitting from kobjects.
> It is pretty simple.
> 
> The interface is now:
> 
> 	int send_kevent(enum kevent type, struct kset *kset,
> 			struct kobject *kobj, const char *signal)
> 
> Say your processor (with kobject "kobj") is overheating.  You might do
> 
> 	send_kevent(KEVENT_POWER, NULL, kobj, "overheating");
> 
> We could get rid of signal and just require passing a specific attribute
> file in sysfs, which would presumably explain the reason for the event,
> but I think having a single signal value is acceptable.  The rest of the
> payload has been ditched.
> 
> The basic idea here is to represent to user-space events as changes to
> sysfs.  Media was changed?  Then that block device in sysfs emits a
> "media_change" event.
> 
> This patch includes two example events: file system mount and unmount.
> 
> Kay has some utilities and examples at
> 	http://vrfy.org/projects/kevents/
> and
> 	http://vrfy.org/projects/kdbusd/
> 
> The intention of this work is to hook the kernel into D-BUS, although
> the implementation is agnostic and should work with any user-space
> setup.
> 
> Best,
> 
> 	Robert Love


Hi Robert,

Are you limiting the kernel event mechanism a little too much by getting
rid of the payload? Wouldn't it be useful to sometimes have data at
event time? 

Thanks,

Dan

