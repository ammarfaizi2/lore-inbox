Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261251AbVAMRvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbVAMRvP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 12:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261246AbVAMRsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 12:48:50 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:45779 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261349AbVAMRov
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 12:44:51 -0500
Date: Thu, 13 Jan 2005 09:44:28 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Arjan van de Ven <arjan@infradead.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, jtk@us.ibm.com, wtaber@us.ibm.com,
       pbadari@us.ibm.com, markv@us.ibm.com, tytso@us.ibm.com,
       suparna@in.ibm.com
Subject: Re: [PATCH] fs: Restore files_lock and set_fs_root exports
Message-ID: <20050113174428.GD1269@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050106190538.GB1618@us.ibm.com> <1105039259.4468.9.camel@laptopd505.fenrus.org> <20050106201531.GJ1292@us.ibm.com> <20050106203258.GN26051@parcelfarce.linux.theplanet.co.uk> <20050106210408.GM1292@us.ibm.com> <20050106212417.GQ26051@parcelfarce.linux.theplanet.co.uk> <20050107010119.GS1292@us.ibm.com> <20050113025157.GA2849@us.ibm.com> <20050113170712.GA867@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050113170712.GA867@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2005 at 09:07:12AM -0800, Greg KH wrote:
> On Wed, Jan 12, 2005 at 06:51:57PM -0800, Paul E. McKenney wrote:
> > 
> > The current hope is that adding (a) shared and asymmetrically shared
> > subtrees between namespaces/locations in the same namespace, (b) stackable
> > LSM modules, and (c) dynamic recursive union mount would enable Linux
> > to provide this in a technically sound manner.  [But this is not clear
> > to me yet.]
> 
> I don't see how (b) has anything to do with this.  Anyone care to
> explain that?

It would allow tracking the processes that are using a given view,
so that state associated with that view could be cleaned up when the
last process exits.  One case that motivates this approach:

1.	one process creates a view (e.g,. "setview" so that
	"/vob/foo/bar.c" references version 1.2, just as
	"/views/v1.2/vob/foo/bar.c" would),

2.	this process forks off several descendants, then exits, and

3.	the descendant processes eventually exit.

The underlying filesystem could use stackable LSM modules to track fork()s
and exit()s, allowing it to work out when all processes using a given
view had terminated.

It is quite possible that there is a better way to do this.  Thoughts?

						Thanx, Paul
