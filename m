Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262342AbSJKELA>; Fri, 11 Oct 2002 00:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262351AbSJKELA>; Fri, 11 Oct 2002 00:11:00 -0400
Received: from marc2.theaimsgroup.com ([63.238.77.172]:5388 "EHLO
	marc2.theaimsgroup.com") by vger.kernel.org with ESMTP
	id <S262342AbSJKEK7>; Fri, 11 Oct 2002 00:10:59 -0400
Date: Fri, 11 Oct 2002 00:16:45 -0400
Message-Id: <200210110416.g9B4Gjs09451@marc2.theaimsgroup.com>
From: Hank Leininger <linux-kernel@progressive-comp.com>
Reply-To: Hank Leininger <hlein@progressive-comp.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O_STREAMING - flag for optimal streaming I/O
X-Shameless-Plug: Check out http://marc.theaimsgroup.com/
X-Warning: This mail posted via a web gateway at marc.theaimsgroup.com
X-Warning: Report any violation of list policy to abuse@progressive-comp.com
X-Posted-By: Hank Leininger <hlein@progressive-comp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-10-10, Mike Fedyk <mfedyk@matchmail.com> wrote: 
 
> On Thu, Oct 10, 2002 at 03:17:35PM +0200, Giuliano Pochini wrote: 
> > Thing again about to backup a large database. I don't 
> > want to use tar because it kills the caches. I would 
> > like a way to read the db so that the cached part of 
> > the db (the 20% which gets 80% of accesses) is not 
> > expunged. 
 
> Unless you are pausing the database (causing the files on disk to be in 
> a useful state) and then reading the file you will have trouble.  
> Anything else will have to syncronize with the database itself, and 
> thus can't use O_STREAMING. 
 
Pausing the database != putting the database into readonly mode, which is 
all that would really be required.  If your writer-processes are distinct 
from your reader-processes, you could suspend them (and/or batch up writes 
to temp tables to shrink your externally-felt maintenance window), tell 
the DB to flush pending writes, then dump with O_STREAMING-aware tar (or 
db-specific tools that still must pass through all tables/files) while 
read performance is only somewhat impacted, and cache isn't completely 
killed. 
 
Or, consider the case where the database isn't anywhere near all that the 
system does.  Think static content + DB-driven webserver, where the DB 
*can* be completely shut down (and those parts unavailable) during 
backups, while static content serving still goes on efficiently. 
 
-- 
Hank Leininger <hlein@progressive-comp.com>  
   
