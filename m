Return-Path: <linux-kernel-owner+w=401wt.eu-S1751532AbXAVKqU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751532AbXAVKqU (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 05:46:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751561AbXAVKqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 05:46:20 -0500
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:46070 "EHLO
	relay01.mail-hub.dodo.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751532AbXAVKqT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 05:46:19 -0500
From: Grant Coady <grant_lkml@dodo.com.au>
To: Willy Tarreau <w@1wt.eu>
Cc: Santiago Garcia Mantinan <manty@debian.org>,
       Grant Coady <gcoady.lk@gmail.com>, dann frazier <dannf@dannf.org>,
       linux-kernel@vger.kernel.org, debian-kernel@lists.debian.org
Subject: Re: problems with latest smbfs changes on 2.4.34 and security backports
Date: Mon, 22 Jan 2007 21:46:14 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: Grant Coady <gcoady.lk@gmail.com>
Message-ID: <dv39r2pr5piq27lbou66jg963tqg3f3ahj@4ax.com>
References: <20070117100030.GA11251@clandestino.aytolacoruna.es> <20070117215519.GX24090@1wt.eu> <20070119010040.GR16053@colo> <20070120010544.GY26210@colo> <t1r7r2thimh3gpuhtfc9l3aehjdd6dqkp8@4ax.com> <20070121230321.GC2480@1wt.eu> <20070122085400.GA16302@clandestino.aytolacoruna.es> <20070122091816.GA5144@1wt.eu>
In-Reply-To: <20070122091816.GA5144@1wt.eu>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jan 2007 10:18:16 +0100, Willy Tarreau <w@1wt.eu> wrote:

>Grant, just to be sure, are you really certain that you tried the fixed kernel ?
>It is possible that you booted a wrong kernel during one of your tests. I'm
>intrigued by the fact that it changed nothing for you and that it fixed the
>problem for Santiago.

Closest I get to Santiago's results are with the 2.4.33.7 plus the patch, 
with 'use default NLS' option turned on, as well as the unix extensions.

2.4.34 was a no go for me.  Changing the default NLS made no difference, 
now trying with unix extensions turned on. . .  Yeah, that works, apart 
from the test file gaining execute bits, compared to operation under 
2.4.33.3, this is 2.4.34 + patch + default NLS and unix extensions:

grant@sempro:/home/other$ cat dirlink/filelink
this is a test
grant@sempro:/home/other$ echo "this is a test" > testfile
grant@sempro:/home/other$ ls -l
total 4096
drwxr-xr-x 1 grant wheel  0 2007-01-21 11:44 dir/
lrwxr-xr-x 1 grant wheel  3 2007-01-21 11:43 dirlink -> dir/
-rwxr-xr-x 1 grant wheel 15 2007-01-21 11:43 file*
lrwxr-xr-x 1 grant wheel  4 2007-01-21 11:44 filelink -> file*
drwxr-xr-x 1 grant wheel  0 2007-01-22 10:45 test/
-rwxr-xr-x 1 grant wheel 15 2007-01-22 21:31 testfile*
lrwxr-xr-x 1 grant wheel  4 2007-01-22 21:29 testlink -> test/
grant@sempro:/home/other$ ln -s testfile testfilelink
grant@sempro:/home/other$ cat testfilelink
this is a test


The fix depends on the smbfs configuration?  Is this the requirement?
I ask as the other mode of operation (unix extensions turned off): do 
not display symlinks, prevent creation of symlinks, seems to be logically 
self-consistent, as well as matching what I see from a 'doze box.

Grant.
