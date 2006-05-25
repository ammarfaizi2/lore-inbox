Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965039AbWEYFEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965039AbWEYFEm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 01:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965040AbWEYFEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 01:04:41 -0400
Received: from wr-out-0506.google.com ([64.233.184.239]:26068 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965039AbWEYFEl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 01:04:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=acucWf559bsGBElsJr0AbAcvfkCe4iEVWvE/GZyjUfKyNSrxft60pIPFfjm3JfSRqiCyPx2jdinadWSJcqgQHfK6S1FoJItFmhGNASwCaK7mBvO7ycQ/ev6p9FeP38ktMAntPabdMYrv+a7bRbxlES9U8dCEZsQ8oIbS3VHsDT0=
Message-ID: <844f6ea60605242204l278ef688s2119158153b30697@mail.gmail.com>
Date: Thu, 25 May 2006 10:34:40 +0530
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



-- 
Regards,
Kashyap
