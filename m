Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261970AbTKAAOw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 19:14:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262070AbTKAAOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 19:14:52 -0500
Received: from 64.221.211.208.ptr.us.xo.net ([64.221.211.208]:10214 "HELO
	mail.keyresearch.com") by vger.kernel.org with SMTP id S261970AbTKAAOv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 19:14:51 -0500
Subject: [2.6] GUI config targets fail with "make O=..."
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: sam@ravnborg.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1067645690.10240.25.camel@serpentine.internal.keyresearch.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 31 Oct 2003 16:14:50 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Sam -

There's something in the 2.6 kbuild infrastructure that does some rather
wrong things for the gconfig and xconfig targets when object files
should go to a separate directory.

It looks like HOSTCXXFLAGS is being mangled somehow.  Here are the
interesting details:

make -C /home/bos/bk/kernel/key O=/tmp/build-i686-smp xconfig

This results in the following invocation of g++, which chokes:

g++ -Wp,-MD,scripts/kconfig/.qconf.o.d  -O2 \
	-I/home/bos/bk/kernel/key//usr/lib/qt-3.1/include \
	-c -o scripts/kconfig/qconf.o \
	/home/bos/bk/kernel/key/scripts/kconfig/qconf.cc

There are two problems here.  The first is the mangling of -I$(QTDIR) so
that it has a bizarre prefix.  The second is that -I$O/scripts/kconfig
is missing, so the compiler can't find the generated file lkc_defs.h
(which is generated correctly).

Any ideas on how to fix this?

	<b

