Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261342AbTKBDtG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Nov 2003 22:49:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261345AbTKBDtG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Nov 2003 22:49:06 -0500
Received: from [134.29.1.12] ([134.29.1.12]:11654 "EHLO mail.mnsu.edu")
	by vger.kernel.org with ESMTP id S261342AbTKBDtE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Nov 2003 22:49:04 -0500
Message-ID: <3FA47EAF.3070802@hundstad.net>
Date: Sat, 01 Nov 2003 21:49:03 -0600
From: "Jeffrey E. Hundstad" <jeffrey@hundstad.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030925
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: /proc/[0-9]*/maps where did the (deleted) status go?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

In the 2.4.x kernels the /proc/[process id]/maps file contains that 
processes current mappings.  This is also true with 2.6.0-test9 but I've 
noticed a difference.  It is a feature I'll miss.  In the 2.4 kernels 
when a file is mapped but no longer exists (because it has been removed) 
the mapping line would contain the text "(deleted)" after it.

I've used this feature after I've updated libraries on my system.  I ran 
a little scriptlet (see below).  It'd tell me which processes were 
running with the old copy of the library.  This way I restart those 
processes.

Is this a feature that can be restored, or perhaps there's a better way 
to do it.  Let me know?


---- scriptlet library-restart-app follows:
#!/bin/bash
for i in `find /proc/ -mindepth 2 -maxdepth 2 -name "maps" | xargs grep 
-a deleted | grep -a -E -v /SYSV[0-9a-z]{8} |grep -a -v /dev/zero | cut 
-d ':' -f1 | cut -d '/' -f3 | sort | uniq | sed -e 
's/\(.*\)/\/proc\/\1\/cmdline/'`;do echo -n "`echo $i| cut -d '/' -f3` 
";cat $i|tr "\000" "\n" |head -1;done---- ---- scriptlet 
library-restart-app ends


-- 
jeffrey hundstad


