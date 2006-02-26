Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751391AbWBZSpx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbWBZSpx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 13:45:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbWBZSpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 13:45:53 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:15337 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751391AbWBZSpw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 13:45:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=D+eW9YEDgev6BfZcoynMPmAmoKNprGmUAw3Awhwx6RQRuEjnPcinRe6ONoFR7FwHLY+6w9Hh4stO13ATZamqXGjsrkGfHXJtyV929GLdESX++WLf9Y6ZzrXoWJxTTeqLFbf7wFxjxpPXuX3+VxXxQtdImS1e+0J3jdzY6H1iKOA=
Message-ID: <9a8748490602261045q6553b849lac7d8b209a905635@mail.gmail.com>
Date: Sun, 26 Feb 2006 19:45:52 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Diego Calleja" <diegocg@gmail.com>
Subject: Re: Building 100 kernels; we suck at dependencies and drown in warnings
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, sam@ravnborg.org
In-Reply-To: <20060226192140.4951f5a0.diegocg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <200602261721.17373.jesper.juhl@gmail.com>
	 <20060226192140.4951f5a0.diegocg@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/26/06, Diego Calleja <diegocg@gmail.com> wrote:
> El Sun, 26 Feb 2006 17:21:17 +0100,
> Jesper Juhl <jesper.juhl@gmail.com> escribió:
>
>
> >       95 kernels were build with 'make randconfig'.
> >       1 kernel was build with the config I normally use for my own box.
> >       1 kernel was build from 'make defconfig'.
> >       1 kernel was build from 'make allmodconfig'.
> >       1 kernel was build from 'make allnoconfig'.
> >       1 kernel was build from 'make allyesconfig'.
>
>
> I wonder if it'd be useful a "make compiletest" which developers
> are told to run before submitting changes - a target that would compile

As a general thing? No, I don't think so. When you've made a change
you generally want to compile test a very specific part of the kernel
(the one containing your change), not the entire kernel.

> a kernel with allyesconfig, another with allnoconfig, allmodconfig
> and a couple of randconfig, with the time it could improve this
> kind of errors.
>
> (I tried to do it myself but I don't know swahili well enought to
> hack Makefiles)
>
No need to hack makefiles, for example, all I did to build my 100
kernels was this simple shell script that I then left to run for a few
hours :


#!/bin/bash

make clean
zcat /proc/config.gz > .config
make oldconfig
cp .config normal.config
make -j 5 2>&1 | tee normal.log

make clean
make defconfig
cp .config def.config
make -j 5 2>&1 | tee def.log

make clean
make allmodconfig
cp .config allmod.config
make -j 5 2>&1 | tee allmod.log

make clean
make allnoconfig
cp .config allno.config
make -j 5 2>&1 | tee allno.log

make clean
make allyesconfig
cp .config allyes.config
make -j 5 2>&1 | tee allyes.log

for i in `seq 1 95`; do make clean ; make randconfig ; cp .config
rand$i.config ; make -j 5 2>&1 | tee rand$i.log ; done


no tricky Makefile hackery there, just a little shell scripting magic.


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
