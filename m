Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750758AbVJJNpf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbVJJNpf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 09:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbVJJNpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 09:45:35 -0400
Received: from mx1.cdacindia.com ([203.199.132.35]:47245 "HELO
	mailx.cdac.ernet.in") by vger.kernel.org with SMTP id S1750758AbVJJNpe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 09:45:34 -0400
Message-ID: <434A6EFC.4010100@cdac.in>
Date: Mon, 10 Oct 2005 19:09:08 +0530
From: Karthik Sarangan <karthiks@cdac.in>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: AIO!!
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote a small program to do Async IO from a raw disk
open has no problems.
My program gets stuck up at aio_read(paio);
!!WHY!!

-----------------------------------------------
#define _GNU_SOURCE
#include <aio.h>
#include <unistd.h>
#include <fcntl.h>

#define AIOLEN (256 * 1024)

int main(void)
{
   /* Allocate resources /
   struct aiocb *paio = (struct aiocb *) malloc(sizeof(struct aiocb));
   paio->aio_buf = malloc(AIOLEN);
   paio->aio_fildes = open("/dev/raw/raw1", O_DIRECT | O_RDWR);

   paio->aio_nbytes = AIOLEN;
   paio->aio_reqprio = 0; paio->aio_sigevent.sigev_notify = SIGEV_NONE;

   aio_read(paio);

   /* My program gets stuck here in this loop.  !!WHY!!  */
   while(aio_error(paio))
   {
     sched_yield();
   }

   aio_return(paio);

   /* Return all resources to Linux */
   close(paio->aio_fildes);
   free(paio->aio_buf);
   free(paio);

   return 0;
}
-----------------------------------------------

I also have tried inserting an 'aio_fsync' between 'aio_read' and the 
'while' loop ... to no avail.
