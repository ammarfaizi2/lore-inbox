Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315423AbSEVXcw>; Wed, 22 May 2002 19:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315411AbSEVXcv>; Wed, 22 May 2002 19:32:51 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:48393 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S314278AbSEVXct>;
	Wed, 22 May 2002 19:32:49 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Eric Weigle <ehw@lanl.gov>
Cc: "Linux kernel mailing list (lkml)" <linux-kernel@vger.kernel.org>
Subject: Re: Safety of -j N when building kernels? 
In-Reply-To: Your message of "Wed, 22 May 2002 10:53:20 CST."
             <20020522165320.GC18059@lanl.gov> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 23 May 2002 09:32:38 +1000
Message-ID: <344.1022110358@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 May 2002 10:53:20 -0600, 
Eric Weigle <ehw@lanl.gov> wrote:
>So are the kernel's current Makefiles really SMP safe -- can one really
>run multiple jobs when building Linux kernels? Any horror stories, or am
>I just paranoid?

make dep is not parallel safe.  On some architectures make -jN dep will
generate corrupt data, especially with module symbol versions.  You
might get away with it.

It is not safe on any architecture to make -jN *config dep bzImage
modules in one command, you need three separate commands for make -jN
*config, make -jN dep and make -jN bzImage modules.  The install step
must also be a separate command.

Building bzImage and modules should be parallel safe, as long as your
machine can take the cpu load and has enough file descriptors.
Sometimes people do not understand makefiles so the odd driver may not
build correctly.  aic7xxx around 2.4.19-pre5 was not parallel safe.

Of course, in kbuild 2.5, all of this is parallel safe.  make -j
*config install works fine.

