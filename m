Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263209AbTDGDDv (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 23:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263210AbTDGDDv (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 23:03:51 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:59410
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S263209AbTDGDDu 
	(for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 23:03:50 -0400
Subject: Re: 2.5.66-bk12 causes "rpm" errors
From: Robert Love <rml@tech9.net>
To: Andrew Morton <akpm@digeo.com>
Cc: "Robert P. J. Day" <rpjday@mindspring.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20030406182815.65dd9304.akpm@digeo.com>
References: <20030406183234.1e8abd7f.akpm@digeo.com>
	 <Pine.LNX.4.44.0304062200570.1604-100000@localhost.localdomain>
	 <20030406182815.65dd9304.akpm@digeo.com>
Content-Type: text/plain
Organization: 
Message-Id: <1049685316.894.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 06 Apr 2003 23:15:17 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-04-06 at 21:28, Andrew Morton wrote:

> I am now very confused.

It is a battle tactic.

Backing out this patch (from a kernel roughly similar to 2.5.66-mm3)
does not resolve the problem:

        [23:08:36]root@phantasy:~# rpm -q glibc
        rpmdb: unable to join the environment
        error: db4 error(11) from dbenv->open: Resource temporarily unavailable
        error: cannot open Packages index using db3 - Resource temporarily unavailable (11)
        error: cannot open Packages database in /var/lib/rpm
        package glibc is not installed
        
        [23:10:57]root@phantasy:~# LD_ASSUME_KERNEL=2.2.5 rpm -q glibc
        glibc-2.3.2-11.9

If I boot a kernel without NPTL the problem goes away.  The problem also
does not exist in Red Hat 9's 2.4 kernel (which has NPTL).

When I first started tracking this down, I found an rpm version where
everything worked... like rpm-4.2-0.41 or so.  I am currently running
rpm-4.2-0.69 which experiences the problem.

It only happens with root, by the way.  I guess because non-root users
cannot do much, and everything they do do they do without getting a lock
on the db.

Baffling.

	Robert Love

