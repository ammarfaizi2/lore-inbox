Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269967AbRHEPTF>; Sun, 5 Aug 2001 11:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269969AbRHEPSy>; Sun, 5 Aug 2001 11:18:54 -0400
Received: from host217-32-145-164.hg.mdip.bt.net ([217.32.145.164]:9476 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S269967AbRHEPSj>;
	Sun, 5 Aug 2001 11:18:39 -0400
Date: Sun, 5 Aug 2001 16:21:00 +0100 (BST)
From: Tigran Aivazian <tigran@btconnect.com>
To: Lukas Dobrek <dobrek@itp.uni-hannover.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: HOWTO hide a process.
In-Reply-To: <20010805140941.A23189@spica.itp.uni-hannover.de>
Message-ID: <Pine.LNX.4.21.0108051618460.612-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Aug 2001, Lukas Dobrek wrote:
> struct task_struct * task;
> task=find_task_by_pid(<pid>);
> task->pid=0;

no, don't do that. This is the correct way to do what you want:

        /*
         * Remove our kernel threads from ps listings.
         */
        write_lock_irq(&tasklist_lock);
        unhash_pid(current);
        current->pidhash_pprev = &current->pidhash_next;
        current->pidhash_next = NULL;
        write_unlock_irq(&tasklist_lock);

Regards,
Tigran



