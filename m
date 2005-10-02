Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750737AbVJBWUJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbVJBWUJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 18:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbVJBWUJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 18:20:09 -0400
Received: from zproxy.gmail.com ([64.233.162.194]:45031 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750737AbVJBWUH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 18:20:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=g9AGn6u8SftrBDmam1a05kWZ289sHSVkxoTBwFGDcRk+E/2rwU+MyMBIXBfI+YwKLFmaAsQ6EsqMYIgq7j4bzomXO00hVgrFsN0eG26HI4lkKSxS5Spfr1JSXcC4cFruqG8RS+QeAIAoTz4MlHTPo616cFOjcfgqZuQ7SMA6pU0=
Message-ID: <3e1162e60510021520t787e23e1nf74b5f2e6180a2e7@mail.gmail.com>
Date: Sun, 2 Oct 2005 15:20:06 -0700
From: David Leimbach <leimy2k@gmail.com>
Reply-To: David Leimbach <leimy2k@gmail.com>
To: jonathan@jonmasters.org
Subject: Re: Linux gains lossless filesystem
Cc: Tiesto Tijs <t.tijs@freemail.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <35fb2e590510021200m7f9be1bdk1033b39c46206e20@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <freemail.20050830202325.14420@fm02.freemail.hu>
	 <35fb2e590510021200m7f9be1bdk1033b39c46206e20@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/2/05, Jon Masters <jonmasters@gmail.com> wrote:
> On 9/30/05, Tiesto Tijs <t.tijs@freemail.hu> wrote:
>
> > i would like to know, what is your opinion about this
> > filesystem:
>
> > http://www.linuxdevices.com/news/NS9521569196.html
>
> Why wasn't it possible to make device mapper do what they wanted in
> combination with modifying the journalling behaviour of an existing
> fs?

I believe it may be possible, if it's not been done already, to use
the venti block archival system from Plan 9 [it's in userspace and has
been ported to linux] as well as the fossil filesystem [also in
userspace] to achieve a lossless file system configuration.  Also,
since it is served over 9P, it could be done for a remote filesystem
on a diskless node potentially.

What you end up with is a WORM device served up by Venti [which is
made efficient storagewise by coalescing like blocks and hashing them
with SHA1] and keeping a "current snapshot" served up over 9P using
Fossil.  That's how my Plan 9 box is currently configured anyway.

I think with v9fs and plan9ports you could configure something like
this though I don't know if anyone has done it yet.

If anyone is interested in how Venti scales here is a paper with
pretty graphs collecting the data of an almost 10 year usage period of
this technology at Bell Labs.
http://www.cs.bell-labs.com/sys/doc/venti/venti.html

Dave

>
> Jon.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
