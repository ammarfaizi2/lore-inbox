Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161247AbWF0SXs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161247AbWF0SXs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 14:23:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161250AbWF0SXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 14:23:48 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:5059 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161247AbWF0SXq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 14:23:46 -0400
Subject: Re: [RFC][PATCH 0/3] Process events biarch bug: Intro
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Matt Helsley <matthltc@us.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>
In-Reply-To: <1151408822.21787.1807.camel@stark>
References: <1151408822.21787.1807.camel@stark>
Content-Type: text/plain
Organization: IBM
Date: Tue, 27 Jun 2006 11:23:44 -0700
Message-Id: <1151432624.1412.3.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-27 at 04:47 -0700, Matt Helsley wrote:
> The events sent by Process Events from a 64-bit kernel are not binary compatible
> with what a 32-bit userspace program would expect to recieve because the timespec
> struct (used to send a timestamp) is not the same. This means that fields stored
> after the timestamp are offset and programs that don't take this into account
> break under these circumstances.
> 
> This is a problem for 32-bit userspace programs running with 64-bit kernels on
> ppc64, s390, x86-64.. any "biarch" system.
> 
> This series:
> 
> 1 - Gives a name to the union of the process events structure so it may be used
> 	to work around the problem from userspace.
> 2 - Comments on the bug and describes a userspace workaround in
> 	Documentation/connector/process_events.txt

Above two options need the user space program to workaround the issue,
while assuming that the size of the data structure will never change (if
it ever changes, you break compatibility), which IMO is not very
appealing.

> 3 - Implements a second connector interface without the problem
> 	(Removing the old interface or changing the definition would break
> 	 binary compatibility)

I think this is a better option if we want to fix the problem while
maintaining compatibility.

> 
> Compiled, booted, and lightly tested.
> 
> Comments or suggestions on alternate approaches would be appreciated.
> 
> Cheers,
> 	-Matt Helsley
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


