Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263743AbUGFKDF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263743AbUGFKDF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 06:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263761AbUGFKDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 06:03:05 -0400
Received: from zeus.kernel.org ([204.152.189.113]:41090 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S263743AbUGFKDB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 06:03:01 -0400
Subject: Re: system calls-(query)
From: FabF <fabian.frederick@skynet.be>
To: Susheel Raj <susheel_nuguru@yahoo.co.in>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040706080030.35778.qmail@web8310.mail.in.yahoo.com>
References: <20040706080030.35778.qmail@web8310.mail.in.yahoo.com>
Content-Type: text/plain
Message-Id: <1089105253.2326.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 06 Jul 2004 11:14:13 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-07-06 at 10:00, Susheel Raj wrote:
> i have been trying to understand how the system calls
> are being made by applications and how the kernel
> reacts to them...this is what i got into my brain....
> when an application makes a system call ( for i386)
> %eax register is filled with the system call number
> and some other registers are to be given some
> appropriate values..for example ..if i amke an exit ()
> system call.. then its system call number "1" is
> filled in %eax and the status code is filled in
> %ebx...
>  
> so i want to know what are the requirements for other
> systems calls to execute ...what all registers they
> access..any documentation would be a great help.... 
You missed the main point here.It does software interrupt using eax,
ebx, ecx, edx, esi, edi in that order.

C program:
 syscall (100, 0, 1, 2, 3, 4, 5, 6);

Function call :
 8048200:       6a 06                   push   $0x6
 8048202:       6a 05                   push   $0x5
 8048204:       6a 04                   push   $0x4
 8048206:       6a 03                   push   $0x3
 8048208:       6a 02                   push   $0x2
 804820a:       6a 01                   push   $0x1
 804820c:       6a 00                   push   $0x0
 804820e:       6a 64                   push   $0x64
 8048210:       e8 1b 5d 00 00          call   804df30 <syscall>

Syscall release :
 804df33:       8b 7c 24 24             mov    0x24(%esp),%edi
 804df37:       8b 74 24 20             mov    0x20(%esp),%esi
 804df3b:       8b 54 24 1c             mov    0x1c(%esp),%edx
 804df3f:       8b 4c 24 18             mov    0x18(%esp),%ecx
 804df43:       8b 5c 24 14             mov    0x14(%esp),%ebx
 804df47:       8b 44 24 10             mov    0x10(%esp),%eax
 804df4b:       cd 80                   int    $0x80

(further args works with struct passing)

Best regards,
FabF

