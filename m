Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261397AbVCVQPj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261397AbVCVQPj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 11:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261398AbVCVQPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 11:15:39 -0500
Received: from ihemail2.lucent.com ([192.11.222.163]:37059 "EHLO
	ihemail2.lucent.com") by vger.kernel.org with ESMTP id S261397AbVCVQPe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 11:15:34 -0500
Message-ID: <6733C768256DEC42A72BAFEFA9CF06D20D937DAC@ii0015exch002u.iprc.lucent.com>
From: "R, Ashwin (Ashwin)" <ashwinr@lucent.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Per-process core-file patterns
Date: Tue, 22 Mar 2005 21:45:28 +0530
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  So, I want to add the "coreadm" support for manipulating the core
file-names like on Solaris, for the latest
  2.6 kernel. Solaris supports the concept of per-process corefile patterns.
Hence, each process
  can effectively have its own core-file pattern in the event that it
crashes. The pattern is similar to the pattern
  used in fs/exec.c ( function: format_corename).
 Now, I have 2 ways of implementing this on Linux:
  1. Create an entry in /proc/<pid> for the process when it is forked (
default value is filled up by getting this entry 
      from the parent's directory;hence children inherit the parent's core
pattern),
      which holds the core pattern and query it when creating the corefile
from the kernel. The "coreadm" command
      in this case, just modifies this entry in /proc.
  2. Add a new field in task_struct and write a new system-call (similar to
"corectl" on solaris) which can manipulate this field.
      The "coreadm" command needs to do the corectl system call and modify
the parameters accordingly.

I see by "trussing" on the coreadm command on Solaris that it uses a system
call "corectl".

Which is the best approach to take?

-Thanks.

