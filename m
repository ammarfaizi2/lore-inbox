Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269288AbRGaMsL>; Tue, 31 Jul 2001 08:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269287AbRGaMsD>; Tue, 31 Jul 2001 08:48:03 -0400
Received: from lila.inti.gov.ar ([200.10.161.32]:9096 "EHLO lila.inti.gov.ar")
	by vger.kernel.org with ESMTP id <S269290AbRGaMry>;
	Tue, 31 Jul 2001 08:47:54 -0400
Message-ID: <3B66A90D.789A90A8@inti.gov.ar>
Date: Tue, 31 Jul 2001 09:48:13 -0300
From: salvador <salvador@inti.gov.ar>
Reply-To: salvador@inti.gov.ar
Organization: INTI
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19 i686)
X-Accept-Language: es-AR, en, es
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: [RFC] Get selection to buffer addition
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi all:

What I'm looking for:
  I'm looking for comments and approval for a small addition to the console
driver (drivers/char/console.c).

Small description:
  The included patches adds a couple of new services to the TIOCLINUX ioctl
call, they are:

13 (get selection into a buffer): It copies the contents of the selection
buffer (maintained in kernel space) into a user space provided buffer. Is
something like "paste to a buffer"  instead of just paste to the current
console.

14 (get selection length): Returns the length of the selection buffer (0 if
none selected).
-----------

The included file (compressed and uuencoded) contains diffs that apply
without offsets into 2.4.7 kernel, they are valid for 2.2.18 too (with
offset).
I also include a simple test program that calls the new services. The test
program is really simple and assumes you can open /dev/tty1 (you are
there or you are root ;-)

Additional question: Why the switch uses numbers? Shouldn't these values be
defined as something like TIOCLINUX_GET_SELECTION in a header?

What's the purpose? Just allow pasting in text editors using menues or
without the mouse middle button and avoiding to missinterpret the pasted
text as keystrokes.

SET

begin 664 patchConsole-2.4.7.txt.gz
M'XL("/K,83L"`W!A=&-H0V]N<V]L92TR+C0N-RYT>'0`E57?C]HX$'Z&OV*D
MOA!"0F!9V++M'JM3M^VINH?>MB_5*0K)D%@--N<?['+5_N\W=K*0](+:(@*Q
M/?.-9[[/GB`(H&3</`;3<!8N0B%9/LXDVZ-4X[1(Y#@57(D2P[1W;Q#^,!PF
M4YA<+B<+^L(TBB9]W_>;(&?]"T/^)4SG0,X7%\O9O/)?K2"8S$9S\.GW"E:K
M/L#0/O"[V!T@X1GL$J41-H:GF@D.ZP/<\DSB`[Q+#B5J/7+F`$IL$9`7"4]Q
MBUPK9UJB4H0B!7PT:\99V/>==8X:%)98@3*N!22P-IL-2A>U1)[K@B!J>_OY
M*RGW228DO`GA7HH=)O!*U7,K@F!A+O9A(F\:260(!)T6F'Z%#;EFS(:@[<&>
M92B"-)&9@JU0NCS8#;]-*#*\,[S.ZU4>%#18(89&)T6(F;EQ59M.(U<W^I^/
M)I$K7:_7DZB-Y!!=VU&:*"3.EKWQT"6\R>.:$QB.F^:GA>N^_^QW<?0[5R@"
M\4\@9!D?+>/*9)#(W&M@SCHPZU*WP79&QT810!NULAUX(Q@8KEC.,;-[@J$W
M&%C-T0M%!!\FGF=+\$1/C1B\>?_GY]L/-/O4#WZH_6-(4N^=9'"':X"7,)DO
M+Z+E=/H3ZF\BM/5_V=;_].K*$4E_LTG%8X-%RJ#OC^OSH`L$(DH[>8N-&Y\*
M6;-2<>1T:RL(:I>D6"]6\G_/]^(K58[TQD2JRX'GYHD`6\M.'JT\-!QK7@J>
M@^6V[W\CVJK29ZBTY;K%3,68G:8\>FP#CE%';;74065%H6+_HM@X6CWZ6'4<
MJ;R[_?3AWH&"A;61X34\2Z`#X#1L!O.<-NM]U3J\L16MTXY+7;C`]=KK[]8:
MWJ<%#VQ)W&1*I,5:5.G:38X:`*.Z-E5J';D]`99T:+ZU-A"Y%7KB^'A&_E](
MQ\^92EJ`D\!\PG(">TN'LE-/%?J/E-/BL//0[@7+:KW4X4^U@-^^JRPLCYN#
ML8U+>>I?T#^MN/OS'X/4NVI3K:FE*"52EFC:Z0.C.`[22'<E/S<LY]F5:N>]
MP7A:F@S';J%Q[`MW<;AC']F+@X[]Y;S[XC@/T;XY9M$R6C0ZY\)USD7=.?%1
MHW1WM"MF*9*L-/KLT;UN>6P%22F6N!-2,YY7;)U,[+!E,U!:FE3;FL;UZ]`.
M1@YM;:@Q5[CR\?GE8*77"/E+%\W)]2>51GOOPXL,-XQCU6QC;K;4YTJSY:HW
FV*>NYWVQY-N7O\,LN'&3I?*Z/(D<5+WSCE(\D.-_G[[YF5<)````
`
end
-------------------------------------------
Test program:

#include <stdio.h>
#include <sys/ioctl.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>

int main(int argc, char *argv[])
{
 int i,res,fd,largo;
 char buffer[sizeof(unsigned int)+2],*s;
 unsigned int *lg=(unsigned int *)(buffer+1);

 fd=open("/dev/tty1",O_RDWR);

 printf("Finding the length of the selection:\n");
 buffer[0]=14;
 res=ioctl(fd,TIOCLINUX,&buffer);
 printf("The iotcl returns %d\n",res);
 printf("Length: %u\n",*lg);
 largo=*lg;
 if (*lg==0) return 0;

 printf("Asking for the selection:\n");
 s=(char *)malloc(largo+sizeof(unsigned int)+2);
 s[0]=13;
 lg=(unsigned int *)(s+1);
 *lg=largo;
 res=ioctl(fd,TIOCLINUX,s);
 printf("The iotcl returns %d\n",res);
 largo=*lg;
 printf("Length returned: %d\n",largo);
 s+=1+sizeof(unsigned int);
 s[largo]=0;

 for (i=0; s[i]; i++)
     if (s[i]==13) s[i]=10;
 printf("Selection: '%s' (%d)\n",s,s[0]);
 return 0;
}


--
Salvador Eduardo Tropea (SET). (Electronics Engineer)
Visit my home page: http://welcome.to/SetSoft or
http://www.geocities.com/SiliconValley/Vista/6552/
Alternative e-mail: set-soft@bigfoot.com set@computer.org
                    set@ieee.org
Address: Curapaligue 2124, Caseros, 3 de Febrero
Buenos Aires, (1678), ARGENTINA Phone: +(5411) 4759 0013



