Return-Path: <linux-kernel-owner+w=401wt.eu-S1752651AbWL2MvM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752651AbWL2MvM (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 07:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752733AbWL2MvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 07:51:12 -0500
Received: from smtp1.telegraaf.nl ([217.196.45.193]:53192 "EHLO
	smtp1.telegraaf.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752651AbWL2MvL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 07:51:11 -0500
Date: Fri, 29 Dec 2006 13:51:08 +0100
From: Ard -kwaak- van Breemen <ard@telegraafnet.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: Greg KH <greg@kroah.com>, "Zhang, Yanmin" <yanmin.zhang@intel.com>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Yinghai Lu <yinghai.lu@amd.com>, take@libero.it, agalanin@mera.ru,
       linux-kernel@vger.kernel.org, bugme-daemon@bugzilla.kernel.org,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [Bug 7505] Linux-2.6.18 fails to boot on AMD64 machine
Message-ID: <20061229125108.GK912@telegraafnet.nl>
References: <117E3EB5059E4E48ADFF2822933287A401F2EB70@pdsmsx404.ccr.corp.intel.com> <20061222082248.GY31882@telegraafnet.nl> <20061222003029.4394bd9a.akpm@osdl.org> <20061222144134.GH31882@telegraafnet.nl> <20061222154234.GI31882@telegraafnet.nl> <20061228155148.f5469729.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061228155148.f5469729.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
X-telegraaf-MailScanner-From: ard@telegraafnet.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,
On Thu, Dec 28, 2006 at 03:51:48PM -0800, Andrew Morton wrote:
> Could someone please test this?
Without testing I declare it won't fix it 8-D
> Ard has worked out the call tree:
> 
> init/main.c         start_kernel
> kernel/params.c      parse_args("Booting kernel"
> kernel/params.c       parse_one
> drivers/ide/ide.c      ide_setup
> drivers/ide/ide.c       init_ide_data
> drivers/ide/ide.c        init_hwif_default
> include/asm-i386/ide.h    ide_default_io_base(index)
> drivers/pci/search.c       pci_find_device
> drivers/pci/search.c        pci_find_subsys
------------------------------^^^^^^^^^^^^^^
Your patch patches pci_get_subsys, while pci_find_subsys does the
down_read...
I will try it on the right function, and see what we get.

Regards,
Ard

-- 
program signature;
begin  { telegraaf.com
} writeln("<ard@telegraafnet.nl> TEM2");
end
.
