Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261555AbTKBISF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 03:18:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbTKBISF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 03:18:05 -0500
Received: from [134.29.1.12] ([134.29.1.12]:17847 "EHLO mail.mnsu.edu")
	by vger.kernel.org with ESMTP id S261555AbTKBISB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 03:18:01 -0500
Message-ID: <3FA4BDAB.9080805@mnsu.edu>
Date: Sun, 02 Nov 2003 02:17:47 -0600
From: "Jeffrey E. Hundstad" <jeffrey.hundstad@mnsu.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030925
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Jeffrey E. Hundstad" <jeffrey@hundstad.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: /proc/[0-9]*/maps where did the (deleted) status go?
References: <3FA47EAF.3070802@hundstad.net>
In-Reply-To: <3FA47EAF.3070802@hundstad.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm going to fine tune this report a little bit.  The behavior change is 
more subtle than I at first thought.

In 2.4: file that has been deleted, and is mapped will show as deleted 
in the maps file
In 2.6: file that has been deleted, and is mapped will show as deleted 
in the maps file

In 2.4: file that has been moved, and is mapped will show as deleted in 
the maps file
In 2.6: file that has been moved, and is mapped will show the new name 
in the maps file

While I don't see this as a bug in the kernel it certainly is a 
regression difference.  ...and I'd still like a way of tracking when the 
filename changes.  If anyone has a good suggestion let me know.

As a side note... this is the output of a file that has actually been 
deleted.  It looks different from the 2.4 version (note the "\040" is 
something new):

40018000-40019000 rw-s 00000000 03:04 13355559 
/home/j3gum/src/mmap/testfile.old\040(deleted)


Jeffrey E. Hundstad

Jeffrey E. Hundstad wrote:

> Hello,
>
> In the 2.4.x kernels the /proc/[process id]/maps file contains that 
> processes current mappings.  This is also true with 2.6.0-test9 but 
> I've noticed a difference.  It is a feature I'll miss.  In the 2.4 
> kernels when a file is mapped but no longer exists (because it has 
> been removed) the mapping line would contain the text "(deleted)" 
> after it.
>
> I've used this feature after I've updated libraries on my system.  I 
> ran a little scriptlet (see below).  It'd tell me which processes were 
> running with the old copy of the library.  This way I restart those 
> processes.
>
> Is this a feature that can be restored, or perhaps there's a better 
> way to do it.  Let me know?
>
>
> ---- scriptlet library-restart-app follows:
> #!/bin/bash
> for i in `find /proc/ -mindepth 2 -maxdepth 2 -name "maps" | xargs 
> grep -a deleted | grep -a -E -v /SYSV[0-9a-z]{8} |grep -a -v /dev/zero 
> | cut -d ':' -f1 | cut -d '/' -f3 | sort | uniq | sed -e 
> 's/\(.*\)/\/proc\/\1\/cmdline/'`;do echo -n "`echo $i| cut -d '/' -f3` 
> ";cat $i|tr "\000" "\n" |head -1;done---- ---- scriptlet 
> library-restart-app ends
>
>

