Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161138AbWJDOOa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161138AbWJDOOa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 10:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161111AbWJDOO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 10:14:29 -0400
Received: from users.ccur.com ([66.10.65.2]:49563 "EHLO gamx.iccur.com")
	by vger.kernel.org with ESMTP id S1161094AbWJDOO2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 10:14:28 -0400
Date: Wed, 4 Oct 2006 10:14:05 -0400
From: Joe Korty <joe.korty@ccur.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Reinette Chatre <reinette.chatre@linux.intel.com>,
       linux-kernel@vger.kernel.org,
       Inaky Perez-Gonzalez <inaky@linux.intel.com>, Paul Jackson <pj@sgi.com>
Subject: Re: [PATCH] bitmap: bitmap_parse takes a kernel buffer instead of a user buffer
Message-ID: <20061004141405.GA22833@tsunami.ccur.com>
Reply-To: Joe Korty <joe.korty@ccur.com>
References: <200610030816.27941.reinette.chatre@linux.intel.com> <20061003163936.d8e26629.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061003163936.d8e26629.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2006 at 04:39:36PM -0700, Andrew Morton wrote:
> On Tue, 3 Oct 2006 08:16:27 -0700
> Reinette Chatre <reinette.chatre@linux.intel.com> wrote:
> 
> > lib/bitmap.c:bitmap_parse() is a library function that received as
> > input a  user buffer. This seemed to have originated from the way the
> > write_proc function of the /proc filesystem operates.
> > 
> > This function will be useful for other uses as well;
> > for example, taking input  for /sysfs instead of /proc,
> > so it was changed to accept kernel buffers. We have this
> > use for the Linux UWB project, as part as the upcoming
> > bandwidth allocator code.
> > 
> > Only a few routines used this function and they were changed too.
> 
> Fair enough.  But this: [ ... ] is sending us a message ;)
> 
> How about adding a new bitmap_parse_user() (and cpumask_parse_user())
> which does the above?


I am slightly concerned about using a kmalloc where 'count' is specified
by userspace.  There might be a DoS attack in here somewhere.....

Perhaps we can reverse Andrew's idea: rename the existing bitmap_parse
to bitmap_parse_user, then make the kernel-buffer version, bitmap_parse,
be a wrapper around that.

Joe
