Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130320AbRBZQab>; Mon, 26 Feb 2001 11:30:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130323AbRBZQaW>; Mon, 26 Feb 2001 11:30:22 -0500
Received: from nuvol.uji.es ([150.128.16.10]:63250 "HELO nuvol.uji.es")
	by vger.kernel.org with SMTP id <S130320AbRBZQaJ>;
	Mon, 26 Feb 2001 11:30:09 -0500
Message-ID: <3A9A8489.224CF54C@inf.uji.es>
Date: Mon, 26 Feb 2001 17:30:01 +0100
From: David <dllorens@lsi.uji.es>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-3smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Posible bug in gcc
Content-Type: multipart/mixed;
 boundary="------------CACF4A28F3327438DFF13325"
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------CACF4A28F3327438DFF13325
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I hope you will find this information usefull.

I am not in the linux-kernel list so, if posible, I would like to be
personally CC'ed the answers/comments sent to the list in response to
this posting.

I think I heve found a bug in gcc. I have tried both egcs 1.1.2 (gcc
2.91.66) and gcc 2.95.2 versions.

I am attaching you a simplified test program ('bug.c', a really simple
program).

To generate the faulty program from correct code compile as:
  gcc -O2 -o bug bug.c

You can generate good code in two ways:
1. Compiling with:
  gcc -fno-strength-reduce -O2 -o bug bug.c

   So the problem is with the option -fstrength-reduce which is 
   active with the common '-O2' optimization option.

2. Uncomment the printf at line 34. Bugs are surprising.

I have also sent the bug report to the gcc maintainers.

Is it really a bug?

Thank you,

David Llorens.
--------------CACF4A28F3327438DFF13325
Content-Type: text/plain; charset=us-ascii;
 name="bug.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bug.c"

/* 
#include <stdio.h>
*/

#define SMALL_N  2
#define NUM_ELEM 4

int main(void)
{
  int listElem[NUM_ELEM]={30,2,10,5};
  int listSmall[SMALL_N];
  int i, j;
  int posGreatest=-1, greatest=-1;

  for (i=0; i<SMALL_N; i++) { 
    listSmall[i] = listElem[i];
    if (listElem[i] > greatest) {
      posGreatest = i;
      greatest = listElem[i];
    }
  }
  
  for (i=SMALL_N; i<NUM_ELEM; i++) { 
    if (listElem[i] < greatest) {
      listSmall[posGreatest] = listElem[i];
      posGreatest = 0;
      greatest = listSmall[0];
      for (j=1; j<SMALL_N; j++) 
	if (listSmall[j] > greatest) {
	  posGreatest = j;
	  greatest = listSmall[j];
	}
      /*
      printf("%d\n", posGreatest);
      */
    }
  }
 
  printf("Correct output: 5 2\n");
  printf("GCC output: ");
  for (i=0; i<SMALL_N; i++) printf(" %.1d", listSmall[i]);
  printf("\n");
  return (1);
}


--------------CACF4A28F3327438DFF13325--

