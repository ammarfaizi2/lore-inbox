Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130916AbQKPRTm>; Thu, 16 Nov 2000 12:19:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131046AbQKPRTc>; Thu, 16 Nov 2000 12:19:32 -0500
Received: from lowell.missioncriticallinux.com ([208.51.139.16]:27769 "EHLO
	jerrell.lowell.mclinux.com") by vger.kernel.org with ESMTP
	id <S131037AbQKPRTV>; Thu, 16 Nov 2000 12:19:21 -0500
Date: Thu, 16 Nov 2000 11:57:15 -0500 (EST)
From: Richard Jerrell <jerrell@missioncriticallinux.com>
To: linux-kernel@vger.kernel.org
Subject: Bug in 2.4.0-test9 and test10 with sys_shmat()
Message-ID: <Pine.LNX.4.21.0011161156270.13545-100000@jerrell.lowell.mclinux.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sending -1 as the shmid to shmat will cause an oops.  2.2.16 caught this
with simple boundry checking, so replace the lines

if (!shm_sb || (shmid % SEQ_MULTIPLIER) == zero_id)
                return -EINVAL;

with

if (!shm_sb || shmid < 0 || (shmid % SEQ_MULTIPLIER) == zero_id)
                return -EINVAL;

Simple program to demonstrate the bug...

#include <sys/ipc.h>
#include <sys/shm.h>

int main(void) {
	shmat(-1,0,0);
	return 0;
}

Rich
jerrell@missioncriticallinux.com


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
