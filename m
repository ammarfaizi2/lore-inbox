Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315787AbSENPoL>; Tue, 14 May 2002 11:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315788AbSENPoI>; Tue, 14 May 2002 11:44:08 -0400
Received: from chaos.analogic.com ([204.178.40.224]:29312 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S315787AbSENPoB>; Tue, 14 May 2002 11:44:01 -0400
Date: Tue, 14 May 2002 11:44:44 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: File open/create attibutes.
Message-ID: <Pine.LNX.3.95.1020514113724.2711A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

If a file exists with attributes, 0644, and it is opened with truncate
and create with different attributes, it doesn't get those attributes.
It's only if the file doesn't exist at all that it gets created with
the new attributes.

I think this is a bug. According to my reading, O_CREAT opens the file
with the specified attributes. If the file exists, its data remains
unless O_TRUNC is set.

The following program clearly shows the problem:


#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
int main(void);
char fname[]="/tmp/foo";
int main()
{
    int fd;
    (void)unlink(fname);
    if((fd = open(fname, O_WRONLY|O_CREAT|O_TRUNC, 0644)) == -1)
    {
        fprintf(stderr, "Can't create file %s\n", fname);
        exit(EXIT_FAILURE);
    }
    (void)close(fd);
    (void)system("ls -la /tmp/foo");
    if((fd = open(fname, O_WRONLY|O_CREAT|O_TRUNC, 0744)) == -1)
    {
        fprintf(stderr, "Can't create file %s\n", fname);
        exit(EXIT_FAILURE);
    }
    (void)close(fd);
    (void)system("ls -la /tmp/foo");
    (void)unlink(fname);
    if((fd = open(fname, O_WRONLY|O_CREAT|O_TRUNC, 0744)) == -1)
    {
        fprintf(stderr, "Can't create file %s\n", fname);
        exit(EXIT_FAILURE);
    }
    (void)system("ls -la /tmp/foo");
    (void)unlink(fname);
    return 0;
}


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

