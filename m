Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263984AbUFSP1o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263984AbUFSP1o (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 11:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264002AbUFSP1o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 11:27:44 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:31906 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S263984AbUFSP1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 11:27:36 -0400
Subject: Re: [PATCH] Add kallsyms_lookup() result cache
From: Albert Cahalan <albert@users.sf.net>
To: Andrew Morton OSDL <akpm@osdl.org>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>, ak@suse.de,
       bcasavan@sgi.com
In-Reply-To: <20040619030637.5580b25e.akpm@osdl.org>
References: <1087605785.8188.834.camel@cube>
	 <20040619030637.5580b25e.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1087650315.8188.915.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 19 Jun 2004 09:05:16 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-06-19 at 06:06, Andrew Morton wrote:
> Albert Cahalan <albert@users.sourceforge.net> wrote:

>>> Doing the cache in the kernel is the wrong place.
>>> This should be fixed in user space.
>>
>>  No way, because:
>> 
>>  1. kernel modules may be loaded or unloaded at any time
>
> Poll /proc/modules?

Ugh. I like the sequence number suggestion better.
This is about speeding things up after all.

A signal that I could register to get would be best of all.

>>  2. the /proc/*/wchan files don't provide both name and address
>
> /proc/stat has the address, /proc/kallsyms gives the symbol?

Eh, why did we add the /proc/*/wchan files then if not
to use them?

One problem with parsing /proc/kallsyms is that I can't mmap
it and do a binary search. (the System.map was done this way)
It looks like I'd have to read half a megabyte of text, then
sort it for later use. It's highly desirable that the procps
tools not eat lots of memory or suffer high start-up costs.

>>  I'd be happy to make top (and the rest of procps) use a cache
>>  if those problems were addressed. I need a signal sent on
>>  module load/unload, or a real /proc/kallsyms st_mtime that I
>>  can poll. I also need to have the numeric wchan address in
>>  the /proc/*/wchan file, such that it is reliably the same
>>  thing as the function name already found there.
>
> Updating mtime on /proc/modules may be more logical, or even both.
>
> Or put a modprobe sequence number somewhere in /proc and
> look for changes in that.
>
> It definitely needs to be fixed, but it doesn't seem that
> adding code to the kernel is needed.

I'm not so sure anything needs to be fixed, save for SGI upgrading
to a more modern procps. There are many more important things:

Supply a real SUSv3-compliant %CPU
Supply whole-process CPU usage data
Add a /proc/*/tty symlink
Allocated PIDs by least-recently-used for safety
Add an "adopted child" flag (for processes reparented to init)
Supply the sleep time (in seconds for example)
Supply jobc, the "count of processes qualifying PGID for job control"
Supply the raw task_struct and the needed debug info



