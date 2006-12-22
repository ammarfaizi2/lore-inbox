Return-Path: <linux-kernel-owner+w=401wt.eu-S1423032AbWLVOf3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423032AbWLVOf3 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 09:35:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423077AbWLVOf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 09:35:29 -0500
Received: from smtp1.telegraaf.nl ([217.196.45.193]:60367 "EHLO
	smtp1.telegraaf.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423032AbWLVOf2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 09:35:28 -0500
Date: Fri, 22 Dec 2006 15:35:20 +0100
From: Ard -kwaak- van Breemen <ard@telegraafnet.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: "Zhang, Yanmin" <yanmin.zhang@intel.com>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Yinghai Lu <yinghai.lu@amd.com>, take@libero.it, agalanin@mera.ru,
       linux-kernel@vger.kernel.org, bugme-daemon@bugzilla.kernel.org,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [Bug 7505] Linux-2.6.18 fails to boot on AMD64 machine
Message-ID: <20061222143520.GG31882@telegraafnet.nl>
References: <117E3EB5059E4E48ADFF2822933287A401F2EB70@pdsmsx404.ccr.corp.intel.com> <20061222082248.GY31882@telegraafnet.nl> <20061222003029.4394bd9a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061222003029.4394bd9a.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
X-telegraaf-MailScanner-From: ard@telegraafnet.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 22, 2006 at 12:30:29AM -0800, Andrew Morton wrote:
> I expect that you'll find that the ide code ends up doing
> down_write(pci_bus_sem), which will enable interrupts.
will:         down_read(&pci_bus_sem);
also enable interrupts?
Since that is called:
init/main.c         start_kernel
kernel/params.c      parse_args("Booting kernel"
kernel/params.c       parse_one
drivers/ide/ide.c      ide_setup
drivers/ide/ide.c       init_ide_data
drivers/ide/ide.c        init_hwif_default
include/asm-i386/ide.h    ide_default_io_base(index)
drivers/pci/search.c       pci_find_device
drivers/pci/search.c        pci_find_subsys
                             down_read(&pci_bus_sem);
                 

-- 
program signature;
begin  { telegraaf.com
} writeln("<ard@telegraafnet.nl> TEM2");
end
.
