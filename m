Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129886AbQKIXJO>; Thu, 9 Nov 2000 18:09:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130006AbQKIXJE>; Thu, 9 Nov 2000 18:09:04 -0500
Received: from [213.8.184.211] ([213.8.184.211]:30724 "EHLO callisto.yi.org")
	by vger.kernel.org with ESMTP id <S129886AbQKIXIx>;
	Thu, 9 Nov 2000 18:08:53 -0500
Date: Fri, 10 Nov 2000 01:08:25 +0200 (IST)
From: Dan Aloni <karrde@callisto.yi.org>
To: Ivan Passos <lists@cyclades.com>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Patch generation
In-Reply-To: <Pine.LNX.4.10.10011091442570.26422-100000@main.cyclades.com>
Message-ID: <Pine.LNX.4.21.0011100051190.31850-100000@callisto.yi.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Nov 2000, Ivan Passos wrote:

> Where in the src tree can I find (or what is) the command to generate a
> patch file from two Linux kernel src trees, one being the original and the
> other being the newly changed one??

The syntex looks like this one:

diff -urN old_tree new_tree > your_patch_file
 
> I've tried 'diff -ruN', but that does diff's on several files that could
> stay out of the comparison (such as the files in include/config, .files,
> etc.).

You can use the --exclude switch of diff, or make mrproper before you
diff, or you can cp -al a clean source tree before you build the kernel
on top of it.

Another way, is to use *one* source tree, copying the files you change -
adding them the '.orig' extention to their name.

Then you run this script (I got it when Riel pasted it on IRC)

for i in `find ./ -name \*.orig` ; do diff -u $i `dirname $i`/`basename $i  
.orig` ; done

About the other method: cp -al is fast, creating a copy of tree without
taking much diskspace, it copies the tree by hard linking the files. 

BTW, 'patch' unlinks files before modifing so you can have lots of kernel
trees from different releases with little diskspace waste:

[karrde@callisto ~/usr/src/kernel/work]$ ls -1
linux-2.4.0-test10
linux-2.4.0-test10.build
linux-2.4.0-test11-pre1
linux-2.4.0-test6

I did 'cp -al linux-2.4.0-test10 linux-2.4.0-test10.build', and on
linux-2.4.0-test10.build I did 'make bzImage' and all the rest.

When Linus releasd test11-pre1 I did 'cp -al' from test10 to test11-pre1
and patched the test11-pre1 dir with the patch Linus released. the test10
dir remained intact.

[karrde@callisto ~/usr/src/kernel/work]$ du . -s
193004  .

4 kernel trees, one after make dep ; make bzImage, and all taking together
just 193MB, instead of about 400MB... hard links, gotta love'em.
 
-- 
Dan Aloni 
dax@karrde.org

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
