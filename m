Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265459AbSJXOe2>; Thu, 24 Oct 2002 10:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265463AbSJXOe2>; Thu, 24 Oct 2002 10:34:28 -0400
Received: from mail.hometree.net ([212.34.181.120]:58833 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S265459AbSJXOe1>; Thu, 24 Oct 2002 10:34:27 -0400
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: One for the Security Guru's
Date: Thu, 24 Oct 2002 14:40:39 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <ap90p7$djo$1@forge.intermeta.de>
References: <20021023130251.GF25422@rdlg.net> <1035460549.8675.50.camel@irongate.swansea.linux.org.uk>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1035470439 27504 212.34.181.4 (24 Oct 2002 14:40:39 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Thu, 24 Oct 2002 14:40:39 +0000 (UTC)
X-Copyright: (C) 1996-2002 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

>On Thu, 2002-10-24 at 12:09, Henning P. Schmiedehausen wrote:
>> Ville Herva <vherva@niksula.hut.fi> writes:
>> 
>> >the /dev/kmem hole, but this closes 2 classes of attacks - loading rootkit
>> >module and booting with a hacked kernel in straight-forward way.
>> 
>> Question: What do I lose when you remove /dev/kmem?
>> Related question: Would it be useful to make /dev/kmem read-only? 

>Makes no real difference. If the user got to root they can work the
>chmod command. What you want to do is revoke CAP_SYS_RAWIO which kills
>off all direct hardware access - mem/kmem/iopl/ioperm etc. It does stop
>non kernel fb X working but thats not a big deal on a server.

Hm,

I've been in a hurry when I wrote my first mail. What I meant was:

- I remove drivers/char/mem.c from my kernel. What do I lose? (/dev/null,
  /dev/zero and /dev/full afaics but cut this down to "i remove everything
  related to mem_fops, kmem_fops and port_fops").

- I remove write_mem(), write_kmem() and write_port() from drivers/char/mem.c 
  What do I lose?

Removing CAP_SYS_RAWIO is nice, but I actually want to remove the code
from the kernel, not just disabling it (Yes, of course I could try but
my test box is in pieces ATM...).

The pointer to the Xserver is a good one. Thanks. 

	Regards
		Henning

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
