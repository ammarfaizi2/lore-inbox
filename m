Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261567AbVETUTj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbVETUTj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 16:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261571AbVETUTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 16:19:38 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:49653 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261567AbVETUTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 16:19:22 -0400
Message-ID: <428E45EA.3040603@free.fr>
Date: Fri, 20 May 2005 22:17:46 +0200
From: Olivier Croquette <ocroquette@free.fr>
User-Agent: Mozilla Thunderbird 1.0.2 (Macintosh/20050317)
X-Accept-Language: fr-fr, en-us, en
MIME-Version: 1.0
To: Miquel van Smoorenburg <miquels@cistron.nl>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Thread and process dentifiers (CPU affinity, kill)
References: <428CD458.6010203@free.fr> <20050520125511.GC23488@csclub.uwaterloo.ca> <428DF95E.2070703@free.fr> <20050520165307.GG23488@csclub.uwaterloo.ca> <d6l9cs$l1t$1@news.cistron.nl>
In-Reply-To: <d6l9cs$l1t$1@news.cistron.nl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:e39ae1980843c849592344a98bbbf26f
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miquel van Smoorenburg wrote:

> No. On modern systems, glibc contains both LinuxThreads and NPTL.
> They have the same ABI. At runtime one of the two is selected,
> depending on if the currently running kernel supports NTPL.
> You can also force it by setting the LD_ASSUME_KERNEL environment
> variable to 2.4 or 2.6.

More info about that from:
http://linuxdevices.com/articles/AT6753699732.html

Some Linux vendors, such as later versions of Red Hat Linux, have 
backported NPTL to earlier kernels and have even made the threading 
environment for specific processes selectable through an environment 
variable (LD_ASSUME_KERNEL). On systems that support this feature, the 
variable is set via a command such as the following:
# export LD_ASSUME_KERNEL=2.4.1
This is a clever way to enable some existing applications that rely on 
LinuxThreads to continue to work in an NPTL environment, but is a 
short-term solution. To make the most of the design and performance 
benefits provided by NPTL, you should update the code for any existing 
applications that use threading.


[...]

Simply using a 2.6 based kernel does not mean that you are automatically 
using the NPTL. To determine the threading library that a system uses, 
you can execute the getconf command (part of the glibc package), to 
examine the GNU_LIBPTHREAD_VERSION environment variable, as in the 
following command example:
# getconf GNU_LIBPTHREAD_VERSION
linuxthreads-0.10
If your system uses the NPTL, the command would return the value of NPTL 
that your system was using, as in the following example:
# getconf GNU_LIBPTHREAD_VERSION
nptl-0.60

