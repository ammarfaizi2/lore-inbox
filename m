Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262635AbTCTVcj>; Thu, 20 Mar 2003 16:32:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262637AbTCTVcj>; Thu, 20 Mar 2003 16:32:39 -0500
Received: from hnlmail1.hawaii.rr.com ([24.25.227.32]:59916 "EHLO
	hawaii.rr.com") by vger.kernel.org with ESMTP id <S262635AbTCTVcf>;
	Thu, 20 Mar 2003 16:32:35 -0500
Subject: kernel-2.5.65 NPTL causes rpm-4.2 problem?
From: Warren Togami <warren@togami.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <20030320122209.H18799@devserv.devel.redhat.com>
References: <3E798D41.9050000@togami.com>
	 <20030320122209.H18799@devserv.devel.redhat.com>
Content-Type: text/plain
Organization: 
Message-Id: <1048196604.8094.25.camel@laptop>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-3) 
Date: 20 Mar 2003 11:43:24 -1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Johnson suspected from this behavior that NPTL in my kernel is
broken in kernel-2.5.65 compiled with gcc-3.2.2-2.  Any ideas of what I
can try?

(I am not subscribed to LKML at the moment.  Please CC me. Thanks.)
Warren Togami
warren@togami.com

On Thu, 2003-03-20 at 07:22, Jeff Johnson wrote:
> On Wed, Mar 19, 2003 at 11:43:29PM -1000, Warren Togami wrote:
> > rpm-4.2-0.70 seems to be broken while I am using kernel-2.5.65 with 
> > Rawhide.  When I use LD_ASSUME_KERNEL=2.2.5 it works properly as you can 
> > see below.
> > 
> > Is this a bug in rpm or upstream kernel?  Should I file a Red Hat 
> > Bugzilla report for rpm?
> > 
> 
> Then you have a broken NPTL implementation, which is a glibc/kernel,
> not rpm, problem.
> 
> > (Is rpm-4.2-0.72 or higher available packaged anywhere?)
> 
> Use CVS. rpm-4.2 is on the -r rpm-4_2 branch.
> 
> 73 de Jeff

[root@laptop root]# rpm -Uvh gaim*
rpmdb: write: 0xbfffd350, 8192: Invalid argument
error: db4 error(22) from dbenv->open: Invalid argument
error: cannot open Packages index using db3 - Invalid argument (22)
error: cannot open Packages database in /var/lib/rpm
rpmdb: unable to join the environment
error: db4 error(11) from dbenv->open: Resource temporarily unavailable
error: cannot open Packages database in /var/lib/rpm
rpmdb: unable to join the environment
error: db4 error(11) from dbenv->open: Resource temporarily unavailable
error: cannot open Packages database in /var/lib/rpm
[root@laptop root]# ls
bin  gaim-0.60-0.fdr.0.1.cvs20030319.i386.rpm 
gaim-plugin-encrypt-0.60-0.fdr.0.1.cvs20030319.i386.rpm  kernel
[root@laptop root]# LD_ASSUME_KERNEL=2.2.5 rpm -Uvh gaim*
Preparing...                ########################################### 
[100%]
   1:gaim                   ########################################### 
[ 50%]
   2:gaim-plugin-encrypt    ########################################### 
[100%]
[root@laptop root]# uname -a
Linux laptop 2.5.65 #2 Tue Mar 18 23:39:11 HST 2003 i686 athlon i386 
GNU/Linux
[root@laptop root]# rpm -q rpm
rpmdb: unable to join the environment
error: db4 error(11) from dbenv->open: Resource temporarily unavailable
error: cannot open Packages index using db3 - Resource temporarily 
unavailable (11)
error: cannot open Packages database in /var/lib/rpm
package rpm is not installed
[root@laptop root]# LD_ASSUME_KERNEL=2.2.5 rpm -q rpm
rpm-4.2-0.70


