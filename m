Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261389AbUEFC6H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261389AbUEFC6H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 22:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbUEFC6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 22:58:07 -0400
Received: from sankara2.bol.com.br ([200.221.24.89]:4343 "EHLO
	sankara2.bol.com.br") by vger.kernel.org with ESMTP id S261389AbUEFC6D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 22:58:03 -0400
Subject: ptrace bug?
From: Fabiano Ramos <fabramos@bol.com.br>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Fabiano Ramos <ramos_fabiano@yahoo.com.br>,
       Edil Severiano Tavares Fernandes <edil@cos.ufrj.br>
Content-Type: text/plain
Message-Id: <1083812363.1382.314.camel@slack.domain.invalid>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 05 May 2004 23:59:23 -0300
Content-Transfer-Encoding: 7bit
X-Sender-IP: 200.165.210.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

I am using ptrace() from a user program (code at the end). The thing
is, when tracing a snippet like:

0x0804869f:  8B 4D 0C                     mov	ecx, [ebp+12]
0x080486a2:  CD 80                        int	0x80
0x080486a4:  89 45 F8                     mov	[ebp-8], eax
0x080486a7:  83 7D F8 82                  cmp	[ebp-8], -126

it would print 

0x080486a2
0x080486a7

which means it is not stopping after the syscall (int 0x80).

Am I missing something or is it the expected behaviour?

TIA
Fabiano

-----------------------------
 
	// wait for exec
	waitpid(pid,&wait_val,0);
	ptrace(PTRACE_SINGLESTEP,pid,NULL,NULL) < 0)

        waitpid(pid,&wait_val,0);

        while (1) {
                ptrace(PTRACE_GETREGS, pid, 0, (int)&regs);
	      	printf("\n 0x%08lx \n", regs.eip);
                
		ptrace(PTRACE_SINGLESTEP, pid, 0, 0);

                wait(&wait_val);
		if ( WIFEXITED(wait_val)) break;

         }



