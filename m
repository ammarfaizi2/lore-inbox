Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965043AbWEYFON@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965043AbWEYFON (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 01:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965044AbWEYFOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 01:14:12 -0400
Received: from wr-out-0506.google.com ([64.233.184.226]:44507 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965043AbWEYFOL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 01:14:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=XFQhfbvU+3KygbWWX2oiLuGfI0r2mbBUYJ8+bsLuIuiRBrX6VNc5A+SvEcgl+aRG8ES6D1o2+mHxvtSN5lAAj4pwNc8bj2o2L7z26p37peXuSY05FCEXhOaREDoWH0Da8CHV326dULmqTGnlzFYPPBOg/JcZXWiIyFqUugzrnVA=
Message-ID: <844f6ea60605242214s753f0b3ag8e1b7e21a0bc9ac9@mail.gmail.com>
Date: Thu, 25 May 2006 10:44:10 +0530
From: "C K Kashyap" <ckkashyap@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: help on using pseudo terminals - using /dev/ptmx
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I recently ran into trouble with pseudo terminals while trying to make
nxterm(microwindows or nano X) work.

Could someone please help me out with the program below...where I am
trying to do a two way communication between parent and child using
pseudo-terminal.

<code>
#include <pty.h>
#include <utmp.h>
#include <fcntl.h>
#include <stdio.h>


int main(){
 int amaster,aslave;
 char name[256];
 char buffer[20];



 openpty(&amaster,&aslave,name,NULL,NULL);
   fcntl (amaster, F_SETFL, O_NONBLOCK);
   fcntl (aslave, F_SETFL, O_NONBLOCK);



 printf("Master = %d, Slave = %d\n",amaster,aslave);
 printf("NAME %s\n",name);

 if(fork()==0){
   //login_tty(aslave);
   read(aslave,buffer,10);
   printf("Child: %s\n",buffer);
   write(aslave,"ABCDEFGHIJ\n",11);
   sleep(5);
   exit(0);

 }
 //  login_tty(amaster);
 write(amaster,"1234567890\n",11);
 read(amaster,buffer,10);
 printf("Parent: %s\n",buffer);

 sleep(5);
}
</code>
regards,
Kashyap
