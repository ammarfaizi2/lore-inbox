Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263902AbTETTkA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 15:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263901AbTETTkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 15:40:00 -0400
Received: from d06lmsgate-3.uk.ibm.com ([195.212.29.3]:4499 "EHLO
	d06lmsgate-3.uk.ibm.com") by vger.kernel.org with ESMTP
	id S263902AbTETTj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 15:39:59 -0400
Date: Tue, 20 May 2003 12:52:31 -0700
From: Andy Whitcroft <apw@shadowen.org>
To: Andrew Morton <akpm@digeo.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.69-mm7
Message-ID: <535806509.1053435150@IBM-O1F8DZ9MWMH>
In-Reply-To: <20030519012336.44d0083a.akpm@digeo.com>
References: <20030519012336.44d0083a.akpm@digeo.com>
X-Mailer: Mulberry/3.0.3 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seems that -mm7, has broken compilation of subarch visws:

arch/i386/kernel/built-in.o: In function `cpu_stop_apics':
arch/i386/kernel/built-in.o(.text+0xe511): undefined reference to 
`stop_this_cpu'
arch/i386/kernel/built-in.o: In function `stop_apics':
arch/i386/kernel/built-in.o(.text+0xe552): undefined reference to 
`reboot_cpu'
arch/i386/mach-visws/built-in.o: In function `machine_restart':
arch/i386/mach-visws/built-in.o(.text+0x1): undefined reference to 
`smp_send_stop'

Seems that the culprit is the reboot on boot processor changes, reverting 
the following patches fixes the compilation:

	patch -R -p1 <kexec-revert-NORET_TYPE.patch
	patch -R -p1 <reboot_on_bsp.patch

Cheers.

-apw
