Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271139AbTGQLb6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 07:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271184AbTGQLb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 07:31:58 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:1284 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S271139AbTGQLb5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 07:31:57 -0400
Date: Thu, 17 Jul 2003 13:46:47 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: Joel Becker <Joel.Becker@oracle.com>, zippel@linux-m68k.org,
       aebr@win.tue.nl, greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] print_dev_t for 2.6.0-test1-mm
Message-ID: <20030717134647.A2347@pclin040.win.tue.nl>
References: <20030716213451.GA1964@win.tue.nl> <20030716143902.4b26be70.akpm@osdl.org> <20030716222015.GB1964@win.tue.nl> <20030716152143.6ab7d7d3.akpm@osdl.org> <20030717014410.A2026@pclin040.win.tue.nl> <20030716164917.2a7a46f4.akpm@osdl.org> <20030717082716.GA19891@ca-server1.us.oracle.com> <Pine.LNX.4.44.0307171037070.717-100000@serv> <20030717091515.GC19891@ca-server1.us.oracle.com> <20030717022444.19c204ef.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030717022444.19c204ef.akpm@osdl.org>; from akpm@osdl.org on Thu, Jul 17, 2003 at 02:24:44AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 17, 2003 at 02:24:44AM -0700, Andrew Morton wrote:

> And surely the task of mangling whatever comes off the wire into a dev_t for
> init_special_inode() should be private to the Linux NFS client?
> 
> Still wondering why we need to support a 16:16 encoding in [k]dev_t.

I think I answered this already in earlier posts today. Again:
(i) We need support for 16/32/64-bit dev_t.
(ii) User space (glibc) has 64-bit dev_t.
(iii) The split into major/minor is hardwired in <sys/sysmacros.h>,
independent of filesystem. Thus, we must define major(),minor(),makedev().
(iv) For Linux the device number is a cookie - major and minor do not
really have a significance - we just select a driver given a *dev_t
interval. That means that there are no reasons for inventing more
complicated setups like 12:20.

And since you add "[k]": a kdev_t is internal to the kernel,
we do whatever we want. I wanted a pointer (say, to a struct gendisk or so),
but these days it seems we are heading for an arithmetic type, with 32:32.

Andries

