Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131693AbRARPzD>; Thu, 18 Jan 2001 10:55:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132255AbRARPyx>; Thu, 18 Jan 2001 10:54:53 -0500
Received: from w240.z209220232.was-dc.dsl.cnc.net ([209.220.232.240]:4357 "EHLO
	yendi.dmeyer.net") by vger.kernel.org with ESMTP id <S131693AbRARPyg>;
	Thu, 18 Jan 2001 10:54:36 -0500
Date: Thu, 18 Jan 2001 10:54:31 -0500
From: dmeyer@dmeyer.net
To: linux-kernel@vger.kernel.org
Subject: Re: Documenting stat(2)
Message-ID: <20010118105430.A4461@jhereg.dmeyer.net>
Reply-To: dmeyer@dmeyer.net
In-Reply-To: <20010118020528.A16871@jhereg.dmeyer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
X-Newsgroups: local.linux.kernel
In-Reply-To: <3A66D93C.8090500@AnteFacto.com>
Organization: dmeyer.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3A66D93C.8090500@AnteFacto.com> you write:
> Nope stat should return the details of the symlink
> whereas lstat should return the details of the symlink target.

Not according to my manpages.  From stat(2):

       stat stats the file pointed to by file_name and  fills  in
       buf.

       lstat  is  identical  to  stat,  only  the  link itself is
       stated, not the file  that  is  obtained  by  tracing  the
       links.

Actually, the Solaris manpage is clearer:

     The lstat() function  obtains  file  attributes  similar  to
     stat(),  except  when  the named file is a symbolic link; in
     that case lstat() returns information about the link,  while
     stat()  returns  information  about the file the link refer-
     ences.

and a short test program:

#include <stdio.h>
#include <sys/stat.h>
#include <unistd.h>

main()
{
	struct stat buf;

	stat("stattest.c",&buf);
	printf("stat original file: %d\n",buf.st_size);

	symlink("stattest.c","a_symlink");

	stat("a_symlink",&buf);
	printf("stat symlink: %d\n",buf.st_size);

	lstat("a_symlink",&buf);
	printf("lstat symlink: %d\n",buf.st_size);
}

jhereg|dmeyer|~/dl> ./stattest
stat original file: 358
stat symlink: 358
lstat symlink: 10

stat clearly is giving the size of the target, and lstat the size of
the link.

-- 
David M. Meyer
dmeyer@dmeyer.net
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
