Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262886AbVAFQEA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262886AbVAFQEA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 11:04:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262888AbVAFQEA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 11:04:00 -0500
Received: from relay02.pair.com ([209.68.5.16]:62221 "HELO relay02.pair.com")
	by vger.kernel.org with SMTP id S262886AbVAFQDk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 11:03:40 -0500
X-pair-Authenticated: 66.134.112.218
Subject: Re: finding process blocking on a system call
From: Daniel Gryniewicz <dang@fprintf.net>
To: selvakumar nagendran <kernelselva@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050106121830.44661.qmail@web60609.mail.yahoo.com>
References: <20050106121830.44661.qmail@web60609.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 06 Jan 2005 11:03:39 -0500
Message-Id: <1105027419.17473.2.camel@athena.fprintf.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.1.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-01-06 at 04:18 -0800, selvakumar nagendran wrote:
> Hello linux-experts,
>    I want to find whether a process blocks in a system
> call due to the unavailability of the resource that is
> accessed in it. For eg, if a semaphore key is not
> available to the process while executing the system
> calls like read, write etc, it will wait in the
> TASK_INTERRUPTIBLE state. 
>    Now, I don't want the process to simply sleep,
> waiting for the semaphore. I want it to be added into
> the runqueue again. And also, I want to determine this
> in the kernel module. How can I do this? Can anyone
> help me regarding this?
>  I am intercepting system calls in kernel 2.4.28.
> 
> Thanks,
> selva
> 

This is a very bad idea, as the process will expect the syscall to be
complete when it runs again.  Just use the non-blocking versions of the
syscall (file/network IO all have non-blocking versions), and handle the
EWOULDBLOCK return value in your userspace application.

Daniel
