Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268377AbTAMW3Z>; Mon, 13 Jan 2003 17:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268371AbTAMW3Y>; Mon, 13 Jan 2003 17:29:24 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:13830 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S268378AbTAMW2j>; Mon, 13 Jan 2003 17:28:39 -0500
Message-ID: <3E233BBC.CB78BB67@linux-m68k.org>
Date: Mon, 13 Jan 2003 23:20:44 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       akpm@digeo.com
Subject: Re: [PATCH] fixup loop blkdev, add module_get
References: <20030113040906.A72D22C052@lists.samba.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Rusty Russell wrote:

> > 1) we do not prevent root from shooting themselves in the foot,
> 
> I don't understand this point.

Something to remember here: When we kill processes with SIGKILL, do we
risk kernel stability? E.g. do we turn TASK_UNINTERRUPTIBLE into
TASK_INTERRUPTIBLE, do we allow to kill init or do we leave resources
behind?

> > 3) and this kind of code just adds error handling for no reason, when
> > _not_ handling the error keeps the code more clean.
> 
> No, the reason is simple: the admin has said they want the damn module
> removed.  They've *told* you what they want.  Why do you want to
> disobey them?  8)

How do you want to make this mechanism halfway safe to use? Did you
check that all modules can still be deconfigured after you put them into
the going state via the wait option?
Both the wait and the force option are extremely dangerous options. You
are trying to implement something behind the modules back, what can only
go wrong as soon as the module becomes slightly more complex. If you
want to force the removal of a module, you should least attempt to keep
it safe and this is not possible without the help of the module. A
global don't-use switch is a worse idea than the global module count, if
it's forced onto the modules.
I'm really curious when we get the first bug reports from people, who
"only" unloaded a module. :(

bye, Roman

