Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267085AbTA0Acu>; Sun, 26 Jan 2003 19:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267089AbTA0Acu>; Sun, 26 Jan 2003 19:32:50 -0500
Received: from gen3-newburypark5-192.vnnyca.adelphia.net ([207.175.226.192]:762
	"EHLO dave.home") by vger.kernel.org with ESMTP id <S267085AbTA0Act>;
	Sun, 26 Jan 2003 19:32:49 -0500
Date: Sun, 26 Jan 2003 16:42:10 -0800
From: David Ashley <dash@xdr.com>
Message-Id: <200301270042.h0R0gAd00829@dave.home>
To: aebr@win.tue.nl
Subject: Re: Serious filesystem bug in linux [nevermind]
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Sun, Jan 26, 2003 at 03:18:49PM -0800, David Ashley wrote:
>
>> -rw-r--r--    1 root     root     1965107636224 Jan 26 14:59 output1.iso
>
>You know about the Unix concept of files with holes?

No, but I can look into it. There is definitely some bug in my program
but I wouldn't expect this behaviour. So if I seek way the hell out
to nowhere, do a write, I'll have a file of the total amount I've skipped
over?

I just wrote a test program and it did exactly this. Thanks!

Here is the program
#define _LARGEFILE64_SOURCE
#include <fcntl.h>
#include <unistd.h>

main()
{
int fd;
char buff[32];
	fd=open("/tmp/crazybigfile",O_RDWR|O_CREAT|O_TRUNC|O_LARGEFILE,0644);
	lseek64(fd,1000000000000ll,SEEK_SET);
	write(fd,buff,32);
	close(fd);

}

Live and learn. Sorry for the alarm!

-Dave
