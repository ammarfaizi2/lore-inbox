Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932092AbWGAXer@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbWGAXer (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 19:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932109AbWGAXer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 19:34:47 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:17145 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932092AbWGAXeq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 19:34:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FXq/PbhrlgKizGv8VsJKnja0um5YRIJSNRlSEBy5iR0OmzcyWHfBJwnyA0fuznycuK1Vjmmz3jsjqABzEgYdy7sp8eOvGfORisZ3QI71iE5jlhR4dXJvEYY8Psopq6N2bVZPo2n1LembDsnXTfDWF0XDtvjfXQd14XQuz93rkuI=
Message-ID: <a44ae5cd0607011634q35855478j12e84e77850461a7@mail.gmail.com>
Date: Sat, 1 Jul 2006 16:34:37 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: "Sam Ravnborg" <sam@ravnborg.org>
Subject: Re: 2.6.17-mm5 -- Busted toolchain? -- usr/klibc/exec_l.c:59: undefined reference to `__stack_chk_fail'
Cc: "Arjan van de Ven" <arjan@infradead.org>, "Andrew Morton" <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20060701230635.GA19114@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <a44ae5cd0607011409m720dd23dvf178a133c2060b6d@mail.gmail.com>
	 <1151788673.3195.58.camel@laptopd505.fenrus.org>
	 <a44ae5cd0607011425n18266b02s81b3d87988895555@mail.gmail.com>
	 <1151789342.3195.60.camel@laptopd505.fenrus.org>
	 <a44ae5cd0607011537o1cf00545td19e568dcb9c06c1@mail.gmail.com>
	 <a44ae5cd0607011556t65b22b06m317baa9a47ff962@mail.gmail.com>
	 <20060701230635.GA19114@mars.ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/1/06, Sam Ravnborg <sam@ravnborg.org> wrote:
>  >> > > >
> > >> > > >   KLIBCLD usr/klibc/libc.so
> > >> > > > usr/klibc/execl.o: In function `execl':
> ...
>  >
> > >https://wiki.ubuntu.com/GccSsp
> > >
> > >It appears that Ubuntu's Edgy Eft (the development tree) now contains
> > >"Stack Smashing Protection" enabled by default.  I found a web page
> > >that states that -fno-stack-protector can be used to disable this
> > >functionality.  Interestingly, another web page stated that SSP has
> > >been enabled in Redhat compilers for a long time and is now also
> > >enabled in Debian SID.  Perhaps -fno-stack-protector should be added
> > >to the kernel build be default?
> >
> > Darn it.  I don't seem to know how to get -fno-stack-protector to
> > work.  I ran:
> > export CFLAGS=-fno-stack-protector
> > make mrproper
> > cp ../.config .
> > make oldconfig
> > CFLAGS=-fno-stack-protector make all install modules modules_install
> >
> > But I am still getting the errors.  Anyone know what I am doing wrong?
>
> For klibc you need to patch scripts/Kbuild.klibc
>
> Appending it to KLIBCWARNFLAGS seems the right place.
>
> Do you know from what gcc version we can start using -fno-stack-protector?

This fixed is for me.  Andrew, would this be appropriate to merge into
your tree?

--- scripts/Kbuild.klibc.old    2006-07-01 16:32:55.000000000 -0700
+++ scripts/Kbuild.klibc        2006-07-01 16:28:59.000000000 -0700
@@ -51,7 +51,7 @@
 KLIBCREQFLAGS     :=
 KLIBCARCHREQFLAGS :=
 KLIBCOPTFLAGS     :=
-KLIBCWARNFLAGS    := -W -Wall -Wno-sign-compare -Wno-unused-parameter
+KLIBCWARNFLAGS    := -W -Wall -Wno-sign-compare -Wno-unused-parameter
-fno-stack-protector
 KLIBCSHAREDFLAGS  :=
 KLIBCBITSIZE      :=
 KLIBCLDFLAGS      :=
