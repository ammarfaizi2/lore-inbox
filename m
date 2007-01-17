Return-Path: <linux-kernel-owner+w=401wt.eu-S932671AbXAQTeg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932671AbXAQTeg (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 14:34:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932683AbXAQTeg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 14:34:36 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:40561 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932671AbXAQTee (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 14:34:34 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Kirill Korotaev <dev@sw.ru>
Cc: "<Andrew Morton" <akpm@osdl.org>, James.Bottomley@SteelEye.com,
       linux-mips@linux-mips.org, linux-parport@lists.infradead.org,
       minyard@acm.org, rtc-linux@googlegroups.com, clemens@ladisch.de,
       heiko.carstens@de.ibm.com, xfs@oss.sgi.com, linuxppc-dev@ozlabs.org,
       paulus@samba.org, openipmi-developer@lists.sourceforge.net,
       linux-390@vm.marist.edu, schwidefsky@de.ibm.com, tim@cyberelk.net,
       codalist@TELEMANN.coda.cs.cmu.edu, a.zummo@towertech.it,
       tony.luck@intel.com, vojtech@suse.cz, linux-scsi@vger.kernel.org,
       xfs-masters@oss.sgi.com, linux-ntfs-dev@lists.sourceforge.net,
       netdev@vger.kernel.org, aia21@cantab.net, aharkes@cs.cmu.edu,
       linux-kernel@vger.kernel.org, ralf@linux-mips.org,
       mark.fasheh@oracle.com, coda@cs.cmu.edu, lethal@linux-sh.org,
       kurt.hackel@oracle.com, containers@lists.osdl.org, linux390@de.ibm.com,
       philb@gnu.org, andrea@suse.de,
       linuxsh-shmedia-dev@lists.sourceforge.net, ak@suse.de
Subject: Re: [PATCH 50/59] sysctl: Move utsname sysctls to their own file
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
	<11689656853154-git-send-email-ebiederm@xmission.com>
	<45AE5FDC.5050603@sw.ru>
Date: Wed, 17 Jan 2007 12:31:22 -0700
In-Reply-To: <45AE5FDC.5050603@sw.ru> (Kirill Korotaev's message of "Wed, 17
	Jan 2007 20:41:48 +0300")
Message-ID: <m1ps9d8n79.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev <dev@sw.ru> writes:

> Eric, though I personally don't care much:
> 1. I ask for not setting your authorship/copyright on the code which you just
> copied
>   from other places. Just doesn't look polite IMHO.

I can't claim complete ownership of the code, there was plenty of feed back
and contributions from others but the final form without a big switch
statement is mine.  I certainly can't claim the table, it has been in
that form for years.

If you notice I actually didn't say whose copyright it was :)  just
that I wrote the file.

If there are copyright claims I should include I will be happy to do that.
Mostly I was just trying to find some stupid boiler plate that would work.

> 2. I would propose to not introduce utsname_sysctl.c.
>   both files are too small and minor that I can't see much reasons splitting
> them.

The impact of moving this code out of sysctl.c is a major
simplification, to sysctl.c.  Putting them in their own file means we
can cleanly restrict the code to only be compiled CONFIG_SYSCTL is set.

It is a necessary first step to implementing a per process /proc/sys.

It reorganizes the ipc and utsname sysctl from a terribly fragile
structure to something that is robust and easy to follow.  Code
scattered all throughout sysctl.c was just a disaster.  We had
several instances of having to fix bugs with odd combinations of
CONFIG options, simply because the other spot that needed to be touched
wasn't obvious.

So from my perspective this is an extremely worthwhile change that
will make maintenance easier and is a small first step towards
some nice future functionality.

Eric
