Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275022AbTHRUuw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 16:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275050AbTHRUuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 16:50:51 -0400
Received: from marc2.theaimsgroup.com ([63.238.77.172]:25351 "EHLO
	mailer.progressive-comp.com") by vger.kernel.org with ESMTP
	id S275022AbTHRUuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 16:50:50 -0400
Date: Mon, 18 Aug 2003 16:50:49 -0400
Message-Id: <200308182050.h7IKonga016378@marc2.theaimsgroup.com>
From: Hank Leininger <linux-kernel@progressive-comp.com>
Reply-To: Hank Leininger <hlein@progressive-comp.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Dumb question: Why are exceptions such as SIGSEGV not logged
X-Shameless-Plug: Check out http://marc.theaimsgroup.com/
X-Warning: This mail posted via a web gateway at marc.theaimsgroup.com
X-Warning: Report any violation of list policy to abuse@progressive-comp.com
X-Posted-By: Hank Leininger <hlein@progressive-comp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2003-08-18, Michael Frank <mhf () linuxmail ! org> wrote:

> I tend to see segfaults only when something is broken or when my lapse
> of attention perhaps should be rewarded by said "sucker rod".

As others have said some apps use "interesting" signals normally.  For
instance probably the most common is vmware.  vmware sends itself SIGSEGV
all the time (at startup, at least) as part of its memory-management foo:

Aug 12 14:11:23 foo kernel: grsec: signal 11 sent to (vmware-ui:12180) \
	UID(XXXX) EUID(XXXX), parent (vmware:17653) UID(XXXX) EUID(XXXX)
Aug 12 14:11:23 foo kernel: grsec: signal 11 sent to (vmware-mks:25238) \
	UID(XXXX) EUID(XXXX), parent (vmware:17653) UID(XXXX) EUID(XXXX)
Aug 12 14:11:23 foo kernel: grsec: signal 11 sent to (vmware:17653) \
	UID(XXXX) EUID(XXXX), parent (bash:2883) UID(XXXX) EUID(XXXX)

..So not *all* such cases are cause for alarm.  However, if you run one of
the patches enabling logging of this, you quickly learn what's normal for
the apps you run, and can teach your log-auditing tools and/or your brain
to ignore them.

--
Hank Leininger <hlein@progressive-comp.com> 
  
