Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316135AbSEZOzO>; Sun, 26 May 2002 10:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316136AbSEZOzN>; Sun, 26 May 2002 10:55:13 -0400
Received: from mail7.svr.pol.co.uk ([195.92.193.21]:15620 "EHLO
	mail7.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S316135AbSEZOzM>; Sun, 26 May 2002 10:55:12 -0400
Posted-Date: Sun, 26 May 2002 13:53:38 GMT
Date: Sun, 26 May 2002 14:53:37 +0100 (BST)
From: Riley Williams <rhw@InfraDead.Org>
Reply-To: Riley Williams <rhw@InfraDead.Org>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.17 /dev/ports
In-Reply-To: <3CEBC496.9030900@evision-ventures.com>
Message-ID: <Pine.LNX.4.21.0205260915330.29968-100000@Consulate.UFP.CX>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin.

> #include <linux/io.h>
> #include <stdio.h>
> #include <stdlib.h>
> 
> int main(char *argv[], int argc)
> {
>	int port = aoit(argv[0]);
>	int byte = aoit(argv[1]);
>
>	if (port > 0)
>		return inb(port);		
>	else {
>		outb(port, byte);
>		return 0;
>	}
> }

Interesting code. Did you really mean to have the program name as the
port number, or should that be argv[1] and argv[2] instead? Also, what
is it supposed to do? A quick analysis makes no sense of it.

Would the following be what you had intended?

	#include <linux/io.h>
	#include <stdio.h>
	#include <stdlib.h>

	int main(int argc, char **argv) {
	    int byte, port, result = 0;

	    switch (argc) {
		case 2:
		    port = atoi(argv[1]);
		    result = inb(port);
		    break;

		case 3:
		    port = atoi(argv[1]);
		    byte = atoi(argv[2]);
		    outb(port, byte);
		    break;

		default:
		    fprintf(stderr, "Usage: %s port [byte]\n", argv[0]);
		    break;
	    }
	    return result;
	}

Best wishes from Riley.

