Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbUJHUDW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbUJHUDW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 16:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263778AbUJHUDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 16:03:21 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:6360 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261426AbUJHUDO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 16:03:14 -0400
Date: Fri, 8 Oct 2004 15:02:29 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Matthias Urlichs <smurf@smurf.noris.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: lsm: add bsdjail documentation
Message-ID: <20041008200229.GB3068@IBM-BWN8ZTBWA01.austin.ibm.com>
References: <1097094103.6939.5.camel@serge.austin.ibm.com> <1097094358.6939.13.camel@serge.austin.ibm.com> <pan.2004.10.07.22.17.09.105723@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pan.2004.10.07.22.17.09.105723@smurf.noris.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2004 at 12:17:09AM +0200, Matthias Urlichs wrote:
> Hi, Serge Hallyn wrote:
> 
> > +       echo -n "ip 2.2.2.2" > /proc/$$/attr/exec (optional)
> 
> Please use RFC private addresses in example code.

The attached patch to 2.6.9-rc3-mm3 fixes up the documentation just a little.

> Anyway, that's my vote for adding it to the kernel.

Thanks!

-serge

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>

diff -Nrup linux-2.6.9-rc3-mm3/Documentation/bsdjail.txt linux-2.6.9-rc3-mm3-jail/Documentation/bsdjail.txt
--- linux-2.6.9-rc3-mm3/Documentation/bsdjail.txt	2004-10-08 13:56:34.000000000 -0500
+++ linux-2.6.9-rc3-mm3-jail/Documentation/bsdjail.txt	2004-10-08 15:59:13.845998920 -0500
@@ -6,7 +6,7 @@ Description:
 Implements a subset of the BSD Jail functionality as a Linux LSM.
 What is currently implemented:
 
-  If a proces is in a jail, it:
+  If a process is in a jail, it:
 
     1. Is locked under a chroot (as are all children) which is not
          vulnerable to the well-known chdir(..)(etc)chroot(.) escape.
@@ -18,13 +18,13 @@ What is currently implemented:
     7. Cannot load or unload modules
     8. Cannot change network settings
     9. May be assigned a specific ip address which will be used
-         for all it's socket binds.
+         for all its socket binds.
    10. Cannot see contents of /proc/<pid> entries of processes not in the
          same jail.  (We hide their existence for convenience's sake, but
-         their existance can still be detected using, for instance, statfs)
+         their existence can still be detected using, for instance, statfs)
    11. Has no CAP_SYS_RAWIO capability (no ioperm/iopl)
    12. May not share IPC resources with processes outside its own jail.
-   13. May find it's valid network address (if restricted) under
+   13. May find its valid network address (if restricted) under
        /proc/$$/attr/current.
 
 WARNINGS:
@@ -48,7 +48,7 @@ $ new_namespace_shell /bin/bash
 $ mount /dev/hdc5 /opt
 $ mount -t proc proc /opt/proc
 $ echo -n "root /opt" > /proc/$$/attr/exec
-$ echo -n "ip 9.53.94.111" > /proc/$$/attr/exec
+$ echo -n "ip 192.168.0.2" > /proc/$$/attr/exec
 $ exec /bin/sh
 $ sshd
 $ apachectl start
@@ -56,8 +56,8 @@ $ exit
 
 How to use:
     1. modprobe bsdjail
-    [ 1.5 /sbin/ifconfig eth0:0 2.2.2.2;
-      1.6 /sbin/route add -host 2.2.2.2 dev eth0:0
+    [ 1.5 /sbin/ifconfig eth0:0 192.168.0.2;
+      1.6 /sbin/route add -host 192.168.0.2 dev eth0:0
       (optional) ]
     2. Make sure the root filesystem (ie /dev/hdc5) is not mounted
        anywhere else.
@@ -65,7 +65,8 @@ How to use:
     4. mount /dev/hdc5 /opt
     5. mount -t proc proc /opt/proc
     6. echo -n "root /opt" > /proc/$$/attr/exec
-       echo -n "ip 2.2.2.2" > /proc/$$/attr/exec (optional)
+       echo -n "ip 192.168.0.2" > /proc/$$/attr/exec (optional)
+       echo -n "ip6 2002:a00:0:0:0:0:0:1" > /proc/$$/attr/exec (optional)
     7. exec /bin/sh
     8. sshd
     9. exit
@@ -79,6 +80,7 @@ If a private IP was specified for the ja
 		cat /proc/$$/attr/current
 will show the address for the private network device.  Other network
 devices will be visible through /sbin/ifconfig -a, but not usable.
+A jail may be assigned one IPV4 and one IPV6 address.
 
 If the reading process is not in a jail, then
 		cat /proc/$$/attr/current
@@ -92,8 +94,9 @@ Current valid keywords for creating a ja
 
      root: Root of jail's fs
      ip: Ip addr for this jail
+     ip6: Ipv6 addr for this jail  (may currently not be shorthand)
      nrtask: Number of tasks in this jail
-     nice: The nice level for this jail.  (maybe should be min/max?)
+     nice: The nice level for this jail  (maybe should be min/max?)
      slice: Max timeslice per process
      data: Max size of DATA segment per process
      memlock: Max size of memory which can be locked per process
