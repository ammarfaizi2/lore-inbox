Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316210AbSHIWXz>; Fri, 9 Aug 2002 18:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316213AbSHIWXy>; Fri, 9 Aug 2002 18:23:54 -0400
Received: from mail.zmailer.org ([62.240.94.4]:24261 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S316210AbSHIWXy>;
	Fri, 9 Aug 2002 18:23:54 -0400
Date: Sat, 10 Aug 2002 01:27:36 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: klibc development release
Message-ID: <20020809222736.GJ32427@mea-ext.zmailer.org>
References: <aivdi8$r2i$1@cesium.transmeta.com> <200208090934.g799YVZe116824@d12relay01.de.ibm.com> <200208091754.g79HsJkN058572@d06relay02.portsmouth.uk.ibm.com> <3D541018.4050004@zytor.com> <15700.4689.876752.886309@napali.hpl.hp.com> <3D541478.40808@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D541478.40808@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2002 at 12:14:00PM -0700, H. Peter Anvin wrote:
> David Mosberger wrote:
...
> >Alpha calls umount2() "oldumount"; ia64 never had a one-argument
> >version of umount(), so there is no point creating legacy (and the
> >naming is inconsistent anyhow...).
> 
> The gratuitous inconsistencies between platforms is something that is 
> currently driving me up the wall.  I'm starting to think the NetBSD 
> people have the right idea: when you add a system call on NetBSD, you 
> only have to add it in one place and it becomes available on all the 
> platforms they support.

  History...   Initially I thought you are describing something
  different from Linux model (after all, different platforms have
  different ABIs for syscalls, leading to different call-vector
  tables, etc.)  but no, I see no difference from this description.

  How NetBSD handles the issue, I don't know.   One interpretation
  of what you say is that when a new architecture is added to NetBSD,
  it will instantly inherit the entire historical set of syscalls,
  including the obsolete ones.

  As long as old calls are supported, the kernel needs to know
  how to handle a call serving some thing 10 years ago.. ( e.g.
  "oldumount").  Ok, some have been revoked, but not everything
  of the very old and obsolete stuff.


  How this reflects to  klibc ?     What I understand of klibc,
  it can track very closely the kernel in question.  Introducing
  new improved syscall to do XYZ obsoliting ABC, whimblam, you
  replace it.  No need to carry code supporting any other version
  of kernel than for what the stuff is made for.
  ("Small is beautifull", and all that...)


  glibc folks are (to an extreme pain) supporting kernels 2.0
  (if not from before) to current bleeding edge, and emulating
  all fancy dancing available with new system services by doing
  some weird gimmicks..


>     Of course, you can provide a custom implementation for
> any one platform, but the idea is to keep as much of the code
> generic as possible...

  Desire to support running of "native UNIX" binaries means
  emulating their syscalls.  Initially Linux ran MINIX binaries,
  then came SCO binaries, and Alpha running some of OSF/1 binaries...

> 	-hpa

/Matti Aarnio
