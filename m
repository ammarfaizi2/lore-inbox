Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964942AbWHHPLC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964942AbWHHPLC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 11:11:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964945AbWHHPLB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 11:11:01 -0400
Received: from mga05.intel.com ([192.55.52.89]:26174 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S964942AbWHHPLA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 11:11:00 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.07,222,1151910000"; 
   d="scan'208"; a="113419032:sNHT7036766905"
Message-ID: <44D8A97B.30607@linux.intel.com>
Date: Tue, 08 Aug 2006 08:10:51 -0700
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org, davem@redhat.com, sds@tycho.nsa.gov,
       jack@suse.cz, dwmw2@infradead.org, tony.luck@intel.com,
       jdike@karaya.com, James.Bottomley@HansenPartnership.com
Subject: Re: How to lock current->signal->tty
References: <1155050242.5729.88.camel@localhost.localdomain>
In-Reply-To: <1155050242.5729.88.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> The biggest crawly horror I've found so far in auditing the tty locking
> is current->signal->tty. The tty layer currently and explicitly protects
> this using tty_mutex. The core kernel likewise knows about this.
> 
> Unfortunately:
> 	Dquot passes the tty to tty_write_message without locking
> 	arch/ia64/kernel/unanligned seems to write to it without locking

these two have absolutely no business at all using anything tty.... they should
just use printk with KERN_EMERG or whatever
