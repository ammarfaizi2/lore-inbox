Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265066AbTLCQT7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 11:19:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265071AbTLCQT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 11:19:59 -0500
Received: from brmx1.fl.icn.siemens.com ([12.147.96.32]:55954 "EHLO
	brmx1.fl.icn.siemens.com") by vger.kernel.org with ESMTP
	id S265066AbTLCQT5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 11:19:57 -0500
Message-ID: <7A25937D23A1E64C8E93CB4A50509C2A0310EFAC@stca204a.bus.sc.rolm.com>
From: "Bloch, Jack" <Jack.Bloch@icn.siemens.com>
To: "'Linus Torvalds'" <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: RE: your mail
Date: Wed, 3 Dec 2003 08:19:51 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

I found the problem. I do have errno.h included. I was doing a read of errno
after calling perror. If I read it directly after getting the neagtive 0ne
back, it contains the right value.

Jack Bloch 
Siemens ICN
phone                (561) 923-6550
e-mail                jack.bloch@icn.siemens.com


-----Original Message-----
From: Linus Torvalds [mailto:torvalds@osdl.org]
Sent: Wednesday, December 03, 2003 11:04 AM
To: Bloch, Jack
Cc: linux-kernel@vger.kernel.org
Subject: Re: your mail




On Wed, 3 Dec 2003, Bloch, Jack wrote:
>
> I try to open a non-existan device driver node file. The Kernel returns a
> value of -1 (expected). However, when I read the value of errno it
contains
> a value of 29. A call to the perror functrion does print out the correct
> error message (a value of 2). Why does this happen?

Because you forgot a "#include <errno.h>"? Or you have something else
wrong in your program that makes "errno" mean the wrong thing?

		Linus
