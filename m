Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265410AbTLHOf4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 09:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265417AbTLHOf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 09:35:56 -0500
Received: from scrat.hensema.net ([62.212.82.150]:60385 "EHLO
	scrat.hensema.net") by vger.kernel.org with ESMTP id S265410AbTLHOfz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 09:35:55 -0500
From: Erik Hensema <erik@hensema.net>
Subject: Re: incorrect inode count on reiserfs
Date: Mon, 8 Dec 2003 14:35:47 +0000 (UTC)
Message-ID: <slrnbt9322.27h.erik@bender.home.hensema.net>
References: <3FD47BFC.9020008@scssoft.com> <16340.33245.887082.96412@laputa.namesys.com>
Reply-To: erik@hensema.net
User-Agent: slrn/0.9.7.4 (Linux)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov (Nikita@Namesys.COM) wrote:
> Petr Sebor writes:
> > I have noticed this behavior when moving the inn2 news server to 
> > 2.6.0-test11 kernel
> > from 2.4.23
> > (inn2 refuses to start because if free inode shortage)

[...]

> reiserfs has no fixed predefined number of inodes on the file
> system. Hence, field f_files of struct statfs (see man 2 statfs) is not
> applicable to this file system. Man page explicitly says:
> 
>        Fields that are undefined for a particular file system are
>        set  to  0.
> 
> Previous man page stated that file system should put -1 (4294967295)
> into undefined fields. Reiserfs has been changed to conform to the
> changed specification.

[...]

> Fix would really be simple: ignore test results if ->f_files is 0 or
> 0xffffffff.

But innwatch checks for a out-of-inodes condition. How can it differentiate
between a undefined number of inodes (field set to 0) and a system that ran
out of inodes (field dropped to 0)?

A '4294967295 inodes should be enough for anyone'-situation is preferable I
think.

-- 
Erik Hensema <erik@hensema.net>
