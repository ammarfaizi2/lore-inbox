Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315204AbSFXTlH>; Mon, 24 Jun 2002 15:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315207AbSFXTlG>; Mon, 24 Jun 2002 15:41:06 -0400
Received: from chaos.analogic.com ([204.178.40.224]:50310 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S315204AbSFXTk6>; Mon, 24 Jun 2002 15:40:58 -0400
Date: Mon, 24 Jun 2002 15:44:02 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "Salvatore D'Angelo" <dangelo.sasaman@tiscalinet.it>
cc: Chris McDonald <chris@cs.uwa.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: gettimeofday problem
In-Reply-To: <3D16F252.90309@tiscalinet.it>
Message-ID: <Pine.LNX.3.95.1020624153816.15499A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jun 2002, Salvatore D'Angelo wrote:

> In this piece of code I convert seconds and microseconds in 
> milliseconds. I think the problem is not in my code, in fact I wrote the 
> following piece of code in Java, and it does not work too. In the for 
> loop the 90% of times b > a while for 10% of times not.
> 
>     class Prova {
>           public static void main(....) {
>                for (;;) {
>                     long a = System.currentTimeMillis();
>                     long b = System.currentTimeMillis();
> 
>                     if (a > b) {
>                          System.out.println("Wrong!!!!!!!!!!!!!");
>                     }
>                }
>           }
>     }
> 
> 

This has been running since I first read your mail about 10:00 this
morning. The kernel is 2.4.18

#include <stdio.h>
#include <sys/time.h>
#define MICRO 1000000
#define ULL unsigned long long
int main(void);
static ULL tim(void);

static ULL tim()
{
    struct timeval t;
    (void)gettimeofday(&t, NULL);
    return (ULL)t.tv_sec * MICRO + (ULL)t.tv_usec;
}
int main()
{
    ULL a, b, cnt;
    for(cnt=0;;cnt++)
    {
        a = tim();
        b = tim();
        if(b < a)
            break;
    }
    printf("Failed after %llu\n", cnt);
    printf("a = %llu, b = %llu\n", a, b);
    return 0;
}

It seems to work fine. That said, I didn't use your code or check
for the possibility of a sign-change miscompare. I just made sure
I don't have any by using unsigned stuff. You may want to try
this code to see if you have a compiler (or coding) problem.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

