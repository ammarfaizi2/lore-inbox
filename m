Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262764AbVBYRyf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262764AbVBYRyf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 12:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262765AbVBYRye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 12:54:34 -0500
Received: from anchor-post-36.mail.demon.net ([194.217.242.86]:28175 "EHLO
	anchor-post-36.mail.demon.net") by vger.kernel.org with ESMTP
	id S262764AbVBYRxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 12:53:37 -0500
Date: Fri, 25 Feb 2005 17:53:28 +0000 (GMT)
From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
cc: davem@davemloft.net, kuznet@ms2.inr.ac.ru, pekkas@netcore.fi,
       jmorris@redhat.com, yoshfuji@linux-ipv6.org, kaber@coreworks.de,
       netdev@oss.sgi.com, lkml <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.6.8.1 to linux-2.6.10: Kernel Patching Issues.
In-Reply-To: <Pine.LNX.4.53.0502251805280.1039@gockel.physik3.uni-rostock.de>
Message-ID: <Pine.LNX.4.10.10502251745400.26437-100000@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	Sorry for the trouble. I have worked out what is going on.

I have been using Cygwin, but I has assumed incorrectly that MS WindowsXP
SP2, like MS Windows 2000, honered mixed case filenames correctly. This is
not the case making MS WindowsXP SP2 Pro non POSIX complient (what a
supprise). A quick google search sugests that I am not the only person
to have issues with this.

Is there any chance that at some point in the future, the kernel filenames
will be changed so that dumb OS like MS Windows don't mess it all up ?

Regards
	Mark Fortescue.

On Fri, 25 Feb 2005, Tim Schmielau wrote:

> On Fri, 25 Feb 2005, Mark Fortescue wrote:
> 
> > The kernel patch files patch-2.6.9 and patch-2.6.10 do not apear to be
> > correct. I had some errors during patching so I generated a diff against a
> > freshly downloaded linux-2.6.10 kernel. See the steps below:
> > 
> > 1) bzcat linux-2.6.8.1.tar.bz2 | tar -xf -
> > 2) cd linux-2.6.8.1
> > 3) bzcat ../patch-2.6.8.1.bz2 | patch -R -p1
> > 	This gives a 2.6.8 kernel.
> > 
> > 4) bzcat ../patch-2.6.9.bz2 | patch -p1
> > 	This should give a 2.6.9 kernel. The patch has two errors:
> > 		./net/ipv4/netfilter/ipt_ecn.c.rej
> > 		./net/ipv4/netfilter/ipt_tcpmss.c.rej
> > 
> > 5) bzcat ../patch-2.6.10.bz2 | patch -p1 -f
> > 	This should give a 2.6.10 kernel. The patch has three erros:
> > 		./include/linux/netfilter_ipv4/ipt_connmark.h.rej
> > 		./net/ipv4/netfilter/ipt_connmark.c.rej
> > 		./net/ipv6/netfilter/ip6t_MARK.c.rej
> > 6) cd ..; mv linux-2.6.8.1 linux-2.6.10p
> > 7) bzcat linux-2.6.10.tar.bz2 | tar -xf -
> > 8) diff -rupN linux-2.6.10p linux-2.6.10 | tee patch-2.6.10.err
> 
> Yes, these steps should work. Actually, I just checked (copy & paste the
> commands from your mail), and it works for me.
> 
> Are you sure your files are ok? md5sums for my copies of the files are
> 
> cffcd2919d9c8ef793ce1ac07a440eda  linux-2.6.10.tar.bz2
> 98f93075c7c24e681eaf7e70783af5e4  linux-2.6.8.1.tar.gz
> 98b7db13a3f13199a48e89a79d2ee388  patch-2.6.10.bz2
> 824b7d88ab2fabc031f1a6c1e6e288ee  patch-2.6.8.1.bz2
> fe744cdcd31b97b803e51ad785520489  patch-2.6.9.bz2
> 
> Are you sure your filesystem works ok? Not out of quota?
> 
> Tim
> 

