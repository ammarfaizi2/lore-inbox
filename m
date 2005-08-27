Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965184AbVH0Ap5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965184AbVH0Ap5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 20:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965185AbVH0Ap5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 20:45:57 -0400
Received: from c-24-61-23-223.hsd1.ma.comcast.net ([24.61.23.223]:58274 "EHLO
	cgf.cx") by vger.kernel.org with ESMTP id S965184AbVH0Ap4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 20:45:56 -0400
Date: Fri, 26 Aug 2005 20:45:53 -0400
From: Christopher Faylor <cgf@timesys.com>
To: linux-kernel@vger.kernel.org, Chris du Quesnay <duquesnay@hotmail.com>
Subject: Re: Building the kernel with Cygwin
Message-ID: <20050827004553.GB4413@trixie.casa.cgf.cx>
References: <BAY14-F20DDBBC08EC1461957F455BAAB0@phx.gbl> <Pine.LNX.4.61.0508251258330.4160@chaos.analogic.com> <20050825184551.GA32464@trixie.casa.cgf.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050825184551.GA32464@trixie.casa.cgf.cx>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2005 at 02:45:51PM -0400, Christopher Faylor wrote:
>On Thu, Aug 25, 2005 at 01:05:24PM -0400, linux-os (Dick Johnson) wrote:
>>On Thu, 25 Aug 2005, Chris du Quesnay wrote:
>>>The scripts/basic directory contains a fixdep.exe after the make is
>>>run.  There is no fixdep file.  I tried renaming the fixdep.exe to
>>>fixdep, but that also resulted in the same make error.
>>
>>Ah yes! The Makefile will not execute 'fixdep.exe` it executes 'fixdep'
>>--hard coded.  I don't know how well cygwin emulates a Unix
>>environment, but maybe you can use an alias???  ..  Like...  alias
>>fixdep='fixdep.exe'
>
>How about a symlink?
>
>ln -s fixdep.exe fixdep

FWIW, I've just built a linux kernel on my cygwin system using a ppc cross
compiler.

Here's roughly what I did (this is not verbatim what I did but it should
serve as a rough guide):

  c:\>c:\cygwin\bin\bash
  bash$ export PATH=/bin:$PATH
  bash$ cd /tmp
  bash$ wget http://cygwin.com/snapshots/cygwin-inst-20050826.tar.bz2
  bash$ wget http://cygwin.com/snapshots/cygwin1-20050826.dll.bz2
  bash$ wget ftp://ftp.kernel.org:/pub/linux/kernel/v2.6/linux-2.6.12.tar.bz2
  bash$ bzip2 -d cygwin1-20050826.dll.bz2
  bash$ cd /
  bash$ # expect some errors about being unable to overwrite
  bash$ # cygwin1.dll below
  bash$ tar xjf /tmp/cygwin-inst-20050826.tar.bz2
  bash$ # exit from the running cygwin process so that the cygwin DLL can
  bash$ # be overwritten
  bash$ exit

  c:\>copy c:\cygwin\tmp\cygwin1-20050826.dll c:\cygwin\bin\cygwin1.dll
  c:\>c:\cygwin\bin\bash
  bash$ export PATH=/bin:/path-to-cross/compiler:$PATH
  bash$ mkdir /cygdrive/c/managed /managed
  bash$ mount -b -o managed c:/managed /managed
  bash$ cd /managed
  bash$ tar xjf /tmp/linux-2.6.12.tar.bz2
  bash$ cd linux-2.6.12
  bash$ make ARCH=ppc HOST_LOADLIBES=-lintl defconfig
  bash$ make ARCH=ppc CROSS_COMPILE=ppc-linux-

Note that I have recently added the elf.h header files to cygwin so this
should allow the kernel to be built without any addition steps.  But,
you need to download a cygwin snapshot to get this because the headers
aren't part of the latest version of cygwin yet.  You also need to
specify HOST_LOADLIBES on the command line because it's required for
cygwin.  Using a "managed" mount also allows the creation of files with
mixed case.

I haven't yet checked that the kernel produced from these steps works
but the make does seem to complete without error.

cgf
--
Christopher Faylor                         spammer?  -> aaaspam@sourceware.org
Cygwin Co-Project Leader				aaaspam@duffek.com
TimeSys, Inc.
