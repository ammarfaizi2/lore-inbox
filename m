Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263645AbTEDQIJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 12:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263646AbTEDQIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 12:08:09 -0400
Received: from corky.net ([212.150.53.130]:32937 "EHLO marcellos.corky.net")
	by vger.kernel.org with ESMTP id S263645AbTEDQII (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 12:08:08 -0400
Date: Sun, 4 May 2003 19:20:24 +0300 (IDT)
From: Yoav Weiss <ml-lkml@unpatched.org>
X-X-Sender: yoavw@marcellos.corky.net
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Announcement] "Exec Shield", new Linux security feature
Message-ID: <Pine.LNX.4.44.0305041847120.12573-100000@marcellos.corky.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   I looked at sys_iopl() and it seems to be checking if its param is
> > 3, so EBX on the stack must be 0x00000003 to set iopl to 3.

You're partially right.
I did miss the 'if (level > 3)' test because I was looking at Ingo's patch
rather than the whole function.
However, it doesn't have to be 3 because we don't really need to set iopl
to anything.  As long as (level > old) is true, which, at this point would
be any param between 1 and 3, current->mm->context.exec_limit = 0xffffffff
will be executed.  The attack won't rely on iopl level itself.  It just
uses iopl to set exec_limit to 0xffffffff so further shellcode can be
called.  In order to exploit this, one would have to find an override
condition where EBX happens to be between 1 and 3.  Tricky, but not as
hard as finding a condition where it points to a "/bin/sh" string :)
And once such call to iopl has been made, any standard shellcode can be
executed from anywhere in memory.

Anyway, as Ingo already said, this whole piece of code is going away on
the next version so we're off-topic now.


>   Shouldnt it be like this?
>

Probably yes, but again - its not related to the potential hole I
described.  I don't know why its defined like that, but maybe the
maintainer of iopl can enlighten us on that.

	Yoav Weiss

