Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261600AbRERXdx>; Fri, 18 May 2001 19:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261601AbRERXdn>; Fri, 18 May 2001 19:33:43 -0400
Received: from cpe.atm0-0-0-122182.bynxx2.customer.tele.dk ([62.243.2.100]:49778
	"HELO marvin.athome.dk") by vger.kernel.org with SMTP
	id <S261600AbRERXdk>; Fri, 18 May 2001 19:33:40 -0400
Message-ID: <3B05B152.3000904@fugmann.dhs.org>
Date: Sat, 19 May 2001 01:33:38 +0200
From: Anders Peter Fugmann <afu@fugmann.dhs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.4-ac9 i686; en-US; rv:0.9+) Gecko/20010513
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Q: procfs entry.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again.

I have a question about the function parsed for reading a procfs entry.

I've used the skeleton from drivers/char/misc.c, and all works 
perfectly, but I see a potential flaw.



static int misc_read_proc(char *buf, char **start, off_t offset,
                           int len, int *eof, void *private)
{
.
.
	written=0;
         for (p = misc_list.next; p != &misc_list && written < len;
		p = p->next) {

                 written += sprintf(buf+written, "%3i %s\n",p->minor,
			p->name ?: "");
                 if (written < offset) {
                         offset -= written;
                         written = 0;
                 }
         }
.
.


As I see it, there is a possibility to write beyond buf+len.
(if len<5)
If so is it ok, or should this be avoided at all cost?

TIA
Anders Fugmann



