Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317638AbSGFL60>; Sat, 6 Jul 2002 07:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317639AbSGFL6Z>; Sat, 6 Jul 2002 07:58:25 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:11529 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S317638AbSGFL6Z>;
	Sat, 6 Jul 2002 07:58:25 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Alessandro Suardi <alessandro.suardi@oracle.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Bug] 2.5.25 build as one user and install as root 
In-reply-to: Your message of "Sat, 06 Jul 2002 13:28:06 +0200."
             <3D26D446.6050206@oracle.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 06 Jul 2002 22:00:52 +1000
Message-ID: <30159.1025956852@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 06 Jul 2002 13:28:06 +0200, 
Alessandro Suardi <alessandro.suardi@oracle.com> wrote:
>Keith Owens wrote:
>> 2.5.25 existing build system has a nasty bug.  Build as one user then
>> make install as root.  It does supurious recompiles of some files and
>> leaves them owned as root.  All of these files are now owned by root
>> and cause problems when the build user wants to rebuild.
>
>Doesn't happen for me.

Check include/linux/compile.h after building as yourself and after
installing as root.  make install goes

bzImage -> setup.o -> compile.h -> scripts/mkcompile_h ->
#define LINUX_COMPILE_BY \"`whoami`\"

whoami is different when you compile as one user then install as
another.

