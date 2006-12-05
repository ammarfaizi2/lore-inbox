Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968054AbWLEDcm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968054AbWLEDcm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 22:32:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968057AbWLEDcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 22:32:42 -0500
Received: from nz-out-0506.google.com ([64.233.162.228]:64000 "EHLO
	nz-out-0102.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S968054AbWLEDcl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 22:32:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:x-mailer:x-url:date:message-id:subject:mime-version:content-type:content-transfer-encoding;
        b=Z3RI0a8/JE6FcNMn+nJ02NdpfzMqcykxew5dvIU+vtjJISPHvYt3SiHS85ZU9yRZhS+CH9nDGpgVRcWEd3pc/cTYqItX9PO5zkgGKG6iF/v9r5TMiwS/x5X90em1m0nhm0om2GpNMoB8gzbrbmC4qu8PtPVNpowbpIKoHH1YOpQ=
From: Bob Zhang <zhanglinbao@gmail.com>
To: <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 4.1 (3650) - EVALUATION VERSION
X-URL: http://www.pocomail.com/
Date: Tue, 5 Dec 2006 11:32:30 +0800
Message-ID: <2006125113230.203524@9BobZhang1>
Subject: About watch dog timer limit of  CPU (Xscale ->IXP425) How can I set more long time ?
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all , 

    My embeded board hardware configuration is like this :
# cat /proc/cpuinfo
Processor       : XScale-IXP425/IXC1100 rev 1 (v5b)
BogoMIPS        : 266.24
Features        : swp half thumb fastmult edsp 

Hardware        : Intel IXDP425 Development Platform
Revision        : 0000
Serial          : 0000000000000000

Through reading datasheet of ixp4xx ,I know it has own watchdog functions ,
please see attchment :15 Timer 

I find a driver by goole , 
see attachment .


Watchdog timer counter is 32 bit register , its max value is 2<<32 -1 

#define TIMER_FREQ 66000000 /* 66 MHZ timer */
#define TIMER_KEY 0x482e
#define TIMER_MARGIN 60  /* (secs) Default is 1 minute */     
//I want to modify it ,I find its max value is 65

static int ixp425_margin = TIMER_MARGIN; /* in seconds */
static int ixp425wdt_users;
//static int pre_margin;  //IXP425 CPU 's watch dog timer is 32 bit , 
//so I define it to be unsigned int --bob
static unsigned int pre_margin;   
pre_margin = TIMER_FREQ *  TIMER_MARGIN 
*IXP425_OSWT = pre_margin; 

if I need one minutes , 
*IXP425_OSWT = 66000000 * 60 =  396000000  ,not overflow  

if I need two minutes , 
*IXP425_OSWT = 66000000 * 120 = 792000000  ( which has been >  2<<32-1  , overflow 

So I compute the max time I can set :
 T_max = 2<<32-1 / 66000000    =  65 seconds ¡£  


--------------------
My question:

if need more seconds ( for example , 5 minutes ) ,what should I do ? 

I have a method based on datasheet (ixp4xx) ,but I don't know if it will successed when system crash 

How can I do to break the limit of hardware ? 
Thanks ahead ! 

--
Best Regards
bob
