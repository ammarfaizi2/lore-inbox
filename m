Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263226AbUEKG4I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263226AbUEKG4I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 02:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263100AbUEKGy7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 02:54:59 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:40086 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S262238AbUEKG1g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 02:27:36 -0400
X-AuthUser: davidel@xmailserver.org
Date: Mon, 10 May 2004 23:27:34 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Davide Libenzi <davidel@xmailserver.org>
cc: Fabiano Ramos <ramos_fabiano@yahoo.com.br>,
       Daniel Jacobowitz <dan@debian.org>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Andi Kleen <ak@muc.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ptrace in 2.6.5
In-Reply-To: <Pine.LNX.4.58.0405102253480.1156@bigblue.dev.mdolabs.com>
Message-ID: <Pine.LNX.4.58.0405102324350.1156@bigblue.dev.mdolabs.com>
References: <1UlcA-6lq-9@gated-at.bofh.it>  <m365b4kth8.fsf@averell.firstfloor.org>
  <1084220684.1798.3.camel@slack.domain.invalid>  <877jvkx88r.fsf@devron.myhome.or.jp>
 <873c67yk5v.fsf@devron.myhome.or.jp>  <20040510225818.GA24796@nevyn.them.org>
 <1084236054.1763.25.camel@slack.domain.invalid>
 <Pine.LNX.4.58.0405102253480.1156@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 May 2004, Davide Libenzi wrote:

> On the kernel side, this would be pretty much solved by issuing a ptrace 
> op, with a modified EIP (+2) on return from a syscall (if in single-step 
> mode).

Actaully, the EIP should not be changed (since it already points to the 
intruction following INT 0x80) and I believe it is sufficent to replace 
the test for _TIF_SYSCALL_TRACE with (_TIF_SYSCALL_TRACE | TIF_SINGLESTEP) 
in the system call return path. This should generate a ptrace trap with 
EIP pointing to the next instruction following INT 0x80.



- Davide

