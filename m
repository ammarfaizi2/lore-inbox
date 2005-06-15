Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261362AbVFOJ2q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261362AbVFOJ2q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 05:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbVFOJ2p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 05:28:45 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:57258 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261362AbVFOJ2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 05:28:43 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Helge Hafting <helge.hafting@aitel.hist.no>,
       Nico Schottelius <nico-kernel@schottelius.org>
Subject: Re: Why is one sync() not enough?
Date: Wed, 15 Jun 2005 12:28:27 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <20050614094141.GE1467@schottelius.org> <42AFE432.8000204@aitel.hist.no>
In-Reply-To: <42AFE432.8000204@aitel.hist.no>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506151228.27474.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 June 2005 11:17, Helge Hafting wrote:
> Nico Schottelius wrote:
> 
> >Hello again!
> >
> >When my system shuts down and init calls sync() and after that
> >umount and then reboot, the filesystem is left in an unclean state.
> >
> >If I do sync() two times (one before umount, one after umount) it
> >seems to work.

sync before umount is superfluous.

> >Can someboy explain that to me?
> >  
> >
> You shouldn't need those syncs, as umount does its own
> syncing.  There may be other explanations:
> 
> * Your reboot actually powers down (or resets) the disk.
>    IDE disks are known for caching stuff, they may indicate
>    that data is written slightly before it actually happens.
>    (The same applies to scsi - if you enable caching there for
>    the little extra performance it buys.)
>  
>    Rebooting really quickly after umount in such a case can cut
>    power to the disk before it finishes writing.  If this is the case,
>    then a few seconds of sleep after umount before reboot
>    will work just as well as that sync.  I don't recommend this
>    as a solution, but it is an easy diagnostic!
> 
> * Your startup script accidentally mounted the fs twice.
>   (Yes - linux support that, and the first umount won't undo
>    both mounts.)  This simply means the fs isn't umounted
>   when you reboot, but an extra sync and you might get lucky.

My reboot script is checking (/proc/mounts) for stray rw mounts on reboot,
prints a warning and waits for a keypress. This helps spot such things.
--
vda

