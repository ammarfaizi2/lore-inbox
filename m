Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263212AbTDGDSA (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 23:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263215AbTDGDSA (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 23:18:00 -0400
Received: from [12.47.58.55] ([12.47.58.55]:41689 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S263212AbTDGDR7 (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 23:17:59 -0400
Date: Sun, 6 Apr 2003 20:29:26 -0700
From: Andrew Morton <akpm@digeo.com>
To: Robert Love <rml@tech9.net>
Cc: rpjday@mindspring.com, linux-kernel@vger.kernel.org
Subject: Re: 2.5.66-bk12 causes "rpm" errors
Message-Id: <20030406202926.762754ea.akpm@digeo.com>
In-Reply-To: <1049685316.894.5.camel@localhost>
References: <20030406183234.1e8abd7f.akpm@digeo.com>
	<Pine.LNX.4.44.0304062200570.1604-100000@localhost.localdomain>
	<20030406182815.65dd9304.akpm@digeo.com>
	<1049685316.894.5.camel@localhost>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Apr 2003 03:29:27.0070 (UTC) FILETIME=[E461F3E0:01C2FCB5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love <rml@tech9.net> wrote:
>
> 
> Backing out this patch (from a kernel roughly similar to 2.5.66-mm3)
> does not resolve the problem:
> 
>         [23:08:36]root@phantasy:~# rpm -q glibc
>         rpmdb: unable to join the environment
>         error: db4 error(11) from dbenv->open: Resource temporarily unavailable
>         error: cannot open Packages index using db3 - Resource temporarily unavailable (11)
>         error: cannot open Packages database in /var/lib/rpm
>         package glibc is not installed
>         
>         [23:10:57]root@phantasy:~# LD_ASSUME_KERNEL=2.2.5 rpm -q glibc
>         glibc-2.3.2-11.9
> 
> If I boot a kernel without NPTL the problem goes away.  The problem also
> does not exist in Red Hat 9's 2.4 kernel (which has NPTL).

But that's a different error.  Robert (Day) reported:

 rpmdb: unable to join the environment
 error: db4 error(11) from dbenv->open: Resource temporarily unavailable
 error: cannot open Packages index using db3 - Resource temporarily unavailable (11)
 error: cannot open Packages database in /var/lib/rpm

but then again, there's no way in which the patch which we're discussing
could cause EAGAIN.

Has anyone straced a failing rpm command?
