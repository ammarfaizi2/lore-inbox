Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964973AbWEYE3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964973AbWEYE3J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 00:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964990AbWEYE3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 00:29:09 -0400
Received: from wr-out-0506.google.com ([64.233.184.229]:48310 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964973AbWEYE3I convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 00:29:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=GPoL36V43D3pbKkSbCZlsn1wpvlIwB+XGDdB14D0phaH0Sdz4B99Vx8O7LVycWS5BxU3R0L6DyceBvFp9jTQE38+3479CgyhMx/w/0jVRQvN9yZgLcaXbt5m1At73l9Z4uk74Jw75OVGCUAYhCbYwsEZpLUu/G/lIUqmFkJkL0A=
Message-ID: <844f6ea60605242129k2887f28l9357b2ce707bdf26@mail.gmail.com>
Date: Thu, 25 May 2006 09:59:07 +0530
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
