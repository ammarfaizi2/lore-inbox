Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964938AbWEJMUk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964938AbWEJMUk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 08:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964939AbWEJMUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 08:20:40 -0400
Received: from MAIL.13thfloor.at ([212.16.62.50]:51127 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S964938AbWEJMUk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 08:20:40 -0400
Date: Wed, 10 May 2006 14:20:38 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Al Viro <viro@ftp.linux.org.uk>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org,
       "Eric W. Biederman" <ebiederm@xmission.com>, dev@sw.ru, sam@vilain.net,
       xemul@sw.ru, haveblue@us.ibm.com, clg@fr.ibm.com, frankeh@us.ibm.com
Subject: Re: [PATCH 1/9] nsproxy: Introduce nsproxy
Message-ID: <20060510122038.GC30809@MAIL.13thfloor.at>
Mail-Followup-To: "Serge E. Hallyn" <serue@us.ibm.com>,
	Al Viro <viro@ftp.linux.org.uk>, Andi Kleen <ak@suse.de>,
	linux-kernel@vger.kernel.org,
	"Eric W. Biederman" <ebiederm@xmission.com>, dev@sw.ru,
	sam@vilain.net, xemul@sw.ru, haveblue@us.ibm.com, clg@fr.ibm.com,
	frankeh@us.ibm.com
References: <29vfyljM.2006059-s@us.ibm.com> <20060510021129.GB32523@sergelap.austin.ibm.com> <20060510100057.GA27946@ftp.linux.org.uk> <20060510115520.GA25720@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060510115520.GA25720@sergelap.austin.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2006 at 06:55:21AM -0500, Serge E. Hallyn wrote:
> Quoting Al Viro (viro@ftp.linux.org.uk):
> > On Tue, May 09, 2006 at 09:11:29PM -0500, Serge E. Hallyn wrote:
> > > Introduce the nsproxy struct.  Doesn't do anything yet, but has it's
> > > own lifecycle pretty much mirrorring the fs namespace.
> > > 
> > > Subsequent patches will move the namespace struct into the nsproxy.
> > > Then as more namespaces are introduced, such as utsname, they can
> > > be added to the nsproxy as well.
> > 
> > Is there any reason why those can't be simply part of namespace?  I.e.
> > be carried by the stuff mounted in standard places...
> 
> The argument has been that it is desirable to be able to unshare these
> namespaces - uid, pid, network, sysv, utsname, fs-namespace -
> separately.  Are you talking about having these all be part of a single
> namespace unshared all at once (and stored in struct namespace)?  Or am
> I misunderstandimg you entirely?

the straight forward approach was to have N (currently nine?)
different 'spaces' all referenced by a task, and the latest
idea to optimize that (Andi made that some requirement IIRC)
was to have one structure referenced by the task struct, 
which holds the references to those 'spaces'

> Andi Kleen (I believe) thinks it should be like that, all or nothing.  I
> think Herbert Poetzl had current examples where vserver is used to
> unshare just pieces, i.e. apache unsharing network but sharing global
> pidspace.

we (Linux-VServer) basically consider the various 'spaces'
building blocks (or smallest units) to build larger 
environments which are isolated or virtualized in some
aspects, but not all of them.

think of it as: chroot(), chnamespace, chcontext, chbind, ...

existing examples (just to get the idea) are:

 - cooperating applications which are limited to a subset
   of the available network addresses

 - strictly isolated (pid and resources) services on the
   same filesystem and network

best,
Herbert

> thanks,
> -serge
