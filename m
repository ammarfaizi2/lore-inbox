Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291477AbSBSQth>; Tue, 19 Feb 2002 11:49:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291492AbSBSQtS>; Tue, 19 Feb 2002 11:49:18 -0500
Received: from chaos.analogic.com ([204.178.40.224]:54914 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S291477AbSBSQtO>; Tue, 19 Feb 2002 11:49:14 -0500
Date: Tue, 19 Feb 2002 11:51:25 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Jakob Kemi <jakob.kemi@telia.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hex <-> int conversion routines.
In-Reply-To: <02021915240900.00635@jakob>
Message-ID: <Pine.LNX.3.95.1020219114632.28797A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You might want this. Code generation is 0x34 bytes for Intel with
whatever compiler I'm using. It's generic. You could do the conversion
with no compares on intel, in 18 bytes using assembly, but that would
not be generic.


/*
 *  Generic routine which returns the value of an arbitrary string
 *  of hex digits. It handles 'A' thru 'F' as well as 'a' thru 'f'.
 *  Courtesy of rjohnson@analogic.com
 */
int hex2bin(const char *hex)
{
    int i, j;
    j = 0;
    while(*hex) {
        j <<= 4; 
        if((i = (int) *hex++ - '0') > 9)
            i -= 7;
        j |= i & 95;
    }
    return j;
}


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


