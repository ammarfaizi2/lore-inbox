Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbTEUQrz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 12:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262196AbTEUQrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 12:47:55 -0400
Received: from 12-225-92-115.client.attbi.com ([12.225.92.115]:50048 "EHLO
	p3.coop.hom") by vger.kernel.org with ESMTP id S262153AbTEUQry
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 12:47:54 -0400
Date: Wed, 21 May 2003 10:00:45 -0700
From: Jerry Cooperstein <coop@axian.com>
To: David Balazic <david.balazic@uni-mb.si>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Wrong clock initialization
Message-ID: <20030521170045.GA2130@p3.attbi.com>
References: <3ECA673F.7B3FB388@uni-mb.si>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ECA673F.7B3FB388@uni-mb.si>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is not directly a kernel problem.  I developed this after
a glibc upgrade.  The problem is most distros (such as redhat)
make a symbolic link

   /etc/localtime -> /usr/share/zoneinfo/America/Los_Angeles

or whatever your timezone is.  On some of my systems, /usr/share is on
a disk partition that is not mounted at the time the link is needed
during initialization; the system then defaults to UTC.  As a result,
each time you boot up your system loses a time equal to the difference
between UTC and your local time zone.

To fix this, just make sure /etc/localtime is actually a file on the
root filesystem, not a link to a possibly unmounted filesystem.
Just copy the one pointed to by the link.

I have systems with the same partition/mount layout which have no
problem, so I don't know why some systems get confused.  So far I
have only seen this on laptops.

======================================================================
 Jerry Cooperstein,  Senior Consultant,  <coop@axian.com>
 Axian, Inc., Software Consulting and Training
 4800 SW Griffith Dr., Ste. 202,  Beaverton, OR  97005 USA
 http://www.axian.com/               
======================================================================



On Tue, May 20, 2003 at 07:34:55PM +0200, David Balazic wrote:
> Hi!
> 
> When the kernel is booted ( ia32 version at least ) , it reads
> the time from from the hardware CMOS clock , _assumes_ it is in
> UTC and set the system time to it.
> 
> As almost nobody runs their clock in UTC, this means that the system
> is running on wrong time until some userspace tool corrects it.
> 
> This can lead to situtation when time goes backwards :
> 
> timezone is 2hours east of UTC.
> UTC time : 20:00
> local time : 22:00
> 
> System time between boot and userspace fix : 22:00UTC
> System time after fix : 20:00UTC
> 
> Comments ?
> 
> 
> -- 
> David Balazic
> --------------
> "Be excellent to each other." - Bill S. Preston, Esq., & "Ted" Theodore
> Logan
> - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
> - - -
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
