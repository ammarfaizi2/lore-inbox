Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261725AbVEVFV7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261725AbVEVFV7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 May 2005 01:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261727AbVEVFV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 May 2005 01:21:59 -0400
Received: from titan.genwebhost.com ([209.9.226.66]:14548 "EHLO
	titan.genwebhost.com") by vger.kernel.org with ESMTP
	id S261725AbVEVFV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 May 2005 01:21:56 -0400
Date: Sat, 21 May 2005 22:21:51 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: Patrick Plattes <patrick@erdbeere.net>
Cc: linux-kernel@vger.kernel.org, manfred@colorfullife.com
Subject: Re: semaphore understanding: sys_semtimedop()
Message-Id: <20050521222151.15bb0eb4.rdunlap@xenotime.net>
In-Reply-To: <20050516201704.GA9836@erdbeere.net>
References: <20050516201704.GA9836@erdbeere.net>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - titan.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 May 2005 22:17:04 +0200 Patrick Plattes wrote:

| Hello,
| 
| i have a question about this little code snippet, found in
| sys_semtimedop() (ipc/sem.c):
| 
|         for (sop = sops; sop < sops + nsops; sop++) {
|                 if (sop->sem_num >= max)
|                         max = sop->sem_num;
|                 if (sop->sem_flg & SEM_UNDO)
|                         undos++;
|                 if (sop->sem_op < 0)
|                         decrease = 1;
|                 if (sop->sem_op > 0)
|                         alter = 1;
|         }
|         alter |= decrease;
| 
| The variable decrease will never be used again in this 
| function, so why this intricate code? Isn't this much easier and works
| also:
| 
|         for (sop = sops; sop < sops + nsops; sop++) {
|                 if (sop->sem_num >= max)
|                         max = sop->sem_num;
|                 if (sop->sem_flg & SEM_UNDO)
|                         undos++;
|                 if (sop->sem_op != 0)
|                         alter = 1;
|         }
| 
| Maybe i'm totally wrong, so please correct me and don't shoot me up,
| 'cause i'm not a os developer.

Looks like a reasonable and correct optimization to me.

Let's see what Manfred thinks or has to say...

---
~Randy
