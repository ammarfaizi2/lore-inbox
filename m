Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964995AbWHHQlj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964995AbWHHQlj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 12:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964991AbWHHQlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 12:41:39 -0400
Received: from mga09.intel.com ([134.134.136.24]:59065 "EHLO
	orsmga102-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S964995AbWHHQli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 12:41:38 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.07,222,1151910000"; 
   d="scan'208"; a="104947600:sNHT17584791"
Date: Tue, 8 Aug 2006 09:41:27 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Arjan van de Ven <arjan@linux.intel.com>, linux-kernel@vger.kernel.org,
       davem@redhat.com, sds@tycho.nsa.gov, jack@suse.cz, dwmw2@infradead.org,
       jdike@karaya.com, James.Bottomley@HansenPartnership.com
Subject: Re: How to lock current->signal->tty
Message-ID: <20060808164127.GA11392@intel.com>
References: <1155050242.5729.88.camel@localhost.localdomain> <44D8A97B.30607@linux.intel.com> <1155051876.5729.93.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155051876.5729.93.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2006 at 04:44:36PM +0100, Alan Cox wrote:
> Ar Maw, 2006-08-08 am 08:10 -0700, ysgrifennodd Arjan van de Ven:
> > > Unfortunately:
> > > 	Dquot passes the tty to tty_write_message without locking
> > > 	arch/ia64/kernel/unanligned seems to write to it without locking
> > 
> > these two have absolutely no business at all using anything tty.... they should
> > just use printk with KERN_EMERG or whatever
> 
> Dquot does - it writes to the controlling tty of the process exceeding
> quota . That is standard Unix behaviour

IA-64 is also trying to be helpful by putting the message where
the user may actually see it (following the dquot precedent).  But
the whole subject of whether we should print any messages for
unaligned accesses at all is rather controversial.  So its a 50-50
shot whether I'll fix it by adding the mutex_lock/mutex_unlock
around the use of current->signal->tty, or just rip this out and
just leave the printk().

-Tony
