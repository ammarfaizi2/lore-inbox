Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261726AbUL3WEn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261726AbUL3WEn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 17:04:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbUL3WEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 17:04:43 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:26281 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S261726AbUL3WEm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 17:04:42 -0500
Date: Thu, 30 Dec 2004 23:04:40 +0100
From: bert hubert <ahu@ds9a.nl>
To: selvakumar nagendran <kernelselva@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Unable to find syscall number for some system calls
Message-ID: <20041230220440.GA15202@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	selvakumar nagendran <kernelselva@yahoo.com>,
	linux-kernel@vger.kernel.org
References: <20041230042905.44219.qmail@web60607.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041230042905.44219.qmail@web60607.mail.yahoo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 29, 2004 at 08:29:05PM -0800, selvakumar nagendran wrote:

>     I am intercepting system calls in 2.4.28 kernel
> for my project work. While I was looking for syscall
> numbers for system calls related to semaphores like
> semop,semget..the appropriate numbers were  missing in
> the asm/unistd.h file. For other system calls like
> sys_pipe numbers are present in the above file. What

Well, you also won't find sys_connect as these are all wrapped in
sys_socketcall. For intel, it turns out that it has been decided to wrap all
sem*() calls in sys_ipc().

./asm-i386/unistd.h:#define __NR_ipc		117

The 'royal way' to figure these things out is to trace the path from
semget() in libc to the kernel. You can download glibc from the GNU site I
think.

Good luck!

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
