Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262847AbULRHvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262847AbULRHvH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 02:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262850AbULRHvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 02:51:07 -0500
Received: from cantor.suse.de ([195.135.220.2]:11417 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262847AbULRHuw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 02:50:52 -0500
To: Crazy AMD K7 <snort2004@mail.ru>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: do_IRQ: stack overflow: 872..
References: <1131604877.20041218092730@mail.ru.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 18 Dec 2004 08:50:49 +0100
In-Reply-To: <1131604877.20041218092730@mail.ru.suse.lists.linux.kernel>
Message-ID: <p73zn0ccaee.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Crazy AMD K7 <snort2004@mail.ru> writes:

> Hi!
> I have found a few days ago strange messages in /var/log/messages
> More than 10 times there was do_IRQ: stack overflow: (nimber).... followed
> with code. If need I can send all this data. I have run
> ksymoops with only first 3 cases. Here is the first, the second and
> the third are in attachment.
> After that oopses my system continued to work.

It's not really an oops, just a warning that stack space got quiet tight.

The problem seems to be that the br netfilter code is nesting far too
deeply and recursing several times. Looks like a design bug to me,
it shouldn't do that.

> uname uname -a
> Linux linux 2.4.28 #2 Втр Ноя 30 15:43:35 MSK 2004 i686 unknown
> gcc -v
> Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/2.96/specs
> gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-113)
> I have applies ebtables_brnf patch (http://bridge.sf.net) and a

Don't do that then or contact the author to fix it. Unfortunately
the code is also in 2.6 mainline.

-Andi
