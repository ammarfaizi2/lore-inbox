Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261344AbTCGEeZ>; Thu, 6 Mar 2003 23:34:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261346AbTCGEeZ>; Thu, 6 Mar 2003 23:34:25 -0500
Received: from quake.mweb.co.za ([196.2.45.76]:32743 "EHLO quake.mweb.co.za")
	by vger.kernel.org with ESMTP id <S261344AbTCGEeX>;
	Thu, 6 Mar 2003 23:34:23 -0500
Date: Fri, 7 Mar 2003 06:39:40 +0200
From: Martin Schlemmer <azarah@gentoo.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Corruption problem with ext3 and htree
Message-Id: <20030307063940.6d81780e.azarah@gentoo.org>
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

For some time now I have been having a problem with ext3 and htree.

I use Gentoo, with portage as package system.  My root is on ext3
without htree, and my portage tmp/build directory is on another
drive with ext3 and htree.

Now, when you install something, it unpacks and compile and then
install it to the build root on the tmp partition (ext3 with htree),
and then 'merge' it to / (ext3 without htree) from that build root.

Every time I get the following when it 'merge' the installed image
to /:

-------------------------------------------------------
>>> /usr/share/man/man3/threads::shared.3pm.gz
>>> /usr/share/man/man3/bigrat.3pm.gz
Traceback (most recent call last):
  File "/usr/bin/emerge", line 1833, in ?
    mydepgraph.merge(mydepgraph.altlist())
  File "/usr/bin/emerge", line 1125, in merge
    retval=portage.doebuild(y,"merge",myroot,edebug)
  File "/usr/lib/python2.2/site-packages/portage.py", line 1467, in
doebuild    return
merge(settings["CATEGORY"],settings["PF"],settings["D"],settings["BUILD
DIR"]+"/build-info",myroot,myebuild=settings["EBUILD"])  File
"/usr/lib/python2.2/site-packages/portage.py", line 1575, in merge   
return mylink.merge(pkgloc,infloc,myroot,myebuild)  File
"/usr/lib/python2.2/site-packages/portage.py", line 4147, in merge   
return self.treewalk(mergeroot,myroot,inforoot,myebuild)  File
"/usr/lib/python2.2/site-packages/portage.py", line 3849, in treewalk   
if
self.mergeme(srcroot,destroot,outfile,secondhand,"",cfgfiledict,mymtime
):  File "/usr/lib/python2.2/site-packages/portage.py", line 4021, in
mergeme    if
self.mergeme(srcroot,destroot,outfile,secondhand,offset+x+"/",cfgfiledi
ct,thismtime):  File "/usr/lib/python2.2/site-packages/portage.py", line
4021, in mergeme    if
self.mergeme(srcroot,destroot,outfile,secondhand,offset+x+"/",cfgfiledi
ct,thismtime):  File "/usr/lib/python2.2/site-packages/portage.py", line
4021, in mergeme    if
self.mergeme(srcroot,destroot,outfile,secondhand,offset+x+"/",cfgfiledi
ct,thismtime):  File "/usr/lib/python2.2/site-packages/portage.py", line
4021, in mergeme    if
self.mergeme(srcroot,destroot,outfile,secondhand,offset+x+"/",cfgfiledi
ct,thismtime):  File "/usr/lib/python2.2/site-packages/portage.py", line
3944, in mergeme    mystat=os.lstat(mysrc)
OSError: [Errno 2] No such file or directory:
'/space/var/tmp/portage/perl-5.8.0-r10/image/usr/share/man/man3/Hash::U
til.tmp' 
nosferatu ext3 # rm
/space/var/tmp/portage/perl-5.8.0-r10/image/usr/share/man/man3/Hash\:\:
Util. Hash::Util.3pm.gz  Hash::Util.tmp     
nosferatu ext3 # rm
/space/var/tmp/portage/perl-5.8.0-r10/image/usr/share/man/man3/Hash\:\:
Util.tmp/.deps              Makefile           Makefile.in       
gal-view-menus.h   gal-view-menus.o   .libs              Makefile.am    
   gal-view-menus.c   gal-view-menus.lo  libmenus.la        nosferatu
ext3 #
-------------------------------------------------------

Basically, the .tmp file for the manpage 
(/space/var/tmp/portage/perl-5.8.0-r10/image/usr/share/man/man3/Hash::U
til.tmp) gets created as a directory that points to some other dir on
the ext3 with htree partition.

I can recreate this every time.  I can try a few things to try and
figure this out.

Specs:
   P4 2.4 with Asus P4T533-C
   linux-2.5.64 (also with all the previous, and 2.4 ...)


Regards,

-- 

Martin Schlemmer
Gentoo Linux Developer, Desktop/System Team Developer
Cape Town, South Africa

