Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261842AbSKLQFN>; Tue, 12 Nov 2002 11:05:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266589AbSKLQFN>; Tue, 12 Nov 2002 11:05:13 -0500
Received: from x101-201-88-dhcp.reshalls.umn.edu ([128.101.201.88]:29319 "EHLO
	arashi.yi.org") by vger.kernel.org with ESMTP id <S261842AbSKLQFM>;
	Tue, 12 Nov 2002 11:05:12 -0500
Date: Tue, 12 Nov 2002 10:12:01 -0600
From: Matt Reppert <arashi@arashi.yi.org>
To: Adam Voigt <adam@cryptocomm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: File Limit in Kernel?
Message-Id: <20021112101201.0c86bf3a.arashi@arashi.yi.org>
In-Reply-To: <1037115535.1439.5.camel@beowulf.cryptocomm.com>
References: <1037115535.1439.5.camel@beowulf.cryptocomm.com>
Organization: Yomerashi
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-message-flag: : This mail sent from host minerva, please respond.
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 Nov 2002 10:38:55 -0500
Adam Voigt <adam@cryptocomm.com> wrote:

> I have a directory with 39,000 files in it, and I'm trying to use the cp
> command to copy them into another directory, and neither the cp or the
> mv command will work, they both same "argument list too long" when I
> use: cp -f * /usr/local/www/images
> 
> Is this a kernel limitation?

Yes, but you can get around it in userspace. See
http://www.linuxjournal.com/article.php?sid=6060

(Short answer is this from include/linux/binfmts.h.:
/*
 * MAX_ARG_PAGES defines the number of pages allocated for arguments
 * and envelope for the new program. 32 should suffice, this gives
 * a maximum env+arg of 128kB w/4KB pages!
 */
#define MAX_ARG_PAGES 32

I'm assuming your arch has 4kb pages, so the 'problem' is that you're
passing more than 128kb of cmdline arguments.)

> If yes, how can I get around it?

The article has a bunch of ways. You don't really need to change
the kernel though ... if you don't mind generating 39000 new processes
one after the other, I'd do something like 'for FILE in * ; do mv $FILE
/usr/local/www/images ; done'. Probably slower than calling mv once due
to process overhead done 39000 times, but it *works*, and it's simple.
(If you use a csh instead of something bash-like, change that to fit.)

Matt
