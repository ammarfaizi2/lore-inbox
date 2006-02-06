Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964776AbWBFU0O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964776AbWBFU0O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 15:26:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964777AbWBFU0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 15:26:14 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:12572 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964774AbWBFU0M convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 15:26:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AcCd3oEgMs+yPcu8RHuYa0UZmeSQ9Yu06ul4iE45iUCKSrxVzExXn7XVVoG9pi/o+nzb1HgRXBAKvqoV+D/uSXtS7RdF55Q0bNPS0Mjak6xtKEq6B3SUihRuAF4so5zCqfEuNRyqvvzoIS6Pzgr9nITFZkKJ5x7wa8UE0CatdaI=
Message-ID: <12c511ca0602061226pf3bf095jcc570754656c5437@mail.gmail.com>
Date: Mon, 6 Feb 2006 12:26:11 -0800
From: Tony Luck <tony.luck@intel.com>
To: Ulrich Drepper <drepper@redhat.com>
Subject: Re: [PATCH 1/3] NEW VERSION: *at syscalls: Implementation
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org,
       kenneth.w.chen@intel.com
In-Reply-To: <200512171742.jBHHgAKh018491@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200512171742.jBHHgAKh018491@devserv.devel.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does sys_mkdirat() work?  I applied Ken's patch to hook up the calls for
ia64, but when I tried:

long sys_mkdirat(int dfd, const char *pathname, int mode)
{
        return syscall(__NR_mknodat, dfd, pathname, mode);
}

...

   sys_mkdirat(AT_FDCWD, "xxx", 0777);

I ended up with a regular file named "xxx", not a directory.
$ ls -l xxx
-rwsrwxr-x  1 aegl aegl 0 Feb  6 12:23 xxx

Hmmm, setuid too!

-Tony
