Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263648AbTIHUHb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 16:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263649AbTIHUHb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 16:07:31 -0400
Received: from natsmtp01.webmailer.de ([192.67.198.81]:42150 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S263648AbTIHUHX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 16:07:23 -0400
Message-ID: <3F5CE1C1.5010801@softhome.net>
Date: Mon, 08 Sep 2003 22:08:33 +0200
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: nasm over gas?
References: <tt0q.6Rc.17@gated-at.bofh.it> <tt0r.6Rc.19@gated-at.bofh.it> <tt0r.6Rc.21@gated-at.bofh.it> <tt0r.6Rc.23@gated-at.bofh.it> <tt0r.6Rc.25@gated-at.bofh.it> <tt0q.6Rc.15@gated-at.bofh.it> <tyCN.6RD.13@gated-at.bofh.it>
In-Reply-To: <tyCN.6RD.13@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> On Mon, Sep 08, 2003 at 02:03:21PM +0200, Ihar 'Philips' Filipau wrote:
> 
>>  e.g. C-- project: something like C, where you can operate with 
>>registers just like another variables. Under DOS was producing .com 
>>files witout any overhead: program with only 'int main() { return 0; }' 
>>was optimized to one byte 'ret' ;-) But sure it was not complete C 
>>implementation.
> 
> 
> There is already a C-- project and it is unrelated to your suggestion.
> 
> c.f. http://cminusminus.org/
> 

   Actually I have tryed to find the project I knew long time ago.
   But let say - it was pre internet era.

   I beleive C-- was distributed as a shareware. I cannot be sure about 
licensing - I come from USSR ;-)

   [ ...removing the dust of time from my archives... ]

   [ ...@#$%^&* it is archived with arj - VMware... ]

   [ Wow - it has name! Sphinx C-- - and Google has some docs on-line 
http://www.goosee.com/cmm/c--doc.htm (go directly to 
http://www.goosee.com/cmm/c--doc.htm#Expressions) ]
   [ Home page is http://www.goosee.com/cmm/ ]

    Sample from my archive follows.
    Watch the comment "RUN FILE SIZE" - 457 bytes. Far from ideal - but 
already 'very good'.

/*
    NAME: FIRE.C--
    INFO: Written by Midnight.
          Conversion to C-- (and a little palette messing) by SPHINX.
    DESCRIPTION: This program displays a fire like simulation on a
                 VGA 320x200 256 colour screen.
    RUN FILE SIZE: 457 bytes.
*/

?use80386
?resize FALSE
?assumeDSSS TRUE

?include "VIDEO.H--"
?include "VGA.H--"
?include "RANDOM.H--"
?include "KEYCODES.H--"

byte palette[768];

// byte pic = FROM "c--.cut";

word F;
word LowLimit;


void SetCols ()
byte N;
{

/*
BX = 0;
do {
     SI = BX+BX+BX;
     palette[SI] = BL >> 2;
     palette[SI+1] = BL >> 3;
     palette[SI+2] = 0;
     BX++;
     } while( BX < 256 );
*/


palette[0]=0;
palette[1]=0;
palette[2]=0;
BX = 0;
do {
     DI = BX+BX+BX;

     AX = BX * 64 / 85;
     DL = AL;
     palette[DI+3] = DL;
     palette[DI+3+1] = 0;
     palette[DI+3+2] = 0;

     palette[DI+3+85+85+85] = 63;
     palette[DI+3+85+85+85+1] = DL;
     palette[DI+3+85+85+85+2] = 0;

     palette[DI+3+85+85+85+85+85+85] = 63;
     palette[DI+3+85+85+85+85+85+85+1] = 63;
     palette[DI+3+85+85+85+85+85+85+2] = DL;

     BX++;
     } while( BX < 85 );


SETVGAPALETTE( ,0,256,#palette);
}



void AddFire (word N)
{
loop(N)
     {
     AX = RAND()%10+1;
     SI = AX+AX;
     AX = RAND()%298 + 64010;
     DI = AX;
     AL = RAND()&127 + 128;
     loop(SI)
	{
	ESBYTE[DI] = AL;
	ESBYTE[DI+640] = AL;
	DI++;
	}
     }
}


void CopyAvg ()
{
DI = 1280;
do {
     BX = 2;
     do {
	AX = ESBYTE[DI+BX-2] +  ESBYTE[DI+BX+2] + ESBYTE[DI+BX] +
		  ESBYTE[DI+BX+640] / 4;
	AX = AX + ESBYTE[DI+BX-640] >> 1;
	IF( AL > 128 )
	    AL-=2;
	ELSE IF( AL > 3)
	    AL -=4;
	ELSE
	    AL = 0;

	AH = AL;
	ESWORD[DI+BX-1280] = AX;
	ESWORD[DI+BX-1280+320] = AX;
	BX += 2;
	} while( BX < 318 );
     DI += 640;
     } while( DI < 320*204 );
}



void main ()
{
@ SETVIDEOMODE(byte vid_320x200_256);

SetCols();

ES = 0xA000;

F = 0;
do {
     AddFire(F / 32 + 1);
     CopyAvg();
     IF( F < 512 )
	F++;
     LowLimit = F >> 2 + 128 >> 2;
//    IF( F % 80 == 0 )
//        overimage19(80,90,#pic,0);
     } while( BIOSKEYCHECK() == 0 );

do {BIOSREADKEY();
     } while( BIOSKEYCHECK() != 0 );

@ SETVIDEOMODE(byte vid_text80c);
}


/* end of FIRE.C-- */

