Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261621AbULNTZp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261621AbULNTZp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 14:25:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261624AbULNTZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 14:25:45 -0500
Received: from wproxy.gmail.com ([64.233.184.205]:23391 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261621AbULNTZY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 14:25:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=XywrPJACq+4it78ABWu8wKFOb9TgyfKneh4t5WjKS+pz6xPhowA/HTXZI8HmhWD4TFPenBtNhHP+2qz3oKdYzLb/r45dh3sWqZA9636bAx3vhKMz2Ec89D+ElmjGlqbtzEBMVlfkQxXB3BGUG1Bto5R79i2Cl4bgZtMIm84URT0=
Message-ID: <5afb2c65041214112577ff4a18@mail.gmail.com>
Date: Tue, 14 Dec 2004 17:25:23 -0200
From: Fabiano Ramos <fabiano.ramos@gmail.com>
Reply-To: ramos_fabiano@yahoo.com.br
To: LKML <linux-kernel@vger.kernel.org>
Subject: help with access_process_vm
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

I am trying to write/read to/from a process image (to be more
specific, replace an instruction with a 0xCC trap) from within a debug
handler.  I mean, a debug handler will be fired
(via eflags) and I want to make sure the process will stop again at a
given address.

My new handler, called do_debug_new replaces the old do_debug. From inside it,
I do something like

       task = current;
       ....
       access_process_vm(task, addr, &oldvalue, sizeof(oldvalue), 0);
       newvalue= oldvalue;
       ptr = (char *) &newvalue;
       *ptr = 0xCC; 
       access_process_vm(task, addr, &newvalue, sizeof(newvalue), 1);
        ....

But the first time a call access_process_vm, dmesg shows me:
     
Debug: sleeping function called from invalid context at include/linux/rwsem.h:43
in_atomic():0, irqs_disabled():1
 [<c01145ac>] __might_sleep+0x8c/0xa0
 [<c011c69b>] access_process_vm+0x4b/0x1d0
 [<c010c830>] do_debug_new+0xd0/0x190
 [<c038c755>] schedule+0x275/0x460
 [<c0105c2d>] error_code+0x2d/0x40

What I am missing? Do I need some syncronization? Can the debug
handler run in the
context of a process that was not the one that caused the debug trap?

Thanks a lot
Fabiano
