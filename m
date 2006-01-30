Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964999AbWA3VQf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964999AbWA3VQf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 16:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965000AbWA3VQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 16:16:35 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:26503 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964999AbWA3VQe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 16:16:34 -0500
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, vserver@list.linux-vserver.org,
       Herbert Poetzl <herbert@13thfloor.at>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH 4/5] vt: Update spawnpid to use a task_ref.
References: <m1psmba4bn.fsf@ebiederm.dsl.xmission.com>
	<m1lkwza479.fsf@ebiederm.dsl.xmission.com>
	<m1hd7na44b.fsf_-_@ebiederm.dsl.xmission.com>
	<m1d5iba3xf.fsf_-_@ebiederm.dsl.xmission.com>
	<m18xsza3p4.fsf_-_@ebiederm.dsl.xmission.com>
	<20060130105143.GA2953@elf.ucw.cz>
	<m1mzhd5u2s.fsf@ebiederm.dsl.xmission.com>
	<20060130210513.GH2250@elf.ucw.cz>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 30 Jan 2006 14:15:31 -0700
In-Reply-To: <20060130210513.GH2250@elf.ucw.cz> (Pavel Machek's message of
 "Mon, 30 Jan 2006 22:05:13 +0100")
Message-ID: <m17j8h5sek.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> writes:

> Hi!
>
>> >> 7ed8301463a49ad03f8c9de2bbf8c41a5d9843ea
>> >> diff --git a/drivers/char/keyboard.c b/drivers/char/keyboard.c
>> >> index 8b603b2..4e1f2e0 100644
>> >> --- a/drivers/char/keyboard.c
>> >> +++ b/drivers/char/keyboard.c
>> >> @@ -109,7 +109,8 @@ struct kbd_struct kbd_table[MAX_NR_CONSO
>> >>  static struct kbd_struct *kbd = kbd_table;
>> >>  static struct kbd_struct kbd0;
>> >>  
>> >> -int spawnpid, spawnsig;
>> >> +TASK_REF(spawnpid);
>> >
>> > Could we get some nicer syntax of declaration? This does not look like
>> > declaration, and looks ugly to my eyes.
>> 
>> Any suggestions?
>> 
>> Does 
>> struct task_ref *spawnpid = &init_tref;
>
> Looks must better...

The challenge for me is that I make assumptions that a struct task_ref *
always points to something valid.

Maybe it is sufficient to spell that out in comments.  Having a helper
function though feels like it encourages it even more.  I guess
the code oopsing if it is a NULL pointer helps too.

Eric
