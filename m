Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262020AbUCVPA1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 10:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262027AbUCVPA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 10:00:27 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:60898 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S262020AbUCVPA0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 10:00:26 -0500
Message-Id: <200403221500.i2MF0EI7003024@eeyore.valparaiso.cl>
To: rudi@lambda-computing.de
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: File change notification (enhanced dnotify) 
In-Reply-To: Your message of "Mon, 22 Mar 2004 12:18:15 +0100."
             <405ECB77.9080803@gamemakers.de> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 14)
Date: Mon, 22 Mar 2004 11:00:14 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

=?ISO-8859-1?Q?R=FCdiger_Klaehn?= <rudi@gamemakers.de> said:
> Horst von Brand wrote:
> > =?ISO-8859-1?Q?R=FCdiger_Klaehn?= <rudi@gamemakers.de> said:
> >>I am working on a mechanism to let programs watch for file system 
> >>changes in large directory trees or on the whole system. Since my last 
> >>post in january I have been trying various approaches.

> > How do you propose to handle the fact that there are changes to _files_,
> > which happen to be pointed to by entries in directories? There is no
> > "change in the directory tree" in Unix...

> Of course it is files that change. But as you say each file is pointed 
> to by one or more dentry, so I use the dentry hierarchy to propagate the 
> information about the change. Just like the old dnotify.

dentries just keep the path travelled by hard links to get to the file in
memory for fast future access. So if you have, say:

   dir1  dir2
    |     |
    .     .
    .     .
    .     .
     \   /
    somefile

and you referenced somefile by the path through dir1, if you monitor dir2
you won't notice the change. There is no on-disk data to trace back through
all the directories that reference the file, and reading all of the
filesystem's metadata to find this out is ludicrous (ever seen fsck(8)
taking an hour or so to make much the same?).
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
