Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750877AbVIWRcy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877AbVIWRcy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 13:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbVIWRcy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 13:32:54 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:41912 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750877AbVIWRcx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 13:32:53 -0400
Date: Fri, 23 Sep 2005 22:56:53 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Frank van Maarseveen <frankvm@frankvm.com>
Cc: Pablo Fernandez <pablo.ferlop@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: max_fd
Message-ID: <20050923172653.GA4573@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <8518592505092305373465a5@mail.gmail.com> <20050923155509.GA4723@in.ibm.com> <20050923170345.GA1555@janus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050923170345.GA1555@janus>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2005 at 07:03:45PM +0200, Frank van Maarseveen wrote:
> On Fri, Sep 23, 2005 at 09:25:10PM +0530, Dipankar Sarma wrote:
> > On Fri, Sep 23, 2005 at 02:37:51PM +0200, Pablo Fernandez wrote:
> > Just do - 
> > 
> > 	struct fdtable *fdt;
> > 
> > 	rcu_read_lock();
> > 	fdt = files_fdtable(files_struct);
> > 	if (fdt->max_fds......
> > 	...
> > 	rcu_read_unlock();
> 
> In include/linux/file.h I see this:
> 
>  #define files_fdtable(files) (rcu_dereference((files)->fdt))
> 
> looks better to me unless you really want to update the
> struct fdtable.

I would much rather have it my way :)

Well, the main reason is that if that code is somehow copied
by to a lock-free critical section, it could cause problems.
If you dereference ->fdt multiple times in a lock-free
section, you could see two different pointers due to
a concurrent update.

I would advise sticking to the same convention everywhere.

Thanks
Dipankar
