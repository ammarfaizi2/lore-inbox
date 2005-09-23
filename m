Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbVIWRDr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbVIWRDr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 13:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbVIWRDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 13:03:47 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:53925 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S1750702AbVIWRDr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 13:03:47 -0400
Date: Fri, 23 Sep 2005 19:03:45 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: Pablo Fernandez <pablo.ferlop@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: max_fd
Message-ID: <20050923170345.GA1555@janus>
References: <8518592505092305373465a5@mail.gmail.com> <20050923155509.GA4723@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050923155509.GA4723@in.ibm.com>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2005 at 09:25:10PM +0530, Dipankar Sarma wrote:
> On Fri, Sep 23, 2005 at 02:37:51PM +0200, Pablo Fernandez wrote:
> > Hi
> > 
> > What happend to files_struct.max_fd? Is it safe to use
> > files_fdtable(files_struct).max_fds?
> 
> No.
> 
> Just do - 
> 
> 	struct fdtable *fdt;
> 
> 	rcu_read_lock();
> 	fdt = files_fdtable(files_struct);
> 	if (fdt->max_fds......
> 	...
> 	rcu_read_unlock();

In include/linux/file.h I see this:

 #define files_fdtable(files) (rcu_dereference((files)->fdt))

looks better to me unless you really want to update the
struct fdtable.

-- 
Frank
