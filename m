Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293617AbSBZWGx>; Tue, 26 Feb 2002 17:06:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293618AbSBZWGp>; Tue, 26 Feb 2002 17:06:45 -0500
Received: from mx.nlm.nih.gov ([130.14.22.48]:23287 "EHLO mx.nlm.nih.gov")
	by vger.kernel.org with ESMTP id <S293615AbSBZWGi>;
	Tue, 26 Feb 2002 17:06:38 -0500
Message-ID: <3C7C06E5.907F536E@ncbi.nlm.nih.gov>
Date: Tue, 26 Feb 2002 17:06:29 -0500
From: Anton Lavrentiev <lavr@ncbi.nlm.nih.gov>
Organization: NCBI NIH
X-Mailer: Mozilla 4.79 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: sys_sysinfo()'s bug in reporting the number of processes
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux Developers:

I've noticed discrepancy in the number of processes
returned by sysinfo() syscall versus the number of processes
listed by 'ps'. The problem traced down to the following line
of code in kernel/info.c:

val.proc = nr_task-1;

as if the idle task is taken into account in 'nr_tasks',
However, since kernel 2.2 the comment to (and the usage of)
'nr_task' explicitly states that the idle task is not anymore
counted in this variable. From kernel/fork.c:

/* The idle tasks do not count.. */
int nr_tasks = 0;

As a matter of fact, prior to kernel 2.2 the initial value of
'nr_tasks' was 1, and the idle task 0 was counted, so the
correction by -1 was really necessary. But it was forgotten
to undo this subtraction when the 'nr_tasks' had changed its
meaning since then.

Best regards,

Anton Lavrentiev
NCBI/NLM/NIH
