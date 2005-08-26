Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030256AbVHZUSy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030256AbVHZUSy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 16:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030257AbVHZUSy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 16:18:54 -0400
Received: from leviathan.ele.uri.edu ([131.128.51.64]:43411 "EHLO
	leviathan.ele.uri.edu") by vger.kernel.org with ESMTP
	id S1030256AbVHZUSx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 16:18:53 -0400
Subject: Re: very weired random io behavior
From: Ming Zhang <mingz@ele.uri.edu>
Reply-To: mingz@ele.uri.edu
To: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1125086927.5549.121.camel@localhost.localdomain>
References: <1125086927.5549.121.camel@localhost.localdomain>
Content-Type: text/plain
Organization: no-dole-available
Date: Fri, 26 Aug 2005 16:18:48 -0400
Message-Id: <1125087528.5549.123.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sorry. my dumb.

here is not 
x = (rand() >> 1) << 1;
but
x = (rand() >> 10) << 10;

file is in bytes while lba is in sector. ;P

ming



On Fri, 2005-08-26 at 16:08 -0400, Ming Zhang wrote:

> ---------------------------------------------------
> #define _LARGEFILE64_SOURCE
> 
> #include <stdlib.h>
> #include <sys/types.h>
> #include <unistd.h>
> #include <fcntl.h>
> #include <sys/types.h>
> #include <sys/stat.h>
> 
> int main(int argc, char *argv[])
> {
>         int n;
>         int i, count;
>         char *name;
>         char buf[4096];
>         int fd;
> 
>         if (argc != 3) {
>                 printf("%s name count\n", argv[0]);
>                 exit(1);
>         }
>         name = argv[1];
>         count = atoi(argv[2]);
> 
>         fd = open(name, O_CREAT|O_WRONLY, S_IRWXU);
>         for (i = 0; i < count; i++) {
>                 unsigned long x;
> 
>                 x = (rand() >> 1) << 1;
>                 lseek64(fd, x, SEEK_SET);
>                 write(fd, buf, 4096);
>         }
>         printf("done\n");
>         close(fd);
>         return 0;
> }
> 

