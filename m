Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751062AbWCADp3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062AbWCADp3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 22:45:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751066AbWCADp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 22:45:29 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:36739 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751017AbWCADp2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 22:45:28 -0500
Date: Tue, 28 Feb 2006 19:45:25 -0800
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: ebiederm@xmission.com, linux-kernel@vger.kernel.org
Subject: Re: + proc-dont-lock-task_structs-indefinitely-cpuset-fix-2.patch
 added to -mm tree
Message-Id: <20060228194525.0faebaaa.pj@sgi.com>
In-Reply-To: <20060228183610.5253feb9.akpm@osdl.org>
References: <200603010120.k211KqVP009559@shell0.pdx.osdl.net>
	<20060228181849.faaf234e.pj@sgi.com>
	<20060228183610.5253feb9.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -rc5-mm1 appears to be a trainwreck.  It's a bit of a mystery - I've tried
> several further configs and it all works swimmingly.

Getting closer.

Without the patches:

    proc-dont-lock-task_structs-indefinitely.patch
    proc-dont-lock-task_structs-indefinitely-git-nfs-fix.patch
    proc-dont-lock-task_structs-indefinitely-cpuset-fix.patch

it boots and works (except for the /proc/*/fd/* permission
complaints I made earlier to Eric).  And I was able to run my SGI
specific application that generates the 50 such permission complaints.

With these patches, it still boots, and looks fine ... until
I fire up my SGI specific application, and then it dies.
Once it died with some complaint (lost now) from a swap
daemon.  This latest time, it died with just:

  Kernel panic - not syncing: Attempted to kill init!

So I think the above 3 patches make it easy for user space
to kill the kernel.

The SGI app is some rather largish tool used for system
monitoring and maintenance - I will have to stare at it
to reduce out any useful explanation of what it is doing
that is so painful here.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
