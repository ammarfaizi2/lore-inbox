Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263191AbVCMFLv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263191AbVCMFLv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 00:11:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263197AbVCMFLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 00:11:50 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:14242 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S263191AbVCMFL3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 00:11:29 -0500
Date: Sat, 12 Mar 2005 21:10:59 -0800
From: Paul Jackson <pj@engr.sgi.com>
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [PATCH][RFC] Apply umask to /proc/<pid>
Message-Id: <20050312211059.6ad4e08b.pj@engr.sgi.com>
In-Reply-To: <20050312211255.GA4627@lsrfire.ath.cx>
References: <20050312211255.GA4627@lsrfire.ath.cx>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> patch below makes procfs apply the umask of the processes to their
> respective /proc/<pid> directories and the files below them.

Ugh ...

Since there are already various umask settings done by various
/etc/*profile* and /etc/*init* scripts that head up various logins and
task families, this means that the default visibility of tasks in ps and
top will change.  I predict confusion and frustration, when people don't
know why portions of ps or top output are suppressed.

And even when they figure it out, you don't give them anyway to get back
to the previous state - of visibility in ps, top and pstree, but file
creation permissions masked off in some way.

Nice small patch ... but I don't like overloading umask with this.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
