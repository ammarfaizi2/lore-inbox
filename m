Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284800AbRLEXFS>; Wed, 5 Dec 2001 18:05:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284809AbRLEXFJ>; Wed, 5 Dec 2001 18:05:09 -0500
Received: from B91c7.pppool.de ([213.7.145.199]:20718 "HELO schottelius.org")
	by vger.kernel.org with SMTP id <S284808AbRLEXE4>;
	Wed, 5 Dec 2001 18:04:56 -0500
Message-ID: <3C0EA220.D943FAF6@pcsystems.de>
Date: Wed, 05 Dec 2001 23:39:28 +0100
From: Nico Schottelius <nicos@pcsystems.de>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13 i686)
X-Accept-Language: de-DE, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: memory/cpu handling problem ? (x86)
Content-Type: multipart/mixed;
 boundary="------------312746A5D1BD672F4F763AE4"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------312746A5D1BD672F4F763AE4
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello Folks!

A small ansi C program which tries to get all cpu power and as much ram
as possible got my system.

Background:
Discussing about NT and Linux with friends I decided to write a program
to demonstrate how the os reacts if one process tries to get the whole
system.

Please take a look into the attached program, before you continue
reading.

1, NT Test
System keeps on beeing stable, no new programs can be started.

2. Linux Test (1 process)
System hangs. No keyboard nor network conection is possible.
SysRq-Kill kills the process.

3.  Linux Test (3 processes)
Nothing to do anymore. System is blocked. SysRq still reports
what it does, but not even killall/SAK helps. s+u+b was the only
possible solution.

The program ran under a standard user id on both operating systems.
I was not able to ctrl+c/z the process under Linux.

Question: Isn't that some kind of security or at least DoS hole ?
Could not anybody with SSH / Telnet access to a server stop this
server running ?

Is it possible (via sysctl ?) to impede that ?

Please CC me when answering.


--
{Greetings,Gruss},
Nico Schottelius

I am some kind of busy -
Do not expect an answer within 24 hours.
Instead use the telephon: +49 (0) 173 - 750 7022.
--------------312746A5D1BD672F4F763AE4
Content-Type: text/plain; charset=us-ascii;
 name="ram_voll2.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ram_voll2.c"

/*******************************************************************************
 * Test what the OS does, if there is no ram and cpu left. 
 * Author: Nico Schottelius <nicos@pcsystems.de>
 * Date: 4th of July 2001
 * 
 *
 * 5th of Decembre 2001: 
 *  added initialization of the new allocated ram. Without this 'feature'
 *  Linux 2.4 has no problems. It is even possible to allocate 2000 MB RAM, 
 *  where only 128 MB is! (Linux gives you 'SoftRam'...)
 *
 ******************************************************************************/

#include <stdlib.h>
#include <stdio.h>

#define lint long int

lint add(lint last) {

	if(last == 0)
		return last;
	else if(last < 0)
		return -1;
	else
		return last + add(last -1);
}

int main ( void ) 
{

	char **uebervoll = NULL;
	int x = 1, a = 0; /* how many megs to allocate within one step */
	int one_k = 1024;
	int one_meg = one_k * 1024;
	lint i = 0;

         uebervoll = (char **) realloc(uebervoll, (i+1) * sizeof(char *) );

   for(i=0;;) {
      uebervoll = (char **) realloc(uebervoll, (i+1) * sizeof(char *));
      if(uebervoll != NULL) {
         uebervoll[i] = (char *) malloc(x * one_meg * sizeof(char) );
         /* init allocated ram */
         for(a=0;a<(x*one_meg*sizeof(char));a++) uebervoll[i][a] = 'a';
         if(uebervoll[i] != NULL) {
            i++;
            printf("%d MB RAM allocated\n",x * i);
         }
      }
   }
}


--------------312746A5D1BD672F4F763AE4--

