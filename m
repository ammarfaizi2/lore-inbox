Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269174AbTGJKXZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 06:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269176AbTGJKXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 06:23:25 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:58765 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S269174AbTGJKXQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 06:23:16 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16141.16899.777319.699253@laputa.namesys.com>
Date: Thu, 10 Jul 2003 14:37:55 +0400
To: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	<arvidjaar@mail.ru>
Cc: =?koi8-r?Q?=22?=Nikita Danilov=?koi8-r?Q?=22=20?= 
	<Nikita@Namesys.COM>,
       linux-kernel@vger.kernel.org
Subject: Re: Are =?koi8-r?Q?=22?=,=?koi8-r?Q?=22=20?=and =?koi8-r?Q?=22?=..=?koi8-r?Q?=22=20?=in directory required=?koi8-r?Q?=3F?=
In-Reply-To: <E19aYWH-00075R-00.arvidjaar-mail-ru@f25.mail.ru>
References: <16141.14720.980604.428130@laputa.namesys.com>
	<E19aYWH-00075R-00.arvidjaar-mail-ru@f25.mail.ru>
X-Mailer: ed | telnet under Fuzzball OS, emulated on Emacs 21.5  (beta14) "cassava" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Andrey Borzenkov"  writes:
 > 
 > 
 > -----Original Message-----
 > 
 > > 
 > > "Andrey Borzenkov"  writes:
 > >  > 
 > >  > Is it possible for readdir to return really empty directory - without
 > >  > and entry, even "." and ".."?
 > > 
 > > Enter empty directory. Remove it by rmdir() by another process. Now you
 > > have a directory without dot and dotdot.
 > > 
 > 
 > It is not quite the same.
 > 
 > bor@itsrm2% cd foo
 > bor@itsrm2% sudo rmdir /tmp/foo
 > bor@itsrm2% ls -la .
 > .: No such file or directory
 > 
 > how do I access this? OK I could have opendir on it ... but then,

You should access it through getcwd(2).  Try 'ls -al'. readdir has
special case for such directories (IS_DEADDIR), so it will come up as
empty without dot and dotdot.

 > directory contents is (mur be) still there just like with any
 > open unlinked file.

What actually remains in the directory is completely up to the file
system. File system may decide to remove dot and dotdot during rmdir, or
remove some of them, of leave everything to the final iput().

 > 
 > OK, not "possible to return" - it was wrong. Is it allowed? :)
 > 
 > -andrey

Nikita.
