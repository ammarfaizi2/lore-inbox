Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261907AbUKCVkm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261907AbUKCVkm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 16:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261897AbUKCVYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 16:24:18 -0500
Received: from mail2.speakeasy.net ([216.254.0.202]:12763 "EHLO
	mail2.speakeasy.net") by vger.kernel.org with ESMTP id S261898AbUKCVTp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 16:19:45 -0500
Date: Wed, 3 Nov 2004 13:19:41 -0800 (PST)
From: vlobanov <vlobanov@speakeasy.net>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
cc: linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL PATCH] /init/version.c
In-Reply-To: <200411032311.21820.vda@port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.58.0411031317020.20083@shell2.speakeasy.net>
References: <Pine.LNX.4.58.0411022359001.17128@shell2.speakeasy.net>
 <200411031229.31412.vda@port.imtp.ilyichevsk.odessa.ua>
 <Pine.LNX.4.58.0411030828560.4892@shell1.speakeasy.net>
 <200411032311.21820.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gotcha. Thanks.

I'll redo it correctly a bit later, with
	const char msg[]; and extern char msg[];
instead of
	const char * msg; and extern char * msg;

-Vadim Lobanov

On Wed, 3 Nov 2004, Denis Vlasenko wrote:

> On Wednesday 03 November 2004 18:34, vlobanov wrote:
> > It seems to compile just fine. Here are the relevant snippets:
> >
> >   UPD     include/asm-i386/asm_offsets.h
> >   CC      init/main.o
> >   CHK     include/linux/compile.h
> >   UPD     include/linux/compile.h
> >   CC      init/version.o
> >   CC      init/do_mounts.o
> >
> > ...and...
> >
> >   CC      fs/proc/proc_tty.o
> >   CC      fs/proc/proc_misc.o
> >   CC      fs/proc/kcore.o
> >
> > Why did you believe it would not compile? (Just so I can be extra
> > careful about this kind of code in the future.)
>
> I was wrong. It compiles but won't work right:
>
> a.c:
> char msg[] = "boo";
>
> b.c:
> #include <stdio.h>
> extern char *msg;
> int main() {
> 	puts(msg);
> 	return 0;
> }
>
> # gcc b.c a.c
> # ./a.out
> Segmentation fault
>
> --
> vda
>
>
