Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261254AbVCRA5l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261254AbVCRA5l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 19:57:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261268AbVCRA5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 19:57:41 -0500
Received: from rproxy.gmail.com ([64.233.170.200]:58176 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261254AbVCRA5i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 19:57:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=nK5g6lQkujn9IKlNJjfWLfNCTW5PQuuortC0bhpgFq17jHl6kaUbAGvngj7xjBNZc9gdqkd8kk2nxovG2c/g5QtrfzNX1No171kdtyUDZjCXTe/TAIbOdFFxvnI8JHuSsu8ccS8xHCs1VddR/4BLy3VYfyvAa6mf8ZJn5YIkC+Q=
Message-ID: <ff1cadb205031716574665a36f@mail.gmail.com>
Date: Fri, 18 Mar 2005 00:57:38 +0000
From: Luca Falavigna <dktrkranz@gmail.com>
Reply-To: Luca Falavigna <dktrkranz@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: EIP and VMA
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
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
