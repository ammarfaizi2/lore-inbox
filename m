Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263870AbTEFRdP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 13:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263872AbTEFRdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 13:33:15 -0400
Received: from corky.net ([212.150.53.130]:6824 "EHLO marcellos.corky.net")
	by vger.kernel.org with ESMTP id S263870AbTEFRdO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 13:33:14 -0400
Date: Tue, 6 May 2003 20:45:39 +0300 (IDT)
From: Yoav Weiss <ml-lkml@unpatched.org>
X-X-Sender: yoavw@marcellos.corky.net
To: Jerry Cooperstein <coop@axian.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: The disappearing sys_call_table export.
In-Reply-To: <20030506170123.GA2025@p3.attbi.com>
Message-ID: <Pine.LNX.4.44.0305062028020.9259-100000@marcellos.corky.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 May 2003, Jerry Cooperstein wrote:

> It's much simpler than that: Do either
>
> nm vmlinux | grep sys_call_table
>
>   or
>
> grep sys_call_table System.map
>
> extract the address, use the header file to get the syscall number and
> the offset.

You're right but only in case System.map or vmlinux are available.  In
some distros you only have the bzImage/vmlinuz, and still want to load
some module, without replacing the kernel.

My proposed script would derive this info from exported symbols in the
running kernel, so its more portable.  Another advantage it has is gaining
access to non-globals.  As long as they're referred by some exported
struct, even indirectly, they can be re-exported as globals.  (Not that
I'd do it or recommend it to anyone :)

>
> Of course this all breaks the GPL, but you can get any non-exported
> symbol address that way.

It violates the GPL only if you distribute the resulting module.  As long
as you run the script locally, generate the module locally, and only use
it locally, I don't see how it violates anything.  GPL is a license for
distributors, not users.

	Yoav Weiss


