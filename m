Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266120AbUF2WZ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266120AbUF2WZ3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 18:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266121AbUF2WZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 18:25:29 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:10895 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266120AbUF2WZT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 18:25:19 -0400
Subject: Re: per-process namespace?
From: Ram Pai <linuxram@us.ibm.com>
To: Mike Waychison <Michael.Waychison@Sun.COM>
Cc: linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk
In-Reply-To: <40E1DABD.9000202@sun.com>
References: <1088534826.2816.38.camel@dyn319623-009047021109.beaverton.ibm.com>
	 <40E1DABD.9000202@sun.com>
Content-Type: text/plain
Organization: 
Message-Id: <1088547899.4788.41.camel@dyn319623-009047021109.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 29 Jun 2004 15:25:00 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-06-29 at 14:10, Mike Waychison wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Ram Pai wrote:
> > Is there a way for an application to
> > 1. fork its own namespace and modify it, and
> > 2. still be able to see changes to the system namespace?
> >
> > Al Viro's Per-process namespace implementation provides the first
> > feature.  But is there any work done to do the second part? Is it worth
> > doing?
> >
> > RP
> 
> In what sense?
> 
> The current model has no definition for a 'system namespace'.

by 'system namespace' I mean the very first initial  hand-crafted
namespace. 

> 
> Accessing /proc/<pid>/mounts where <pid> is running in a different
> namespace appears to work.

Are you sure? I dont see it to be the case. I just verified it  on 2.6.7
/proc/<pid>/mounts is a file. However /proc/pid/root is a symbolic link 
to the root directory of the process. So the process with a cloned
namespace wont be able to access it through its namespace.


>   As well, you can always fchdir back into
> another namespace temporarily.  As long as you don't reference any
> file/directories using absolute paths (including following symlinks),
> then you can already navigate the entire namespace.

If this feature is available then great!

> 
> This falls apart though when there are no longer any processes keeping
> that namespace alive.  When this happens, the vfsmount's are unstitched
> and you end up 'stuck' on a given mount :(.

> Another caveat is that the current system disallows you from doing any
> mount/umount's in another namespace (bogus security?)
> .
> 
> - --
> Mike Waychison
> Sun Microsystems, Inc.
> 1 (650) 352-5299 voice
> 1 (416) 202-8336 voice
> http://www.sun.com
> 
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> NOTICE:  The opinions expressed in this email are held by me,
> and may not represent the views of Sun Microsystems, Inc.
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.4 (GNU/Linux)
> 
> iD8DBQFA4dq9dQs4kOxk3/MRApkaAKCPe0Nw9QBZH425SZeOIvIzSzksUACfQk5D
> xLgBDN/dsmVMkAAD73mugiY=
> =8OEy
> -----END PGP SIGNATURE-----
> 

