Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262011AbVBANGP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262011AbVBANGP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 08:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262012AbVBANGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 08:06:15 -0500
Received: from bay15-f12.bay15.hotmail.com ([65.54.185.12]:5993 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S262011AbVBANGB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 08:06:01 -0500
Message-ID: <BAY15-F12673F8354333867F55E6CA47D0@phx.gbl>
X-Originating-IP: [128.243.74.2]
X-Originating-Email: [dav1dblunk3tt@hotmail.com]
From: "david blunkett" <dav1dblunk3tt@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: parport / ppdev problem
Date: Tue, 01 Feb 2005 13:05:24 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 01 Feb 2005 13:06:00.0759 (UTC) FILETIME=[C6F17C70:01C5085E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear List,

Since upgrading from k2.4 to k2.6 (2.6.5-1.358 and similar) my user space 
code that utilises the ppdev driver has been broken (code below).  I can 
confirm that this code still works under 2.4.

Under 2.6 the code compiles runs without error but there is no change in the 
output of the parport.  I cannot find any documentation that indicates a 
change and looking through the ppdev.c code I can't find any clues as to why 
it shouldn't work.

I do not know if this is a kernel or installation (k2.4 from rh9 vs k2.6 
from fedora 2)  issue but I have spent a long time looking for information 
and so far drawn a blank.

Anyone know anything that might help?

Thanks,

SA

working machine:
uname -a
Linux diesel.eee.nottingham.ac.uk 2.4.20-24.9 #1 Mon Dec 1 11:43:36 EST 2003 
i68                                                                          
    6 athlon i386 GNU/Linux
lsmod: ...parport                29640  3 ppdev,parport_pc,lp...

not working machine, eg:
uname -a
Linux rug.eee.nott.ac.uk 2.6.5-1.358 #1 Sat May 8 09:04:50 EDT 2004 i686 
athlon i386 GNU/Linux
lsmod: ...parport                29640  3 ppdev,parport_pc,lp...

user land code in both cases
//----------------------------------------------
int parport=0;
unsigned char parport_data=0;
void open_parport(char *);
void close_parport(void);
void parport_out(unsigned char);

main(){
int i;
        open_parport("/dev/parport0");
        printf("Counting up\n");
        for(i=0;i<255;i++){
                parport_out((unsigned char)i);
                usleep(10000);
                }
        close_parport();
        }

void open_parport(char * name){
        parport=open(name,O_RDWR);
        if(parport<0){
                printf("parport: fatal error cannot open \"%s\"\n",name);
                printf("Error number is %d\n",errno);
                perror("open_parport: error");
                exit(1);
                }
        /* set up exclusive rights to the parport */
        ioctl(parport,PPEXCL); /* note that robi doesn't use this....*/
        ioctl(parport,PPCLAIM);
        parport_data=0;
        parport_out(parport_data);
        }

void close_parport(void){
        ioctl(parport,PPRELEASE);
        close(parport);
        }
//-------------------------------
void parport_out(unsigned char data){
        if(ioctl(parport,PPWDATA,&data)==0)
                parport_data=data;
        }

not working machine:

_________________________________________________________________
FREE pop-up blocking with the new MSN Toolbar – get it now! 
http://toolbar.msn.click-url.com/go/onm00200415ave/direct/01/

