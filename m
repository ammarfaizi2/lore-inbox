Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265890AbUAULIR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 06:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265925AbUAULIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 06:08:17 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:27535 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S265890AbUAULIJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 06:08:09 -0500
Subject: Re: Linux 2.4.25-pre6
From: David Woodhouse <dwmw2@infradead.org>
To: Lukasz Trabinski <lukasz@trabinski.net>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, riel@redhat.com
In-Reply-To: <Pine.LNX.4.58LT.0401210746350.2482@lt.wsisiz.edu.pl>
References: <200401202125.i0KLPOgh007806@lt.wsisiz.edu.pl>
	 <Pine.LNX.4.58L.0401201940470.29729@logos.cnet>
	 <Pine.LNX.4.58LT.0401210746350.2482@lt.wsisiz.edu.pl>
Content-Type: text/plain
Message-Id: <1074683229.16045.122.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8.dwmw2.2) 
Date: Wed, 21 Jan 2004 11:07:09 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-01-21 at 07:47 +0100, Lukasz Trabinski wrote:
> Here is:
> http://lukasz.eu.org/ksymoops.txt

Some weirdness in there. This is init, for example. Apparently in R
state (as are 260-odd other processes), and:

>>EIP; c02d5d38 <contig_page_data+298/3b8>   <=====

Trace; c0106cfc <setup_frame+11c/210>
Trace; c0115ba8 <schedule_timeout+58/b0>
Trace; c013849c <__get_free_pages+1c/20>
Trace; c0115b30 <process_timeout+0/20>
Trace; c014be47 <pipe_poll+37/80>
Trace; c015315d <do_select+12d/250>

>From what I can tell, there are many people waiting on the inode_lock,
because kswapd has taken it and then taken a page fault....

Trace; c0130018 <filemap_nopage+f8/220>
Trace; c01148f0 <do_page_fault+0/5e4>
Trace; c01077f0 <error_code+34/3c>
Trace; c0158fb7 <refile_inode+47/a0>
Trace; c012d7a2 <__remove_inode_page+82/90>

I wonder if one of the lists is corrupt. I'd like to know _precisely_
what's at refile_inode+47 in your build. Please could you run 'gdb
vmlinux' and tell it 'disass refile_inode'. Then save the original
vmlinux somewhere, run 'make CFLAGS_inode.o=-g SUBDIRS=fs vmlinux', load
it in GDB again and repeat the disassembly, followed by 'list
*0xc0158fb7'? 

I assume this is a clean 2.4.25-pre6 build with no other patches or
modules?

-- 
dwmw2


