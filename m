Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965904AbWKOHjQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965904AbWKOHjQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 02:39:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965919AbWKOHjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 02:39:16 -0500
Received: from py-out-1112.google.com ([64.233.166.183]:16014 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S965904AbWKOHjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 02:39:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ghpQWDqXpAuBeXTAY8MMQVyojEXyOe8CGs1ipAS2jSQ5jJhSbyyvkodYy2I0Bl81rHaivOoKLxLhPprVQTOeO687swILkJgvF4ncR6TaWShRy4OKDthUTi+QzgeLP6gP/LDNjq9coteudBmwx0n0xv9ejtDzWC0X3fhtYwPXUvI=
Message-ID: <5d96567b0611142339k23e78cc6u19b64052be5cd360@mail.gmail.com>
Date: Wed, 15 Nov 2006 09:39:14 +0200
From: "Raz Ben-Jehuda(caro)" <raziebe@gmail.com>
To: linux-aio@kvack.org, "Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: linux io_submit syscall duration
Cc: bcrl@kvack.org, zach.brown@oracle.com
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bnejamin hello.

My name is raz and i have encountered a problem with  io_submit.
The maximum duration of a single io_submit operation when
heavily stressing the system with large number of big (1MB) ios,
reaches several hundereds ms.

I have been profiling it and it seems that the problem is the
file->f_op->aio_read operation,
a call that is made in fs/aio.c when coming from:
 sys_io_submit -->
   io_submit_one -->
	  aio_run_iocb -->
   		 *retry


The test is initiating several hundered 1MB IOs over a single block device.

I understand that the assumption made was aio_read is asynchronous and no
delay will occure, but isn't possible to do it in the workqueue context ?

would appreciate your help.
thank you

raz
