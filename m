Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261610AbSJUT3Y>; Mon, 21 Oct 2002 15:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261611AbSJUT3Y>; Mon, 21 Oct 2002 15:29:24 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:9464 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id <S261610AbSJUT3Y>; Mon, 21 Oct 2002 15:29:24 -0400
Date: Mon, 21 Oct 2002 20:36:24 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Dipankar Sarma <dipankar@in.ibm.com>
cc: mingming cao <cmm@us.ibm.com>, Andrew Morton <akpm@digeo.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]IPC locks breaking down with RCU
In-Reply-To: <20021022004806.A10573@in.ibm.com>
Message-ID: <Pine.LNX.4.44.0210212022250.17194-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Oct 2002, Dipankar Sarma wrote:
> 
> I took a quick look at the original ipc code and I don't understand
> something - it seems to me the ipc_ids structs are protected by the semaphore
> inside for all operations, so why do we need the spinlock in the
> first place ? Am I missing something here ?

I made that mistake too at first, Mingming set me straight.
Many of the entry points down() the ipc_ids.sem semaphore, but the
most significant ones do not.  ipc/sem.c is probably the best example
(if confusing, since it involves quite different meanings of semaphore):
sys_semop() is the frequent, fast entry point, uses sem_lock without down.

Hugh

