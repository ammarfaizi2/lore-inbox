Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315839AbSEJIeh>; Fri, 10 May 2002 04:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315843AbSEJIeg>; Fri, 10 May 2002 04:34:36 -0400
Received: from 212.Red-80-35-44.pooles.rima-tde.net ([80.35.44.212]:4992 "EHLO
	DervishD.viadomus.com") by vger.kernel.org with ESMTP
	id <S315839AbSEJIeg>; Fri, 10 May 2002 04:34:36 -0400
Date: Fri, 10 May 2002 10:39:28 +0200
Organization: ViaDomus
To: vda@port.imtp.ilyichevsk.odessa.ua
Subject: Re: mmap() doesn't like certain value...
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <3CDB8740.mailBO1BW5NO@viadomus.com>
In-Reply-To: <3CD983C5.mail1K71EX1NG@viadomus.com>
 <200205100810.g4A8AaX28554@Port.imtp.ilyichevsk.odessa.ua>
User-Agent: nail 9.29 12/10/01
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
From: DervishD <raul@viadomus.com>
Reply-To: DervishD <raul@viadomus.com>
X-Mailer: DervishD TWiSTiNG Mailer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Denis :)

    Thanks for answering :)

>        if ((len = PAGE_ALIGN(len)) == 0)
>                return addr;

    This is the problem.

>        if (len > TASK_SIZE)
>                return -EINVAL;

    And is corrected just by inverting the two quoted code snips :)

    If we test for len being greater than TASK_SIZE *before* aligning
it then the function works properly (the alignment will be done
properly in the task address space). No patch needed really ;)

>>     I know: this lengths are enormous, nobody uses them, etc... but I
>Looks like you found an obscure corner case. Good!

    I'll give a try to the inversion, that should work. I have
written a small stress program for mmap, so in a few hours the patch
will be ready. Must I post it here or send it directly to Marcello?

>>     If this is not a bug, but an intended behaviour please excuse me.
>> Moreover, I can provide a patch (I suppose) against the 2.4.18 tree.
>Do it.

    Ok :) I'll prepare the patch right now. Unified diff?

>BTW, does anybody know why len==0 is not flagged as error?

    Well, I suppose that if you request 0 bytes, any address returned
is valid, since it cannot be accessed (SIGSEGV...). Anyway the man
page for mmap() clearly says that the address returned is NEVER 0, so
we must test for len==0 and invert the other tests.

    Thanks a lot for answering, I was supposing that anybody on the
list was ignoring this obvious and easy to correct bug :?

    Raúl
