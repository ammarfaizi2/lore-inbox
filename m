Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275980AbRJDJcV>; Thu, 4 Oct 2001 05:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276118AbRJDJcJ>; Thu, 4 Oct 2001 05:32:09 -0400
Received: from gateway2.ensim.com ([65.164.64.250]:52998 "EHLO
	nasdaq.ms.ensim.com") by vger.kernel.org with ESMTP
	id <S275980AbRJDJb7>; Thu, 4 Oct 2001 05:31:59 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0
From: Paul Menage <pmenage@ensim.com>
To: Christoph Rohland <cr@sap.com>
cc: Paul Menage <pmenage@ensim.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] Pollable /proc/<pid>/ - avoid SIGCHLD/poll() races 
In-Reply-To: Your message of "04 Oct 2001 10:59:07 +0200."
             <m34rpfpyqs.fsf@linux.local> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 04 Oct 2001 02:31:40 -0700
Message-Id: <E15p4qy-0000yf-00@pmenage-dt.ensim.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> The only real user-space solution to this is to have the SIGCHLD
>> handler somehow cause the select() to return immediately
>
>... or implement pselect:
>http://mesh.eecs.umich.edu/cgi-bin/man2html/usr/share/man/man2/select.2.gz

Agreed, althought that's not a user-space solution. Is there any
fundamental reason why no-one's implemented pselect()/ppoll() for Linux
yet?

>
>or use sigsetjmp/siglongjmp

Yes, that would probably solve the situation in question, provided that
siglongjmp() is portably safe. (A comment on LKML in the past suggested
that it's not safe on cygwin, for example.)

>
>Both would be portable and not special to child handling.

One advantage of the pollable /proc/<pid>, (when combined with
do_notify_parent() waking tsk->exit_chldwait) is that any process can
check for the exit of any other process (not just direct children) in a
select()/poll() call. 

Paul

