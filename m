Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262629AbTJIWEb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 18:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262633AbTJIWEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 18:04:31 -0400
Received: from fw.osdl.org ([65.172.181.6]:5331 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262629AbTJIWEa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 18:04:30 -0400
Message-Id: <200310092204.h99M4Ro28540@mail.osdl.org>
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.0-test7 oops in proc_pid_stat
To: Olaf Hering <olh@suse.de>, linux-kernel@vger.kernel.org,
       Taner Halicioglu <taner@taner.net>
Reply-To: torvalds@osdl.org
Date: Thu, 09 Oct 2003 15:04:26 -0700
References: <20031009130409.GA740@suse.de>
Organization: OSDL
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Hering wrote:
> 
> Linux version 2.6.0-test7 (olaf@zert152) (gcc version 3.2.2) #2 SMP Thu
> Oct 9 08:49:29 CEST 2003
> 
> Unable to handle kernel NULL pointer dereference at virtual address
0000003c

Ok, this seems to be due to the move of the job control fields from
the task structure to the signal structure.

That looks like a bad idea, and the best thing to do is likely to just
revert the whole thing.

If you are a BK user, do a "bk changes" to find the ChangeSet that says
"[PATCH] move job control fields from task_struct to", and just do a

        bk cset -xX.XXXX

where X.XXXX is the changeset number in your tree (that will depend on
exactly what else is in your tree).

                Linus
