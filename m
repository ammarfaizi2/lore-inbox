Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266844AbTAFOpN>; Mon, 6 Jan 2003 09:45:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266868AbTAFOpN>; Mon, 6 Jan 2003 09:45:13 -0500
Received: from f10.sea1.hotmail.com ([207.68.163.10]:28175 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S266844AbTAFOpJ>;
	Mon, 6 Jan 2003 09:45:09 -0500
X-Originating-IP: [196.44.34.77]
From: "Dirk Bull" <dirkbull102@hotmail.com>
To: doug@mcnaught.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: shmat problem
Date: Mon, 06 Jan 2003 14:53:41 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F10zrLCCtgx8VUkRacU000005ae@hotmail.com>
X-OriginalArrivalTime: 06 Jan 2003 14:53:41.0703 (UTC) FILETIME=[67428D70:01C2B593]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug, thanks for the reply. I've set SHM_RND in the call and used
"__attribute__ ((aligned(4096)))" during the the declaration of variable 
global01_
(as shown below) such that it is aligned on a page boundary. I'm porting 
code that was
written for a Unix system to Linux and the example shown below is how the 
code is
implemented on Unix.

The example included executed correctly on :
mandrake - ? (Can't remember, but it was an old version)

but fails to work on:
redhat - 2.2.14-5.0
debian - 2.2.9
mandrake - 2.4.19-16mdk



We are currently working on mandrake - kernel 2.4.19-16mdk.


Dirk

-------------------------------------------------------------------------------
Example program:
-------------------------------------------------------------------------------

#include <stdio.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include <errno.h>

#define SHM_MODE (SHM_R | SHM_W)

union {
	long IN[2048];
} global01_ __attribute__ ((aligned(4096)));

int main(void) {
	int shmid;
	char *shmptr;


	if ( (shmid = shmget(IPC_PRIVATE, sizeof(global01_), SHM_MODE)) < 0){
		printf("shmget error: %d %s\n",errno, strerror(errno));
		exit(0);
	}

	if ( (shmptr = shmat(shmid, &global01_, SHM_RND)) == (void *) -1)
		printf("shmat error: %d %s\n",errno, strerror(errno));
	else
		printf("shared memory attached from %x to %x\n",
				shmptr, shmptr+sizeof(global01_));

	if (shmctl(shmid, IPC_RMID, 0) < 0)
		printf("shmctl error: %d %s\n",errno, strerror(errno));

	exit(0);
}









_________________________________________________________________
Protect your PC - get McAfee.com VirusScan Online 
http://clinic.mcafee.com/clinic/ibuy/campaign.asp?cid=3963

