Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263663AbTJRAGz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 20:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263665AbTJRAGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 20:06:55 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:39393 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S263663AbTJRAGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 20:06:53 -0400
Subject: Re: unsafe printk
From: Albert Cahalan <albert@users.sf.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20031017095240.GB7738@elf.ucw.cz>
References: <1066354577.15921.111.camel@cube>
	 <20031017095240.GB7738@elf.ucw.cz>
Content-Type: text/plain
Organization: 
Message-Id: <1066434774.15920.217.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 17 Oct 2003 19:52:55 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-10-17 at 05:52, Pavel Machek wrote:
> Hi!
> 
> > Suppose I name an executable this:
> > "\n<0>Oops: EIP=0"
> > 
> > That comes out as a KERN_EMERG log message,
> > hitting the console and maybe a pager even.
> > 
> > There seem to be a number of places in the
> > kernel that printk current->comm without
> > concern for what it may contain.
> > 
> > Escape codes and non-ASCII can make for some
> > interesting log messages as well. Terminals
> > may have some programmable keys or answerback
> > messages. So one day root is using grep on
> > the log files, and they program the answerback
> > string to contain a "\r\nrm -r /\r\n"...
> 
> Or at least you can make his terminal pink ;-). Unfortunately same
> problem is with userland programs; root does ps and his terminal goes
> pink. Sanitizing kernel messages would be good start, but ps&friends
> and ls&friends need to be sanitized, too.

Both ps and ls are protected. At least with the
procps-3.1.xx code, w and top are also protected.

So anyway, what to do about the kernel messages?
One option is to just mangle comm up front. Another
option is to provide a formatting function for
safe printing.


