Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933026AbWKWHra@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933026AbWKWHra (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 02:47:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933043AbWKWHra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 02:47:30 -0500
Received: from tomts22.bellnexxia.net ([209.226.175.184]:8642 "EHLO
	tomts22-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S933026AbWKWHr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 02:47:29 -0500
Date: Thu, 23 Nov 2006 02:47:27 -0500
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: Greg KH <greg@kroah.com>
Cc: ltt-dev@shafik.org, linux-kernel@vger.kernel.org
Subject: Re: Debugfs : inotify, multiple calls to debugfs_create_file, remove
Message-ID: <20061123074727.GA1703@Krystal>
References: <20061120181838.GB7328@Krystal> <20061122052730.GD20836@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20061122052730.GD20836@kroah.com>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 02:46:18 up 92 days,  4:54,  3 users,  load average: 0.44, 0.29, 0.17
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Sorry for the delay : I reworked my patches so they fully address the issues.
The patches follows.

Mathieu

* Greg KH (greg@kroah.com) wrote:
> On Mon, Nov 20, 2006 at 01:18:38PM -0500, Mathieu Desnoyers wrote:
> > Hi Greg,
> > 
> > I just had to add inotify support to my LTTng consumer so I could inform it
> > of the presence of new CPUs (for CPU hotplug). I noticed that no
> > notification event was being sent when a debugfs file is created from within
> > the kernel through debugfs_create. There are probably other notifications
> > missing, but here is the patch adding the one I care about. Should it be added
> > in libfs or in debugfs ?
> 
> So does this fix the inotify issue?
> 
> > A second problem I noticed is when a caller calls debugfs_create_file more than
> > once : the result is that the debugfs_remove will fail. I guess the second call
> > to debugfs_create_file increments the reference counts (there is not fix for
> > this issue in my patch).
> > 
> > Third problem : a failing call to debugfs_remove keeps the filesystem pinned.
> > (fixed by calling simple_release_fs in the error path).
> > 
> > The third problem : When a process is in a directory, the call to simple_rmdir
> > will fail. Debugfs does not use its return value. I noticed that calling
> > simple_unlink on a directory when simple_rmdir fails removes the directory that
> > would otherwise be left there. I am not sure if this approach is correct
> > through.
> > 
> > This patch is against Linux 2.6.18.
> 
> Care to split this into 4 different patches (you seem to have 4 issues
> here), so that it's easier to see them, and it will follow the
> 1-patch-per-issue rule?
> 
> thanks,
> 
> greg k-h
> 
OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
