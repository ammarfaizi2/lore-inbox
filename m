Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262111AbTEACix (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 22:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262112AbTEACix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 22:38:53 -0400
Received: from air-2.osdl.org ([65.172.181.6]:40088 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262111AbTEACiu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 22:38:50 -0400
Message-ID: <32822.4.64.196.31.1051757471.squirrel@www.osdl.org>
Date: Wed, 30 Apr 2003 19:51:11 -0700 (PDT)
Subject: Re: Kernel source tree splitting
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <mlmoser@comcast.net>
In-Reply-To: <200304302044410090.01492640@smtp.comcast.net>
References: <200304301946130000.01139CC8@smtp.comcast.net>
        <20030430172102.69e13ce9.rddunlap@osdl.org>
        <200304302044410090.01492640@smtp.comcast.net>
X-Priority: 3
Importance: Normal
Cc: <rddunlap@osdl.org>, <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.11)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On 4/30/2003 at 5:21 PM Randy.Dunlap wrote:
>
>>Hi,
>>
>>I'm probably misreading this...but,
>>
>>Have you tried this yet?  Does it modify/customize all Kconfig
>>and Makefiles for the selected tree splits?
>>
>
> I didn't try it.  It would require knowledge of all interdependencies
> between modules (i.e. ide-scsi is part of ide.  ide-scsi depends
> on scsi), also all source files that belong to each config option
> would likely need to be understood by the persons working to
> do this, and also the entire build system semantics would need
> to be designed to work in pieces.  Assuming this is ever done.
>
> It goes like this:
>
> make *config reads kernel-tree/options/foo.lod
> make *config gets to configuration baz in bar.lod
> make *config sees baz needs foo
> make *config lists baz.
> make *config sees biz needs data
> make *config refuses to show biz
> make missing-depends shows a list of unselectable options and
> -----------selecting one tells which kernel option is needed.
> make bzImage reads through kernel-tree/options/ and finds which
> -----------makefiles to call (current makes have these embedded)
> make bzImage builds a kernel.
> make modules reads through kernel-tree/options/ and finds which
> -----------makefiles to call.
> make modules builds a kernel.
>
>>A few days ago, in one tree, I rm-ed arch/{all that I don't need} and
>> drivers/{all that I don't need}.
>>After that I couldn't run "make *config" because it wants all of
>>those files, even if I don't want them.
>>
>
> That WILL break something.

or "That does break something"  (when I tried it).

>>So there are many edits that needed to be done in lots of
>>Kconfig and Makefiles if one selectively pulls or omits certain
>>sub-directories.
>>
>
> The main Makefile will have to be redone.  So would the kconfig
> things (make config/menuconfig/xconfig).
>
> The extra plus to this is that other people can steal the build
> system for other projects lol.

I seem to try for simple solutions when possible and feasible.

In this case, if I were doing it, I would try changing (e.g.) in
arch/i386/kernel/Kconfig, this line:
source "drivers/eisa/Kconfig"
to
optsource "drivers/eisa/Kconfig"
where optsource means that the file is optional -- if not found,
ignore it.  And then see what happens, how far it can go,
what the next problem is....

If this could be made to work, then entire subdirectories/subsystems
could be optional.

~Randy



