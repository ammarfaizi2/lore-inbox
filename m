Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261250AbVAHSct@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261250AbVAHSct (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 13:32:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbVAHSct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 13:32:49 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:31367 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261250AbVAHScg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 13:32:36 -0500
Date: Sat, 8 Jan 2005 10:32:20 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, arjan@infradead.org,
       linux-kernel@vger.kernel.org, jtk@us.ibm.com, wtaber@us.ibm.com,
       pbadari@us.ibm.com, markv@us.ibm.com, greghk@us.ibm.com,
       Linus Torvalds <torvalds@osdl.org>, dipankar@in.ibm.com
Subject: Re: [PATCH] add feature-removal-schedule.txt documentation
Message-ID: <20050108183220.GA2033@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050106190538.GB1618@us.ibm.com> <1105039259.4468.9.camel@laptopd505.fenrus.org> <20050106201531.GJ1292@us.ibm.com> <20050106203258.GN26051@parcelfarce.linux.theplanet.co.uk> <20050106210408.GM1292@us.ibm.com> <20050106212417.GQ26051@parcelfarce.linux.theplanet.co.uk> <20050106152621.395f935e.akpm@osdl.org> <20050106235633.GA10110@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050106235633.GA10110@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2005 at 03:56:34PM -0800, Greg KH wrote:
> On Thu, Jan 06, 2005 at 03:26:21PM -0800, Andrew Morton wrote:
> > Which begs the question "how do we ever get rid of these things when we
> > have no projected date for Linux-2.8"?
> > 
> > I'd propose:
> > 
> > a) Create Documentation/feature-removal-schedule.txt which describes
> >    things which are going away, when, why, who is involved, etc.
> 
> Ok, I'll bite, here's a patch that does just that.  Look good?
> 
> thanks,
> 
> greg k-h
> 
> -----------
> 
> Add Documentation/feature-removal-schedule.txt as a way to notify
> everyone when and what is going to be removed.
> 
> Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>
> 
> diff -Nru a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
> --- /dev/null	Wed Dec 31 16:00:00 196900
> +++ b/Documentation/feature-removal-schedule.txt	2005-01-06 15:54:40 -08:00
> @@ -0,0 +1,17 @@
> +The following is a list of files and features that are going to be
> +removed in the kernel source tree.  Every entry should contain what
> +exactly is going away, why it is happening, and who is going to be doing
> +the work.  When the feature is removed from the kernel, it should also
> +be removed from this file.
> +
> +---------------------------
> +
> +What:	devfs
> +When:	July 2005
> +Files:	fs/devfs/*, include/linux/devfs_fs*.h and assorted devfs
> +	function calls throughout the kernel tree
> +Why:	It has been unmaintained for a number of years, has unfixable
> +	races, contains a naming policy within the kernel that is
> +	against the LSB, and can be replaced by using udev.
> +Who:	Greg Kroah-Hartman <greg@kroah.com>
> +

And another.  I would also like to flag the exports themselves as
indicated in the patch below.  Thoughts?

						Thanx, Paul

What:	call_rcu(), call_rcu_bh(), and synchronize_kernel() change from
	EXPORT_SYMBOL() to EXPORT_SYMBOL_GPL().
When:	January 9, 2006
Files:  kernel/rcupdate.c
Why:	There are no known environments supporting RCU from which
	one could reasonably expect to port a non-GPL kernel module
	or driver to Linux.
Who:	Paul E. McKenney <paulmck@us.ibm.com>


diff -urpN -X ../dontdiff linux-2.5/kernel/rcupdate.c linux-2.5-rcu-export-warn/kernel/rcupdate.c
--- linux-2.5/kernel/rcupdate.c	Sat Jan  8 09:25:55 2005
+++ linux-2.5-rcu-export-warn/kernel/rcupdate.c	Sat Jan  8 10:21:18 2005
@@ -465,6 +465,8 @@ void synchronize_kernel(void)
 }
 
 module_param(maxbatch, int, 0);
+
+/* WARNING: these will become EXPORT_SYMBOL_GPL() in January 2006. */
 EXPORT_SYMBOL(call_rcu);
 EXPORT_SYMBOL(call_rcu_bh);
 EXPORT_SYMBOL(synchronize_kernel);
