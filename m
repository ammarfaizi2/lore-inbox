Return-Path: <linux-kernel-owner+w=401wt.eu-S932480AbXARUCA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932480AbXARUCA (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 15:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932583AbXARUB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 15:01:59 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:49330 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932480AbXARUB7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 15:01:59 -0500
X-Greylist: delayed 322 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Jan 2007 15:01:58 EST
From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: [patch 03/26] Dynamic kernel command-line - arm
To: Alon Bar-Lev <alon.barlev@gmail.com>, Bernhard Walle <bwalle@suse.de>,
       linux-kernel@vger.kernel.org, Alon Bar-Lev <alon.barlev@gmail.com>
Reply-To: 7eggert@gmx.de
Date: Thu, 18 Jan 2007 20:56:18 +0100
References: <7EFbN-34r-3@gated-at.bofh.it> <7EFbV-34r-45@gated-at.bofh.it> <7EGhI-4Rq-11@gated-at.bofh.it> <7EGKC-5vh-15@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1H7dMw-0000hd-H6@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@gmx.de
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:9b3b2cc444a07783f194c895a09f1de9
X-Provags-ID2: V01U2FsdGVkX1+UoLYnIdcugLttNNngXEGV9j/enIkBZwiY03MZfFOZ6k5+oorEfhCILYSF+TunZOuNwmGVYPXqPeyN2uzEXMNoZ/caywgYBJ+j1UsrNrPgiQ==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alon Bar-Lev <alon.barlev@gmail.com> wrote:
> On 1/18/07, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
>> On Thu, Jan 18, 2007 at 01:58:52PM +0100, Bernhard Walle wrote:
>> > 2. Set command_line as __initdata.

>> You can't.
>>
>> > -static char command_line[COMMAND_LINE_SIZE];
>> > +static char __initdata command_line[COMMAND_LINE_SIZE];
>>
>> Uninitialised data is placed in the BSS.  Adding __initdata to BSS
>> data causes grief.

> There are many places in kernel that uses __initdata for uninitialized
> variables.
> 
> For example:

> static int __initdata is_chipset_set[MAX_HWIFS];
> 
> So all these current places are wrong?
> If I initialize the data will it be OK.

objdump -t vmlinux |grep -3 is_chipset_set suggests that it's placed
into .init.data here, not into .bss.
-- 
Top 100 things you don't want the sysadmin to say:
92. What software license?

Friﬂ, Spammer: kq@izs.zi.7eggert.dyndns.org P-@aPN2Oo0.7eggert.dyndns.org
