Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317152AbSGXNe4>; Wed, 24 Jul 2002 09:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317142AbSGXNe4>; Wed, 24 Jul 2002 09:34:56 -0400
Received: from chaos.analogic.com ([204.178.40.224]:50560 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S317117AbSGXNew>; Wed, 24 Jul 2002 09:34:52 -0400
Date: Wed, 24 Jul 2002 09:37:51 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Per Gregers Bilse <bilse@qbfox.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.18 clock warps 4294 seconds
In-Reply-To: <200207241235.NAA01282@spirit.qbfox.com>
Message-ID: <Pine.LNX.3.95.1020724092843.8629A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jul 2002, Per Gregers Bilse wrote:

> [1.] System clock (as returned by eg time(2)) warps 4294 seconds
[SNIPPED...]

Do you have a time-daemon running that synchronizes your machine to
some other?

Run this program as:
./xxx &>xxx.log &

...and see if your machine is really jumping.

#include <stdio.h>
#include <time.h>


int main()
{
    time_t tim;
    time_t last;
    (void)time(&last);
    (void)time(&tim);
    for(;;)
    {
        (void)time(&tim);
        if(tim != last)
        {
            if((last +1) != tim)
            {
                fprintf(stderr,"Time = %08lx\n", tim);
                fprintf(stderr,"Last = %08lx\n", last);
            }
            last = tim;
        }
    }
}

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

