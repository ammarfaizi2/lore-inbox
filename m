Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129230AbRBFIiV>; Tue, 6 Feb 2001 03:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129739AbRBFIiK>; Tue, 6 Feb 2001 03:38:10 -0500
Received: from carnation.njnet.edu.cn ([202.112.23.162]:6606 "EHLO
	njnet.edu.cn") by vger.kernel.org with ESMTP id <S129652AbRBFIh4>;
	Tue, 6 Feb 2001 03:37:56 -0500
Message-Id: <200102060740.PAA05110@njnet.edu.cn>
Date: Tue, 6 Feb 2001 16:39:11 +0800
From: Feng Chun <chfeng520@263.net>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: A Question About kernel source code
X-mailer: FoxMail 3.0 beta 2 [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone:
	I have a question about the linux source code.

consider the function:get_vm_area( mm/vmalloc.c )
struct vm_struct * get_vm_area(unsigned long size)
{
 	struct vm_struct **p,
	....
	for (p = &vmlist; (tmp = *p) ; p = &tmp->next) {
        if (size + addr < (unsigned long) tmp->addr)
                break;
        addr = tmp->size + (unsigned long) tmp->addr;
        if (addr > VMALLOC_END-size) {
                kfree(area);
                return NULL;
        }
}
....
}

notice that  here p is defined as a pointer to a pointer, why not 

struct vm_struct *p,
for (p=vmlist; (tmp=p); p=tmp->next) {
..
}

does it mean that the later is not efficient as the former? 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
