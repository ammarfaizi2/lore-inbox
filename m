Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261468AbTCNKHU>; Fri, 14 Mar 2003 05:07:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261641AbTCNKHU>; Fri, 14 Mar 2003 05:07:20 -0500
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:7946 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S261468AbTCNKHT>; Fri, 14 Mar 2003 05:07:19 -0500
Message-Id: <200303141008.h2EA8gu08535@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Jens Axboe <axboe@suse.de>, Oleg Drokin <green@namesys.com>
Subject: Re: [2.4] init/do_mounts.c::rd_load_image() memleak
Date: Fri, 14 Mar 2003 12:05:40 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Oleg Drokin <green@linuxhacker.ru>, alan@redhat.com,
       linux-kernel@vger.kernel.org, viro@math.psu.edu
References: <20030313210144.GA3542@linuxhacker.ru> <20030314110421.A28273@namesys.com> <20030314080911.GY836@suse.de>
In-Reply-To: <20030314080911.GY836@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 March 2003 10:09, Jens Axboe wrote:
> No that would just be another pointless exercise in causing more
> annoyance for someone who has to look through patches finding that
> one hunk that breaks stuff. The recent spelling changes come to mind.

How we should do such global small cleanups?
Maybe grep the source and bring the list of affected files
to maintainers' attention, letting the to gradually push
changes to Linus...

I suspect "bring the list to maintainers' attention"
will be a trickier part ;)

> But just because you don't seem to have seen any kfree(NULL) in the
> kernel does not mean they are not there. And should a good trend not
> allow to grow?

"if(p) free(p)" => "free(p)" is mostly ok, less code.

But free is called now unconditionally. Make an exception
for performance-critical places where p is almost always 0.
--
vda
