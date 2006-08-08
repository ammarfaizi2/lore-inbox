Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030227AbWHHWFZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030227AbWHHWFZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 18:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030306AbWHHWFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 18:05:25 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:20649 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1030227AbWHHWFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 18:05:24 -0400
Date: Wed, 9 Aug 2006 00:06:13 +0200
From: Jan Kara <jack@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Arjan van de Ven <arjan@linux.intel.com>, linux-kernel@vger.kernel.org,
       davem@redhat.com, sds@tycho.nsa.gov, jack@suse.cz, dwmw2@infradead.org,
       tony.luck@intel.com, jdike@karaya.com,
       James.Bottomley@HansenPartnership.com
Subject: Re: How to lock current->signal->tty
Message-ID: <20060808220613.GC8656@atrey.karlin.mff.cuni.cz>
References: <1155050242.5729.88.camel@localhost.localdomain> <44D8A97B.30607@linux.intel.com> <1155051876.5729.93.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155051876.5729.93.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
  Yes. On one hand I find this behaviour kind of inconsistent (Unix usually
just returns an error code and that's it) but on the other hand there is
no other good way of informing user about e.g. exceeded quota soft
limit.
  So I'll just fix up the tty locking ;).

								Honza

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
