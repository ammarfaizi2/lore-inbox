Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261401AbVCRAZf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261401AbVCRAZf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 19:25:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbVCRAZe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 19:25:34 -0500
Received: from mail1.edisontel.com ([62.94.0.30]:45505 "EHLO
	ims1.edisontel.com") by vger.kernel.org with ESMTP id S261401AbVCRAX5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 19:23:57 -0500
Message-ID: <423A2D88.8090408@gmail.com>
Date: Fri, 18 Mar 2005 01:23:20 +0000
From: Luca Falavigna <dktrkranz@gmail.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: EIP and VMA
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I am working on this piece of code (simplified):

void ip_vma(struct task_struct *task, struct pt_regs *regs)
{
	struct mm_struct *mm;
	struct vm_area_struct *vma;

	if(task) {
		mm = get_task_mm(task);
		if(mm) {
			vma = find_vma(mm, regs->eip);
 			if(vma) {
				/* Some code */
			}
			else
				printk("WARNING: No VMA\n");
			mmput(mm);
		}
	}
}

I would like to get instruction pointer's VMA of a task. In order to do so, I
use find_vma function, using regs->eip as instruction pointer value.
Unfortunately I always get "WARNING: No VMA" message because find_vma isn't able
to find the right VMA regs->eip address belongs to.
Is regs->eip the right place where istruction pointer is located or I should
find that value elsewhere?

Thank you,



				Luca

