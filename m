Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264051AbTDOTky (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 15:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264053AbTDOTkx 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 15:40:53 -0400
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:8839 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP id S264051AbTDOTkv 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 15:40:51 -0400
Date: Tue, 15 Apr 2003 12:19:51 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC] /sbin/hotplug multiplexor - take 2
To: Greg KH <greg@kroah.com>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Message-id: <3E9C5B57.4020106@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <20030414190032.GA4459@kroah.com> <20030414224607.GC6411@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> Ok, based on the comments so far, how about this proposed version of
> /sbin/hotplug to provide a multiplexor?

It'd be a reduction in functionality.  I could no longer just
type "/sbin/hotplug" to see what agents disabled or missing ...
or notice that since hotplugging was on, the problem had to be
RH9 storing /bin/true into /proc/sys/kernel/hotplug again!  :P

If the idea is just to loosen today's "one agent per event"
rule (I've had that idea too), then wouldn't it be simpler to
just (a1) pay an extra process context, not using "exec" to run
/etc/hotplug/$1.agent, and when it returns (a2) THEN try other
programs?  Or even (b) just modify appropriate agent scripts
to do so, instead of /sbin/hotplug?

I'd think better about this problem if I had a handful of
examples showing why category-specific or event-specific
dispatch wouldn't be preferable.

- Dave



> ----------
> #!/bin/sh
> DIR="/etc/hotplug.d"
> 
> for I in "${DIR}/$1/"* "${DIR}/"all/* ; do
> 	test -x $I && $I $1 ;
> done
> 
> exit 1
> ----------


