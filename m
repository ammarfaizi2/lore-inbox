Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbTDKRvt (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 13:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbTDKRvt (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 13:51:49 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:43535 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id S261328AbTDKRvs (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 13:51:48 -0400
Date: Fri, 11 Apr 2003 20:02:41 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org, <linux-hotplug-devel@lists.sourceforge.net>,
       <message-bus-list@redhat.com>, Daniel Stekloff <dsteklof@us.ibm.com>
Subject: Re: [ANNOUNCE] udev 0.1 release
In-Reply-To: <20030411032424.GA3688@kroah.com>
Message-ID: <Pine.LNX.4.44.0304111939310.12110-100000@serv>
References: <20030411032424.GA3688@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 10 Apr 2003, Greg KH wrote:

> I'd like to finally announce the previously vapor-ware udev program that
> I've talked a lot about with a lot of people over the past months.  The
> first, very rough cut is at:
> 	kernel.org/pub/linux/utils/kernel/hotplug/udev-0.1.tar.gz

Is there a special reason why you call mknod?
Otherwise you could simply do:

	syscall(SYS_mknod, name, S_IFBLK | mode, dev); 

This way you don't have to care about major/minor/glibc issues.

> Yes, I know there's still a lot of work to do (serialization, symlinks,
> hooking hotplug so that others can also use it, etc.) but it's a first
> step :)

To help serialization and perfomance issues, it might help to add a daemon 
mode to hotplug. The kernel calls hotplug with a pipe from which it reads 
the event data, after a certain timeout it can close the pipe and exit.

bye, Roman

