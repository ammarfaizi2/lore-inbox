Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261857AbULaEGx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbULaEGx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 23:06:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261858AbULaEGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 23:06:53 -0500
Received: from out014pub.verizon.net ([206.46.170.46]:3821 "EHLO
	out014.verizon.net") by vger.kernel.org with ESMTP id S261857AbULaEGq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 23:06:46 -0500
Message-ID: <41D4D069.3020300@verizon.net>
Date: Thu, 30 Dec 2004 23:07:05 -0500
From: Jim Nelson <james4765@verizon.net>
Reply-To: james4765@gmail.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Coywolf Qi Hunt <coywolf@gmail.com>
CC: Jesper Juhl <juhl-lkml@dif.dk>, David Howells <dhowells@redhat.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: printk loglevel policy?
References: <Pine.LNX.4.61.0412310259230.4725@dragon.hygekrogen.localhost> <2cd57c9004123018203b7e38ef@mail.gmail.com>
In-Reply-To: <2cd57c9004123018203b7e38ef@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out014.verizon.net from [209.158.220.243] at Thu, 30 Dec 2004 22:06:44 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Coywolf Qi Hunt wrote:
> Hi all, 
> 
> Recently, I've seen a lot of add loglevel to printk patches. 
> grep 'printk("' -r | wc shows me 2433. There are probably 2433 printk
> need to patch, is it?  What's this printk loglevel policy, all these
> printk calls need loglevel adjusted?  The default loglevel is
> KERN_WARNING.
> 
> 
> --coywolf

Not every printk() needs a loglevel.  For example:

	printk (KERN_WARN "blah...");

	some stuff...

	printk ("bleh...");

	more stuff...

	printk ("done\n");

is used in a lot of areas.

You'll also see:
#ifdef VERBOSE_DEBUG
#define FOO_DEBUG(a, b) printk ("%s: %s\n", a, b)
#else
#define FOO_DEBUG(a, b)
#endif

which is normally only used for debug builds.

The logging levels are, for the most part, common sense.  KERN_ERR for error 
conditions, KERN_INFO for informational (i. e. "driver just loaded", "new disk 
detected"), KERN_CRIT if your computer just caught on fire (!), and KERN_DEBUG for 
any kind of verbose printing.

