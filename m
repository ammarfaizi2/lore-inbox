Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262140AbULCJ6b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262140AbULCJ6b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 04:58:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262139AbULCJ6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 04:58:31 -0500
Received: from rproxy.gmail.com ([64.233.170.193]:18962 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262140AbULCJ6F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 04:58:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=eNvDGttdX+ILPMM9W4nhBl0xGWv0qYu1deXofzFURnOdBZ06VItcRGHnSaBSpXhrQBFn5E2sDG57Q9X2qGS4C9YqpMzftjplh436vHnwEAHMf5JO2doQJ/dEV8DOEmKjcn4shZD6h3xYxpVEBcZcKaiZHF7HNzb1nfaALSEZPss=
Message-ID: <2c59f003041203015823ea859d@mail.gmail.com>
Date: Fri, 3 Dec 2004 15:28:05 +0530
From: Amit Gud <amitgud1@gmail.com>
Reply-To: Amit Gud <amitgud1@gmail.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: file as a directory
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.53.0411301935240.9193@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200411292120.iATLKZxE004233@laptop11.inf.utfsm.cl>
	 <1101832103.2885.4.camel@zathras.emsl.pnl.gov>
	 <Pine.LNX.4.53.0411301740430.1622@yvahk01.tjqt.qr>
	 <04113011354200.08643@tabby>
	 <Pine.LNX.4.53.0411301844100.16712@yvahk01.tjqt.qr>
	 <2c59f00304113010262063d219@mail.gmail.com>
	 <Pine.LNX.4.53.0411301935240.9193@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Nov 2004 19:39:15 +0100 (MET), Jan Engelhardt
<jengelh@linux01.gwdg.de> wrote:
> >My suggestion is to add a framework, an infrastructure, in the VFS
> >wherein a simple plugin can be written to poke into the file as if it
> >were a directory. So with that framework in place, I can write a
> >plugin for archive support (treating the .tar files as directories),
> >Peter could write a plugin for poking into /etc/passwd (treating it as
> >a directory), and Jon Doe could write a plugin for sendmail.cf
>
> That's something I could live with, but how do you want to tag a file being
> "tar" so that tar_ops is used instead of the "default file" ops?
>
> You could not do so without an extra function, and once you use that extra
> function to tag a certain file being "tar"

Yes an extra function, or few lines in vfs_readdir().

> -- you know that extensions are
> kinda "worthless", and, especially, unrealiable -- you could also have used tar
> -tvf.

I don't see how "worthless" is viewing certain files as directories.
It is worth to do 'vi /root/abc.tar.gz/README' to edit a file than to
inflate it yourself, make changes and deflate it again..deleting the
stuff inflated. And its on code's part to make it as reliable as
possible.

> Did I mention tar is not the perfect format? It's because it is lacking an
> index and letting the kernel wade through a GB-sized tar file just to perform
> and readdir (yet imagine reading the last file of it) would be a hell of
> skipping. Keeping a non-persistent index in memory may solve the problem, but
> hey, I also do not want to spend too much memory just for a single tar file.

There lies a problem with tar formats. So the tar plugin writer should
take this into account. But I see no problem with, for example,
/etc/passwd as a directory. tar is just one possible (and probably
debatable) plugin that can be introduced with the help of this
framework.


AG
--
May the source be with you.
