Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316593AbSGGVcB>; Sun, 7 Jul 2002 17:32:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316594AbSGGVcA>; Sun, 7 Jul 2002 17:32:00 -0400
Received: from inet-mail1.oracle.com ([148.87.2.201]:56782 "EHLO
	inet-mail1.oracle.com") by vger.kernel.org with ESMTP
	id <S316593AbSGGVb7>; Sun, 7 Jul 2002 17:31:59 -0400
Message-ID: <3D28B1CC.9070002@oracle.com>
Date: Sun, 07 Jul 2002 23:25:32 +0200
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Consulting Premium Services
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020606
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: [Bug] 2.5.25 build as one user and install as root
References: <30159.1025956852@ocs3.intra.ocs.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> On Sat, 06 Jul 2002 13:28:06 +0200, 
> Alessandro Suardi <alessandro.suardi@oracle.com> wrote:
> 
>>Keith Owens wrote:
>>
>>>2.5.25 existing build system has a nasty bug.  Build as one user then
>>>make install as root.  It does supurious recompiles of some files and
>>>leaves them owned as root.  All of these files are now owned by root
>>>and cause problems when the build user wants to rebuild.
>>
>>Doesn't happen for me.
> 
> 
> Check include/linux/compile.h after building as yourself and after
> installing as root.  make install goes
> 
> bzImage -> setup.o -> compile.h -> scripts/mkcompile_h ->
> #define LINUX_COMPILE_BY \"`whoami`\"

Keith Owens wrote:
 > On Sat, 06 Jul 2002 13:28:06 +0200,
 > Alessandro Suardi <alessandro.suardi@oracle.com> wrote:
 >
 >>Keith Owens wrote:
 >>
 >>>2.5.25 existing build system has a nasty bug.  Build as one user then
 >>>make install as root.  It does supurious recompiles of some files and
 >>>leaves them owned as root.  All of these files are now owned by root
 >>>and cause problems when the build user wants to rebuild.
 >>
 >>Doesn't happen for me.
 >
 >
 > Check include/linux/compile.h after building as yourself and after
 > installing as root.  make install goes
 >
 > bzImage -> setup.o -> compile.h -> scripts/mkcompile_h ->
 > #define LINUX_COMPILE_BY \"`whoami`\"
 >
 > whoami is different when you compile as one user then install as
 > another.
 >

Hey, give me some credit :)

[asuardi@dolphin linux]$ /bin/pwd
/usr/local/src/linux-2.5.25/include/linux
[asuardi@dolphin linux]$ cat compile.h
/* This file is auto generated, version 1 */
#define UTS_MACHINE "i386"
#define UTS_VERSION "#1 Sat Jul 6 02:27:10 CEST 2002"
#define LINUX_COMPILE_TIME "02:27:10"
#define LINUX_COMPILE_BY "asuardi"
#define LINUX_COMPILE_HOST "dolphin"
#define LINUX_COMPILE_DOMAIN ""
#define LINUX_COMPILER "gcc version 3.1"

I'm saying "doesn't happen for me" because it doesn't happen.

I've been compiling kernel as non-root (and well, of course
  installing as root) since 1996.

I'll admit I checked only the files I cut'n'pasted last mail,
  well let's be honest then...

[asuardi@dolphin linux]$ /bin/pwd
/usr/local/src/linux-2.5.25
[asuardi@dolphin linux]$ find . -user root -print
[asuardi@dolphin linux]$

See, *no* root-owned files here. Usual process is

  * save previous kernel's .config
  * zap previous kernel tree
  * untar the previous kernel tree in /usr/local/src
  * patch -p1 it with current kernel patch
  * create new kernel tarball
  * copy over saved .config
  * make oldconfig
  * make dep; make clean; make bzImage; make modules
  * (wait for next kernel patch ;)

Ciao,

--alessandro

  "my actions make me beautiful / and dignify the flesh"
                 (R.E.M., "Falls to Climb")


