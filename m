Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262188AbVAECI6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262188AbVAECI6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 21:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262196AbVAECI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 21:08:58 -0500
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:28112 "EHLO
	mail-in-09.arcor-online.net") by vger.kernel.org with ESMTP
	id S262188AbVAECIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 21:08:18 -0500
Date: Wed, 5 Jan 2005 03:12:50 +0100 (CET)
From: Bodo Eggert <7eggert@gmx.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Valdis.Kletnieks@vt.edu, 7eggert@gmx.de,
       Andy Lutomirski <luto@myrealbox.com>, linux-kernel@vger.kernel.org
Subject: Re: the umount() saga for regular linux desktop users
In-Reply-To: <1104870524.8346.27.camel@krustophenia.net>
Message-ID: <Pine.LNX.4.58.0501050257500.10470@be1.lrz>
References: <fa.iji5lco.m6nrs@ifi.uio.no> <fa.fv0gsro.143iuho@ifi.uio.no> 
 <E1Cl509-0000TI-00@be1.7eggert.dyndns.org>  <200501022243.j02MhANg004075@turing-police.cc.vt.edu>
 <1104870524.8346.27.camel@krustophenia.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Aplologies for the indirect reply, I didn't see the cited message yet)

> On Sun, 2005-01-02 at 17:43 -0500, Valdis.Kletnieks@vt.edu wrote:
> > On Sun, 02 Jan 2005 13:38:29 +0100, Bodo Eggert said:
> > 
> > > Maybe it's possible to extend the semantics of umount -l to change all
> > > cwds under that mountpoint to be deleted directories which will no
> > > longer cause the mountpoint to be busy (e.g. by redirecting them to a
> > > special inode on initramfs). Most applications can cope with that (if
> > > not, they're buggy),
> > 
> > You mean that a program is *buggy* if it does:
> > 
> > 	cwd("/home/user");
> > 	/* do some stuff while we get our cwd ripped out from under us */
> > 	file = open("./.mycconfrc");
> > 
> > and expects the file to be opened in /home/user???

If the user was bad, the user directory *will* just vanish ("what was your
login, please"), and any other directory may vanish, too:

$ mkdir /tmp/test;cd /tmp/test
$ ls -la
total 0
drwx------    2 7eggert  users          40 2005-01-05 03:00 .
drwx------    3 7eggert  users          60 2005-01-05 03:00 ..
$ # /tmp/test gets removed here
$ ls -la
total 0
$ echo foo>bar
-bash: bar: No such file or directory
$
