Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261714AbULaHtI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261714AbULaHtI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 02:49:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbULaHtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 02:49:08 -0500
Received: from canuck.infradead.org ([205.233.218.70]:39942 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261714AbULaHtE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 02:49:04 -0500
Subject: Re: Interception for a resource based scheduler
From: Arjan van de Ven <arjan@infradead.org>
To: selvakumar nagendran <kernelselva@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041231065136.94485.qmail@web60605.mail.yahoo.com>
References: <20041231065136.94485.qmail@web60605.mail.yahoo.com>
Content-Type: text/plain
Date: Fri, 31 Dec 2004 08:48:56 +0100
Message-Id: <1104479336.5402.4.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-12-30 at 22:51 -0800, selvakumar nagendran wrote:
> hi,
>   I am using these information for the scheduler I am
> developing in Linux. The scheduler selects the next
> process to run based on the resources needed so that a
> high priority process will not starve for a semaphore
> key, file lock etc that were acquired by a low
> priority process. The user may change the file
> descriptor only through syscalls. If I intercept them
> and update the resource history that I am maintaining,
> then will the information break?

I think you missed the point. I'll reexplain:

what do you is

syscall_wrapper()
{
	original_syscall_that_copies_the_numbers_to_userspace();
	kmalloc(GFP_KERNEL); <-- can sleep
	copy_numbers_back_from_userspace();
}

it is REALLY easy for another thread of the userspace program that did
the syscall to change IT'S OWN MEMORY where the 2 FD numbers are stored
between the moment the original syscall copies them there, and the
moment you *recopy* them back.


