Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261394AbVEWM5K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261394AbVEWM5K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 08:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261445AbVEWM5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 08:57:10 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:22290 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S261394AbVEWM5F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 08:57:05 -0400
To: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Cc: Miquel van Smoorenburg <miquels@cistron.nl>, linux-kernel@vger.kernel.org
Subject: Re: Thread and process dentifiers (CPU affinity, kill)
References: <428CD458.6010203@free.fr>
	<20050520125511.GC23488@csclub.uwaterloo.ca>
	<428DF95E.2070703@free.fr>
	<20050520165307.GG23488@csclub.uwaterloo.ca>
	<d6l9cs$l1t$1@news.cistron.nl>
	<20050520201255.GG23621@csclub.uwaterloo.ca>
From: Nix <nix@esperi.org.uk>
X-Emacs: if it payed rent for disk space, you'd be rich.
Date: Mon, 23 May 2005 13:56:57 +0100
In-Reply-To: <20050520201255.GG23621@csclub.uwaterloo.ca> (Lennart
 Sorensen's message of "20 May 2005 21:14:29 +0100")
Message-ID: <87ekbyf6cm.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 May 2005, Lennart Sorensen prattled cheerily:
> Maybe Debian compiled their glibc to not do NPTL on i386 yet.  Not sure.

This is not the case. Proof from ps -FT output:

mysql     8473  8473  8472  0 29110 14056  0 May22 pts/1  /usr/sbin/mysqld
mysql     8473  8475  8472  0 29110 14056  0 May22 pts/1  /usr/sbin/mysqld
mysql     8473  8476  8472  0 29110 14056  0 May22 pts/1  /usr/sbin/mysqld
mysql     8473  8477  8472  0 29110 14056  0 May22 pts/1  /usr/sbin/mysqld
mysql     8473  8478  8472  0 29110 14056  0 May22 pts/1  /usr/sbin/mysqld
mysql     8473  8479  8472  0 29110 14056  0 May22 pts/1  /usr/sbin/mysqld
mysql     8473  8480  8472  0 29110 14056  0 May22 pts/1  /usr/sbin/mysqld
mysql     8473  8481  8472  0 29110 14056  0 May22 pts/1  /usr/sbin/mysqld
mysql     8473  8482  8472  0 29110 14056  0 May22 pts/1  /usr/sbin/mysqld

> Hmm, after checking, it turns out if you use errno in your program, it
> drops to linuxthreads, while using #include <errno.h> makes it able to
> use NPTL when using 2.6 kernel.

This is a distribution-specific patch. glibc as shipped by the FSF simply
refuses to run programs that reference the errno symbol: errno is no
longer an exported symbol at all. (This is reasonable, as such programs
would fail to work on a multithreaded NPTL program in any case.)

The only valid way to gain access to the errno symbol is to
#include <errno.h>. This has been true for as long as glibc2 has existed.

-- 
`Once again, I must remark on the far-reaching extent of my
 ladylike nature.' --- Rosie Taylor
