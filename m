Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265941AbUAULzj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 06:55:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265943AbUAULzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 06:55:38 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:51087 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S265941AbUAULzh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 06:55:37 -0500
Subject: Re: Linux 2.4.25-pre6
From: David Woodhouse <dwmw2@infradead.org>
To: Lukasz Trabinski <lukasz@trabinski.net>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, riel@redhat.com
In-Reply-To: <Pine.LNX.4.58LT.0401211225560.31684@oceanic.wsisiz.edu.pl>
References: <200401202125.i0KLPOgh007806@lt.wsisiz.edu.pl>
	 <Pine.LNX.4.58L.0401201940470.29729@logos.cnet>
	 <Pine.LNX.4.58LT.0401210746350.2482@lt.wsisiz.edu.pl>
	 <Pine.LNX.4.58L.0401210852490.5072@logos.cnet>
	 <Pine.LNX.4.58LT.0401211225560.31684@oceanic.wsisiz.edu.pl>
Content-Type: text/plain
Message-Id: <1074686081.16045.141.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8.dwmw2.2) 
Date: Wed, 21 Jan 2004 11:54:41 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-01-21 at 12:28 +0100, Lukasz Trabinski wrote:
> On Wed, 21 Jan 2004, Marcelo Tosatti wrote:
> > Thanks Lukasz,
> > 
> > Great, Sir Woodhouse is investingating this. The traces look pretty odd.
> > 
> > Can you put the vmlinux file for that kernel up on the net, too?
> 
> http://lukasz.eu.org/vmlinux

Thanks. The fault is happening in the list_del() at line 301 of
fs/inode.c; the penultimate line of __refile_inode(). It seems 
that inode->i_list.prev is an invalid pointer, which caused it to oops
while holding the inode_lock.

At least, it _should_ have oopsed -- the call trace shows it's gone
through die() and do_exit(). I don't understand why you didn't get
anything on the console.

Neither do I understand why i_list.prev is corrupt. Not seeing the oops
and knowing what it actually was doesn't help. Rik?

-- 
dwmw2


