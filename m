Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268490AbUHYT5r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268490AbUHYT5r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 15:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268420AbUHYTzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 15:55:50 -0400
Received: from fw.osdl.org ([65.172.181.6]:48259 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268465AbUHYTyZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 15:54:25 -0400
Date: Wed, 25 Aug 2004 12:54:11 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
cc: Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] notify_parent and ptrace cleanup
In-Reply-To: <87y8k3knhy.fsf@devron.myhome.or.jp>
Message-ID: <Pine.LNX.4.58.0408251252080.17766@ppc970.osdl.org>
References: <200408251808.i7PI8jFF017075@magilla.sf.frob.com>
 <87y8k3knhy.fsf@devron.myhome.or.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 26 Aug 2004, OGAWA Hirofumi wrote:
> 
> Sorry for about it. Yes, racy is implementation issue. And AFAIK, it
> seems to be fixed by we don't allow SIGCONT. (If it doesn't break userland)

We should split TASK_STOPPED into two different cases: TASK_STOPPED and 
TASK_PTRACED.

A true TASK_STOPPED continues on SIGCONT. A TASK_PTRACED only continues 
when the ptracer says so.

That should be trivially invisible to the user (the only part a user would 
see would be if we make "ps" show a different letter for the PTRACED 
state..)

		Linus
