Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261601AbSJUTis>; Mon, 21 Oct 2002 15:38:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261606AbSJUTis>; Mon, 21 Oct 2002 15:38:48 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:25028 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261601AbSJUTir>;
	Mon, 21 Oct 2002 15:38:47 -0400
Message-ID: <3DB45886.3DDE1CC8@us.ibm.com>
Date: Mon, 21 Oct 2002 12:41:58 -0700
From: mingming cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: dipankar@in.ibm.com
CC: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH]IPC locks breaking down with RCU
References: <Pine.LNX.4.44.0210201809490.2106-100000@localhost.localdomain> <3DB44343.701B7EFD@us.ibm.com> <20021022004806.A10573@in.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dipankar Sarma wrote:
> 
> I took a quick look at the original ipc code and I don't understand
> something - it seems to me the ipc_ids structs are protected by the semaphore
> inside for all operations, so why do we need the spinlock in the
> first place ? Am I missing something here ?

The semaphore is used to protect the fields in ipc_ids structure, while
the spinlock is used to protect IPC ids. For the current implementation,
there is one spinlock for all IPC ids of the same type(i.e. for all
messages queues).  The patch is intend to breaks down the global
spinlock and have a lock per IPC id.
