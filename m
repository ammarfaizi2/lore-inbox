Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266798AbUJAV52@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266798AbUJAV52 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 17:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266802AbUJAVx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 17:53:28 -0400
Received: from fw.osdl.org ([65.172.181.6]:37341 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266807AbUJAVvv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 17:51:51 -0400
Date: Fri, 1 Oct 2004 14:55:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm4 ps hang ?
Message-Id: <20041001145536.182dada9.akpm@osdl.org>
In-Reply-To: <1096666140.12861.82.camel@dyn318077bld.beaverton.ibm.com>
References: <1096646925.12861.50.camel@dyn318077bld.beaverton.ibm.com>
	<20041001120926.4d6f58d5.akpm@osdl.org>
	<1096666140.12861.82.camel@dyn318077bld.beaverton.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
> > Can you work out who is holding mmap_sem for writing?
> > 
> 
> grr.. okay. It hangs randomly. Don't we have code to record the holder
> of a sem somewhere ?

The full sysrq-T trace should tell us.  All I saw from your initial email
was two processes stuck in down_read().  That shouldn't happen, so either
there was another process in down_write() somewhere or we mucked up the
semaphore (it is corrupted, or someone forget up_write()).
