Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267381AbTGLCy2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 22:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267400AbTGLCy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 22:54:27 -0400
Received: from imf22aec.mail.bellsouth.net ([205.152.59.70]:35302 "EHLO
	imf22aec.bellsouth.net") by vger.kernel.org with ESMTP
	id S267381AbTGLCy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 22:54:26 -0400
From: "J.C. Wren" <jcwren@jcwren.com>
Reply-To: jcwren@jcwren.com
To: linux-kernel@vger.kernel.org
Subject: Bug in open() function (?)
Date: Fri, 11 Jul 2003 23:09:08 -0400
User-Agent: KMail/1.5.2
References: <20030712011716.GB4694@bouh.unh.edu> <16143.25800.785348.314274@cargo.ozlabs.ibm.com> <20030712024216.GA399@bouh.unh.edu>
In-Reply-To: <20030712024216.GA399@bouh.unh.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307112309.08542.jcwren@jcwren.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	I was playing around today and found that if an existing file is opened with 
O_TRUNC | O_RDONLY, the existing file is truncated.  This is contrary to the 
documentation for "man 2 open".  Which behavior is correct, the man page, or 
what actually happens?  Or wold this be considered a glibc/libc problem?  
This is on a stock 2.5.74 kernel.

	'man 2 open', on O_TRUNC: If  the  file already exists and is a regular file 
and the open mode allows writing (i.e., is O_RDWR or O_WRONLY) it will be 
truncated to length 0.

	--John

#include <stdio.h>
#include <fcntl.h>
#include <errno.h>
#include <string.h>
#include <sys/types.h>

int main (int argc, char **argv)
{
   int fd;

   if ((fd = open ("test", O_TRUNC | O_RDONLY)) == -1)
   {
      printf ("%d:%s\n", errno, strerror (errno));
      exit (1);
   }

   close (fd);

   exit (0);
}

[bash] cc test.c
[bash] ls -l >test
[bash] ls -l test
-rw-r--r--    1 jcw      users         195 Jul 11 23:06 test
[bash] ./a.out
[bash] ls -l test
-rw-r--r--    1 jcw      users           0 Jul 11 23:06 test

