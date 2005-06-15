Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261546AbVFOUfm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261546AbVFOUfm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 16:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261545AbVFOUfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 16:35:41 -0400
Received: from web52508.mail.yahoo.com ([206.190.39.133]:52314 "HELO
	web52508.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261550AbVFOUd6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 16:33:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=XqYrhzQmQE4jsot7NcsBRR/VS6B83Vkf8dYflLjsZ+c8GD+8n82x8KeDyARsMLokHs+k1kxYQ7XCBO2tkzY9G39R1NrTLnYaa2AJz+E79US8ZwOoFmdCJYEQ864VZ+fcCzFq1SbL0xe/5tNamG7x3h+fwarD07q8D1ynGGLDBkM=  ;
Message-ID: <20050615203353.37738.qmail@web52508.mail.yahoo.com>
Date: Wed, 15 Jun 2005 13:33:53 -0700 (PDT)
From: Diane Jaquay <djaquay@yahoo.com>
Subject: file descriptor leak in 64-bit 2.6.8?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Are there known problems with file descriptor leaks in 2.6.8 running on an
Athlon 64?

The details: I recently ran out of file descriptors (got a line in
/var/log/messages of "kernel: VFS: file-max limit 203424 reached", also "Too
many open files in system" when running various commands not as root).  lsof |
wc reported around 4000 files in use, which, (while I understand that lsof
won't match file-nr due to maps, etc.), still struck me as odd to have an
orders-of-magnatude difference between the two numbers.

I then started shutting things down.  Nothing caused file-nr to shrink by more
than a few hundred.  Eventually, I rebooted, and started logging file-nr.  

Seems that the number of allocated descriptors grows steadily, even though
process-wise, not much is running on the box (just Apache and Postgres).  After
14 days uptime, I'm up to 65235 descriptors allocated per file-nr, and lsof |
wc reporting 2813.  The lsof number is fairly stable, while file-nr has
steadily grown.

Box details:

SuSE 9.2 running stock kernel: 2.6.8-24.11-default
/proc/cpuinfo says "AMD Athlon(tm) 64 Processor 3000+"

Clues most welcome,
Dave

