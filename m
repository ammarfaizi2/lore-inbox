Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261661AbSJQC7R>; Wed, 16 Oct 2002 22:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261662AbSJQC7R>; Wed, 16 Oct 2002 22:59:17 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:26119 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S261661AbSJQC7Q>;
	Wed, 16 Oct 2002 22:59:16 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200210170305.g9H35Ed36356@saturn.cs.uml.edu>
Subject: per-process %CPU
To: linux-kernel@vger.kernel.org
Date: Wed, 16 Oct 2002 23:05:14 -0400 (EDT)
Cc: robert.penz@outertech.com, mingo@elte.hu, rml@tech9.net
In-Reply-To: <200210170146.33348.robert.penz@outertech.com> from "Robert Penz" at Oct 17, 2002 01:46:33 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I want to do following
>
> [root@server13 root]# ps -eo pid,%cpu,%mem,user,args --sort user hC
> ps: error: Option C is reserved.
> usage: ps -[Unix98 options]
>        ps [BSD-style options]
>        ps --[GNU-style long options]
>        ps --help for a command summary
>
> but If I replace C by any other OUTPUT MODIFIERS it works.
> I just want the current %cpu of the process and not the
> decaying average, so is there an other way to get to my goal?
>
> I tried it on redhat, suse and debian distris ... always the same.

I have bad news for you. The kernel doesn't even maintain
the decaying average. Per-process %cpu on Linux is a lie,
and always has been -- except with "top", which crudely does
a measurement itself.

What you get for %cpu is calculated over the lifetime of
the process. Maybe you can find a scheduler hacker to fix
this problem. I'll Cc: a few for you.

Guys, this is a POSIX and UNIX requirement. The system is
supposed to report per-process %CPU for a "recent" time frame.

