Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273883AbRIRTvQ>; Tue, 18 Sep 2001 15:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273884AbRIRTvI>; Tue, 18 Sep 2001 15:51:08 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:4618 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S273883AbRIRTuz>; Tue, 18 Sep 2001 15:50:55 -0400
Date: Tue, 18 Sep 2001 15:51:21 -0400
From: Arjan van de Ven <arjanv@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: Preliminary testing results for 2.4.10-pre11
Message-ID: <20010918155121.B26279@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

In the Red Hat testlab, Bob Matthews has run the stress-test part of our
normal "release signoff tests" on 2.4.10pre11 to evaluate the new VM for
stability. 

So far, tests were done on 2 different machines, both using a kernel
compiled with PAE support (HIGHMEM64G).

"Test4" is a 4xPIII machine with 2Gb RAM and 4Gb swap
"Test30" is a 2xPIII machine with 1GB RAM and 2Gb swap

Neither of these machines passed the test; 2.4.7-ac3 (as used in Red Hat
beta Roswell 2) and 2.4.9-ac kernels do pass these tests.

Test4:  Random failures of memtst, apparently due to OOM. Random failure of
file system tests, cause unknown.

Test30:  Random failures of memtst, TTCP, the file system tests and the
floating point tests, all apparently due to OOM.  OOM killed test harness,
can not continue.

("OOM" is "OOM killing process X" and "VM: killing process X")

Similar behavior has been obseverved with the 2.4.6-ac5 kernel, which at the
time turned out to have the bug that the VM subsystem never waited for ANY
io to complete, which meant the kernel couldn't satisfy new allocations
while there were actually plenty of dirty pages around.


About the test
--------------

The test can be downloaded from http://people.redhat.com/bmatthews/cerberus
and consists of a superset of the Cerberus testsuite as published by VA
Linux, and is used by Red Hat and other distributions to test the stability
of kernels for distribution releases.

The tests scale to memory, but make sure that at least 500Mb (for small
machines) or 1Gb (for bigger machines) swapspace is "slack" eg, on a 2GB Ram
/ 4Gb swap machine, no more than 5Gb is used for the workload. The test is
by no means a speed-indication, only a stability test.


Greetings,
  Arjan van de Ven
