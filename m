Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133040AbRDUXQ6>; Sat, 21 Apr 2001 19:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133025AbRDUXQv>; Sat, 21 Apr 2001 19:16:51 -0400
Received: from fe050.worldonline.dk ([212.54.64.206]:26121 "HELO
	fe050.worldonline.dk") by vger.kernel.org with SMTP
	id <S133040AbRDUXQc>; Sat, 21 Apr 2001 19:16:32 -0400
Message-ID: <3AE2328A.10703@eisenstein.dk>
Date: Sun, 22 Apr 2001 03:23:22 +0200
From: Jesper Juhl <juhl@eisenstein.dk>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.17-mosix i586; en-US; m18) Gecko/20010131 Netscape6/6.01
X-Accept-Language: en, da
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] minor correctness fix to the Documentation/rtc.txt example program.
Content-Type: multipart/mixed;
 boundary="------------060903050608020008090107"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060903050608020008090107
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


-------- Original Message --------
Subject: [PATCH] minor correctness fix to the Documentation/rtc.txt 
example program.
Date: Sun, 22 Apr 2001 03:06:04 +0200
From: Jesper Juhl <juhl@eisenstein.dk>
To: p_gortmaker@yahoo.com
CC: linux-net@vger.kernel.org

Hi,

When compiling the example program from Documentation/rtc.txt there is a
tiny compiler warning about main() not returning int. That is no big
deal, but for the sake of correctness (and since main actually does
return a value on error) I have made a small patch to fix it (see below,
patch also attached as 'rtc.txt-patch').

The patch is pretty self explaining. It changes the return type of main
to int and adds a call to exit(0) at the end of main(), so now we have
killed the warning and return a meaningfull value on sucessfull completion.

The patch is against vanilla 2.4.3 and applies cleanly and the program
in rtc.txt compiles and runs without a problem after applying the patch.

I hope you like the patch and will apply it (comments and criticism is
welcome) :-)


-----[ Start of patch ]-----

--- linux-2.4.3-vanilla/Documentation/rtc.txt   Sun Apr 22 02:33:10 2001
+++ linux-2.4.3/Documentation/rtc.txt   Sun Apr 22 02:39:55 2001
@@ -89,7 +89,7 @@
   #include <unistd.h>
   #include <errno.h>

-void main(void) {
+int main(void) {

   int i, fd, retval, irqcount = 0;
   unsigned long tmp, data;
@@ -277,5 +277,6 @@
 
irqcount);

   close(fd);
+exit(0);

   } /* end main */

-----[ End of patch ]-----


Best regards,
Jesper Juhl - juhl@eisenstein.dk


--------------060903050608020008090107
Content-Type: text/plain;
 name="rtc.txt-patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rtc.txt-patch"

--- linux-2.4.3-vanilla/Documentation/rtc.txt	Sun Apr 22 02:33:10 2001
+++ linux-2.4.3/Documentation/rtc.txt	Sun Apr 22 02:39:55 2001
@@ -89,7 +89,7 @@
 #include <unistd.h>
 #include <errno.h>
 
-void main(void) {
+int main(void) {
 
 int i, fd, retval, irqcount = 0;
 unsigned long tmp, data;
@@ -277,5 +277,6 @@
 								 irqcount);
 
 close(fd);
+exit(0);
 
 } /* end main */


--------------060903050608020008090107--

