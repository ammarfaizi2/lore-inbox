Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263235AbTCUE4p>; Thu, 20 Mar 2003 23:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263241AbTCUE4p>; Thu, 20 Mar 2003 23:56:45 -0500
Received: from hnlmail1.hawaii.rr.com ([24.25.227.32]:56325 "EHLO
	hawaii.rr.com") by vger.kernel.org with ESMTP id <S263235AbTCUE4n>;
	Thu, 20 Mar 2003 23:56:43 -0500
Message-ID: <3E7A9E20.4000908@togami.com>
Date: Thu, 20 Mar 2003 19:07:44 -1000
From: Warren Togami <warren@togami.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030221
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: rpm-4.2 problem with kernel-2.5.65 NPTL
Content-Type: text/plain; charset=us-ascii; format=flowed
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

 >> On Wed, Mar 19, 2003 at 11:43:29PM -1000, Warren Togami wrote:
 >
 >>> > rpm-4.2-0.70 seems to be broken while I am using kernel-2.5.65 with
 >>> > Rawhide.  When I use LD_ASSUME_KERNEL=2.2.5 it works properly as 
you can
 >>> > see below.
 >>> >
 >>> > Is this a bug in rpm or upstream kernel?  Should I file a Red Hat
 >>> > Bugzilla report for rpm?
 >>> >
 >
 >>
 >> Then you have a broken NPTL implementation, which is a glibc/kernel,
 >> not rpm, problem.
 >>
 >
 >>> > (Is rpm-4.2-0.72 or higher available packaged anywhere?)
 >
 >>
 >> Use CVS. rpm-4.2 is on the -r rpm-4_2 branch.
 >>
 >> 73 de Jeff


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


