Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273269AbRKVJ2J>; Thu, 22 Nov 2001 04:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273261AbRKVJ16>; Thu, 22 Nov 2001 04:27:58 -0500
Received: from mail1-gui.server.ntli.net ([194.168.222.13]:44753 "EHLO
	mail1-gui.server.ntli.net") by vger.kernel.org with ESMTP
	id <S273213AbRKVJ1p>; Thu, 22 Nov 2001 04:27:45 -0500
Date: Thu, 22 Nov 2001 09:27:42 GMT
From: ncw@axis.demon.co.uk
Message-Id: <200111220927.fAM9Rgv11663@irishsea.home.craig-wood.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Asm style
In-Reply-To: <3BFCF30E.4030605@debian.org>
In-Reply-To: <fa.d6k3juv.16q3on@ifi.uio.no> <fa.cbkkrrv.m72ejr@ifi.uio.no> <3BFCF30E.4030605@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giacomo Catenazzi wrote:
>  Ben Collins wrote:
> > There's also:
> > 
> > 	asm("\
> > 	cmd	r,r\n\
> > lbl:	cmd	r,r\n\
> > 	cmd	r,r\n" : spec : spec);
> > 
> > 
> > Or something similar (the trailing "\" added for continuation). Probably
> > the easiest way to patch existing asm.
>  
>  not ANSI C. The trailing \ is understood only in marco definitions
>  (and outside strings)

gcc begs to differ

/* z.c */
#include <stdio.h>

int main(void)
{
    printf("This is a string\n\
with continuation characters\n");
    return 0;
}

$ gcc -Wall -pedantic -ansi z.c -o z
[silence]

Remove the \ and you get

z.c:5: warning: string constant runs past end of line
z.c: In function `main':
z.c:5: warning: ANSI C forbids newline in string constant

You are correct in thinking it is something to do with pre-processor -
it deals with these continuation lines eg,

$ gcc -E -Wall -pedantic -ansi z.c

Gives
[snip stdio etc]
int main(void)
{
    printf("This is a string\nwith continuation characters\n");

    return 0;
}

-- 
Nick Craig-Wood
ncw@axis.demon.co.uk
