Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750990AbWJWAnS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990AbWJWAnS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 20:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751003AbWJWAnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 20:43:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:38054 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750990AbWJWAnQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 20:43:16 -0400
From: Andi Kleen <ak@suse.de>
To: Matthew Wilcox <matthew@wil.cx>
Subject: Re: dealing with excessive includes
Date: Mon, 23 Oct 2006 02:42:58 +0200
User-Agent: KMail/1.9.5
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Randy Dunlap <rdunlap@xenotime.net>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>,
       Al Viro <viro@ftp.linux.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       Alexey Dobriyan <adobriyan@gmail.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-arch@vger.kernel.org
References: <20061018091944.GA5343@martell.zuzino.mipt.ru> <Pine.LNX.4.62.0610221956380.29899@pademelon.sonytel.be> <20061023003111.GD25210@parisc-linux.org>
In-Reply-To: <20061023003111.GD25210@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610230242.58647.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> /*+
>  * Provides: struct sched
>  * Provides: total_forks, nr_threads, process_counts, nr_processes()
>  * Provides: nr_running(), nr_uninterruptible(), nr_active(), nr_iowait(), weighted_cpuload()
>  */

That's ugly.  If it needs that i don't think it's a good idea.
We really want standard C, not some Linux dialect.

In theory it is even to do it automated without comments
just based on the referenced symbols, except if stuff is hidden in macros 
(but then the include defining the macro should have the right includes
anyways). Another issue would be different name spaces - if there is both
typedef foo and struct foo and nested local foo a script might have a little trouble 
distingushing them, but i suspect that won't be a big issue.

-Andi


