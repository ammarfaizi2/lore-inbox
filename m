Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132568AbRDOGBy>; Sun, 15 Apr 2001 02:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132576AbRDOGBf>; Sun, 15 Apr 2001 02:01:35 -0400
Received: from fe6.rdc-kc.rr.com ([24.94.163.53]:64778 "EHLO mail6.cinci.com")
	by vger.kernel.org with ESMTP id <S132568AbRDOGBa>;
	Sun, 15 Apr 2001 02:01:30 -0400
Message-ID: <004201c0c571$9c477940$0201a8c0@zed>
From: "Matt Billenstein" <mbillens@mbillens.dyndns.org>
To: <joeja@mindspring.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <3AD78A6C.F0F3CF5A@mindspring.com>
Subject: Re: bug in float on Pentium
Date: Sun, 15 Apr 2001 02:02:04 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's not that you found a new bug or that floats are inaccurate (they are
just less exact than doubles)...  For example, if you make your program
print some more digits, you'll get:

5483.98999999999978172127157449722290039062500000000000
5483.99023437500000000000000000000000000000000000000000

#include <stdio.h>

int main() {

    unsigned int *X;
    unsigned int *Y;

 double x = 5483.99;
 float  y = 5483.99;

    X = (unsigned int *)&x;
    Y = (unsigned int *)&y;

 printf ("%60.50lf\n%60.50f\n", x, y);

 printf("%lf %x%x %f %x\n", x, X[1], X[0], y, *Y);
 return 0;
}

which you can verify by hand:

5483.990000 40b56bfd70a3d70a
0 10000001011 1.0101 0110 1011 1111 1101 0111 0000 1010 0011 1101 0111 0000
1010
+    2^12   * 1.3388647460937499467092948179925 =
5483.989999999999781721271574497222900390625

5483.990234 45ab5fec
0 10001011  1.010 1011 0101 1111 1110 1100
+   2^12  * 1.338864803314208984375 = 5489.990234375

check out:
http://www.psc.edu/general/software/packages/ieee/ieee.html

l8r

m


Matt Billenstein
mbillens (at) one (dot) net
http://w3.one.net/~mbillens/


----- Original Message -----
From: "Joe" <joeja@mindspring.com>
To: <linux-kernel@vger.kernel.org>
Sent: Friday, April 13, 2001 7:23 PM
Subject: bug in float on Pentium


| Not sure but I think I found a NEW bug.
|
| I know that there have been some issues with pentiums and floating point
| arrithmatic, but this takes the cake...
|
| Linux Lserver.org 2.2.18 #43 SMP Fri Mar 9 14:19:41 EST 2001 i586
| unknown
|
| >kgcc --version
| egcs-2.91.66
|
| RH 6.2.x / 7.0
|
| try this program
|
| #include <stdio.h>
|
| int main() {
|
|     char tmpx[100];
|  char tmpy[100];
|
|  double x = 5483.99;
|  float y = 5483.99;
|
|     sprintf (tmpx, "%f",x );
|     sprintf (tmpy, "%f",y );
|
|  printf ("%s\n%s\n", tmpx, tmpy);
|  return 0;
| }
|
|
| I am getting the following as output
|
| joeja@Lserver$ ./testf
| 5483.990000
| 5483.990234
|
|
| what is with the .990234??  it should be .990000
|
| any ideas on this??
|
| --
| Joe Acosta ........
| home: joeja@mindspring.com
|
|
|
| -
| To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html
| Please read the FAQ at  http://www.tux.org/lkml/

