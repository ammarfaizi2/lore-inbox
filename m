Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266305AbUFRRxn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266305AbUFRRxn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 13:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266311AbUFRRxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 13:53:43 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:60329 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S266305AbUFRRxg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 13:53:36 -0400
Message-ID: <40D32C1D.80309@opensound.com>
Date: Fri, 18 Jun 2004 10:53:33 -0700
From: 4Front Technologies <dev@opensound.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Gruenbacher <agruen@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Stop the Linux kernel madness
References: <40D232AD.4020708@opensound.com> <3217460000.1087518092@flay>	 <40D23701.1030302@opensound.com> <1087573691.19400.116.camel@winden.suse.de>
In-Reply-To: <1087573691.19400.116.camel@winden.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Gruenbacher wrote:
> Hello,

[SNIP]

> Not really. The 2.6 kernel series allow to put output files in a
> different directory than the sources -- see the O= option; there is a
> little documentation in the main Makefile. Without the O= option, the
> kernel sources and object files needed to compile external modules will
> reside in the same directory. With the O= option, they will reside in
> different directories. This means that a single /lib/modules/$(uname
> -r)/build symlink is not sufficient anymore. Therefore we have the build
> symlink pointing to the output files, and a new source symlink pointing
> to the real source tree. This change hasn't found its way into mainline
> yet, which is unfortunate. For the discussion, see
> http://marc.theaimsgroup.com/?l=linux-kernel&m=108628265102121&w=2 and
> follow-ups. I keep pinging Sam Ravnborg (the kbuild maintainer), but
> apparently he is busy with other projects at the moment.
> 
> In addition, there is an extra Makefile in /lib/modules/$(uname
> -r)/build that has the usual targets needed for module building, so the
> traditional way of building modules (make -C /lib/modules/$(uname
> -r)/build modules SUBDIRS=$(pwd)) still works. There is no need to build
> scripts, scripts_basic, or whatever in that directory.
> 
> Based on this difference, there are two principal ways to build external
> modules since 2.6.7 (and through back-porting also in the current SUSE
> kernels, which are based on 2.6.5).  We chose to ship the kernel sources
> in /usr/src/linux in a (mostly) unconfigured state, and put the output
> files needed for building external modules below /usr/src/linux-obj/. 
> 
>  This means that you have several choices:
> 
>   - Configure the kernel sources in /usr/src/linux as you wish.
> 
>   - Use one of the standard SUSE configurations.
> 
> I have written a HOWTO describing how to work with the SUSE kernel
> sources, which is available as /usr/src/linux/README.SUSE in our
> packages. An up-to-date online version is available at
> http://www.suse.de/~agruen/kernel-doc/.
> 


Andreas,

Thanks for the perfect explanation to our problems. The question then arises as
to why does SUSE do KBUILDS in this way and the vanilla kernels or Redhat/Fedora/Mandrake/Debian
kernels use another way?. What I'd like to see is at least some standard.

SuSE's Linux 2.6.4 kernels did it the Vanilla kernel way where /lib/modules/2.6.4/build pointed to /usr/src/linux.

The issue is also SuSE's 2.6.4 kernel added the REGPARM patch which was only introduced in Linux 2.6.5
for example. Wouldn't it be better if SuSE had shipped their kernel as Linux 2.6.5?. The point is
what constitutes a "baseline" Linux kernel?. You can add all your patches but if now the kernel is
more in tune with Linux 2.6.7, just call it Linux 2.6.7 - calling it 2.6.5 will break a lot of software.
that isn't included with your kernel sources.

I don't care if SuSE adds patches to drivers but to patch the base kernel/headers in way that breaks
out-of-kernel drivers is something we would like to see addressed.

Ofcourse we will now have to modify our software to detect a SuSE distribution but it's waste of time
and energy because the other distros don't use your concepts. If you deem that your way of building
modules is the "right thing" then I'd love to see Linus move to such a system in his vanilla kernel
source tree.

Most out-of-kernel drivers like ours or other vendors simply rely on kernel include files and not
on the actual .c files. THe location and contents of such kernel includes should be inviolable if
there is a kernel version associated with it.


best regards

Dev Mazumdar
---------------------------------------------------------------------
4Front Technologies
4035 Lafayette Place, Unit F, Culver City, CA 90232, USA
Tel: 310 202 8530   Fax: 310 202 0496   URL: http://www.opensound.com
---------------------------------------------------------------------

