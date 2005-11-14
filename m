Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932109AbVKNU1E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbVKNU1E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 15:27:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932110AbVKNU1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 15:27:04 -0500
Received: from dslsmtp.struer.net ([62.242.36.21]:47887 "EHLO
	dslsmtp.struer.net") by vger.kernel.org with ESMTP id S932109AbVKNU1D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 15:27:03 -0500
Message-ID: <32830.194.237.142.10.1132000020.squirrel@194.237.142.10>
In-Reply-To: <1131948242.3168.19.camel@localhost.localdomain>
References: <1131948242.3168.19.camel@localhost.localdomain>
Date: Mon, 14 Nov 2005 21:27:00 +0100 (CET)
Subject: Re: prob with 2.6 Makefile
From: "Sam Ravnborg" <sam@ravnborg.org>
To: sapna@neoaccel.com
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sapna.
> I have a few doubs with the 2.6 makefile
> Suppose I have the following dir structure:
> 		maindir
> 		    |
> 		-------
> 		|       |
> 	       subdir1 subdir2
>
> Now both of this subdirs have many .c files which are to be compiled and
> linked together to make final1.o & final2.o files in the subdirs
> subdir1  & subdir2 respectively.
>
> Now i want to link this two files subdir1/final1.o & subdir2/final2.o ,
> in the maindir to make file say final.o file in maindir .

I suppose we are here discussing an external project where you want to
build a single module.

kbuild (and the kbuild syntax) is optimized for the pattern seen most
often in the kernel. And only in very rare cases we have a module split
over more than one directory. In the nomal cases everything are kept
together.
fs/xfs is one example where we do split up the source code in several dirs.

So there are only two possibilities:
1) Do like the rest of the kernel and keep the files in one dir
2) Specify all .o files in the top-level kbuild (Makefile) file.
Like this:
obj-m := module.o
module-y := subdir1/foo.o
module-y += subdir1/bar.o
module-y += subdir2/fooo.o
module-y += subdir2/baro.o

   Sam

