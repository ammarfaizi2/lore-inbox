Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262251AbUK3SnV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262251AbUK3SnV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 13:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262249AbUK3Smj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 13:42:39 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:32921 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262254AbUK3SjU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 13:39:20 -0500
Date: Tue, 30 Nov 2004 19:39:15 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Amit Gud <amitgud1@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: file as a directory
In-Reply-To: <2c59f00304113010262063d219@mail.gmail.com>
Message-ID: <Pine.LNX.4.53.0411301935240.9193@yvahk01.tjqt.qr>
References: <200411292120.iATLKZxE004233@laptop11.inf.utfsm.cl> 
 <1101832103.2885.4.camel@zathras.emsl.pnl.gov>  <Pine.LNX.4.53.0411301740430.1622@yvahk01.tjqt.qr>
  <04113011354200.08643@tabby>  <Pine.LNX.4.53.0411301844100.16712@yvahk01.tjqt.qr>
 <2c59f00304113010262063d219@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>My suggestion is to add a framework, an infrastructure, in the VFS
>wherein a simple plugin can be written to poke into the file as if it
>were a directory. So with that framework in place, I can write a
>plugin for archive support (treating the .tar files as directories),
>Peter could write a plugin for poking into /etc/passwd (treating it as
>a directory), and Jon Doe could write a plugin for sendmail.cf

That's something I could live with, but how do you want to tag a file being
"tar" so that tar_ops is used instead of the "default file" ops?

You could not do so without an extra function, and once you use that extra
function to tag a certain file being "tar" -- you know that extensions are
kinda "worthless", and, especially, unrealiable -- you could also have used tar
-tvf.

Did I mention tar is not the perfect format? It's because it is lacking an
index and letting the kernel wade through a GB-sized tar file just to perform
and readdir (yet imagine reading the last file of it) would be a hell of
skipping. Keeping a non-persistent index in memory may solve the problem, but
hey, I also do not want to spend too much memory just for a single tar file.

>struct file_operations ops = {
>   .read            = tar_readdir,
>   .readdir        = tar_readdir,
>   ......
>};
>
>register_file_type("tar", &ops);




Jan Engelhardt
-- 
ENOSPC

