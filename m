Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262543AbTEAAdu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 20:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262584AbTEAAdt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 20:33:49 -0400
Received: from smtp-out.comcast.net ([24.153.64.115]:45243 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S262543AbTEAAds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 20:33:48 -0400
Date: Wed, 30 Apr 2003 20:44:41 -0400
From: rmoser <mlmoser@comcast.net>
Subject: Re: Kernel source tree splitting
In-reply-to: <20030430172102.69e13ce9.rddunlap@osdl.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
Message-id: <200304302044410090.01492640@smtp.comcast.net>
MIME-version: 1.0
X-Mailer: Calypso Version 3.30.00.00 (3)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <200304301946130000.01139CC8@smtp.comcast.net>
 <20030430172102.69e13ce9.rddunlap@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



*********** REPLY SEPARATOR  ***********

On 4/30/2003 at 5:21 PM Randy.Dunlap wrote:

>Hi,
>
>I'm probably misreading this...but,
>
>Have you tried this yet?  Does it modify/customize all Kconfig
>and Makefiles for the selected tree splits?
>

I didn't try it.  It would require knowledge of all interdependencies
between modules (i.e. ide-scsi is part of ide.  ide-scsi depends
on scsi), also all source files that belong to each config option
would likely need to be understood by the persons working to
do this, and also the entire build system semantics would need
to be designed to work in pieces.  Assuming this is ever done.

It goes like this:

make *config reads kernel-tree/options/foo.lod
make *config gets to configuration baz in bar.lod
make *config sees baz needs foo
make *config lists baz.
make *config sees biz needs data
make *config refuses to show biz
make missing-depends shows a list of unselectable options and
-----------selecting one tells which kernel option is needed.
make bzImage reads through kernel-tree/options/ and finds which
-----------makefiles to call (current makes have these embedded)
make bzImage builds a kernel.
make modules reads through kernel-tree/options/ and finds which
-----------makefiles to call.
make modules builds a kernel.

>A few days ago, in one tree, I rm-ed arch/{all that I don't need}
>and drivers/{all that I don't need}.
>After that I couldn't run "make *config" because it wants all of
>those files, even if I don't want them.
>

That WILL break something.

>So there are many edits that needed to be done in lots of
>Kconfig and Makefiles if one selectively pulls or omits certain
>sub-directories.
>

The main Makefile will have to be redone.  So would the kconfig
things (make config/menuconfig/xconfig).

The extra plus to this is that other people can steal the build
system for other projects lol.

>
>

