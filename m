Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262185AbULRLIn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262185AbULRLIn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 06:08:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262205AbULRLIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 06:08:42 -0500
Received: from astra.telenet-ops.be ([195.130.132.58]:36003 "EHLO
	astra.telenet-ops.be") by vger.kernel.org with ESMTP
	id S262185AbULRLIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 06:08:37 -0500
Subject: Re: do_IRQ: stack overflow: 872..
From: Bart De Schuymer <bdschuym@pandora.be>
To: Andi Kleen <ak@suse.de>
Cc: Crazy AMD K7 <snort2004@mail.ru>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
In-Reply-To: <p73zn0ccaee.fsf@verdi.suse.de>
References: <1131604877.20041218092730@mail.ru.suse.lists.linux.kernel>
	 <p73zn0ccaee.fsf@verdi.suse.de>
Content-Type: text/plain; charset=utf-8
Date: Sat, 18 Dec 2004 12:12:09 +0100
Message-Id: <1103368330.3566.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Op za, 18-12-2004 te 08:50 +0100, schreef Andi Kleen:
> Crazy AMD K7 <snort2004@mail.ru> writes:
> 
> > Hi!
> > I have found a few days ago strange messages in /var/log/messages
> > More than 10 times there was do_IRQ: stack overflow: (nimber).... followed
> > with code. If need I can send all this data. I have run
> > ksymoops with only first 3 cases. Here is the first, the second and
> > the third are in attachment.
> > After that oopses my system continued to work.
> 
> It's not really an oops, just a warning that stack space got quiet tight.
> 
> The problem seems to be that the br netfilter code is nesting far too
> deeply and recursing several times. Looks like a design bug to me,
> it shouldn't do that.
> 
> > uname uname -a
> > Linux linux 2.4.28 #2 ÷ÔÒ îÏÑ 30 15:43:35 MSK 2004 i686 unknown
> > gcc -v
> > Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/2.96/specs
> > gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-113)
> > I have applies ebtables_brnf patch (http://bridge.sf.net) and a
> 
> Don't do that then or contact the author to fix it. Unfortunately
> the code is also in 2.6 mainline.
> 

Hi.

The bridge-nf code does not use recursive function calls and there is no
long consecutive function calling. Furthermore, there is no function in
the bridge-nf code that uses a large part of the stack.
Andi, if you make such statements then please point out the code part
you have (of course) read after which you decided to make the statement.
The bridge-nf code is used by quite a few people and by commercial
companies and I have never had a report like this. AMD has been having
all sorts of strange problems for weeks now, they're all somehow related
to bridge-nf, but I doubt he is using the bridge-nf patch on a clean 2.4
kernel.
AMD, is there any chance you can use the latest 2.6 kernel, without
extra patches ?

Bart


