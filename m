Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261669AbUBZAbB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 19:31:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262474AbUBZAbB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 19:31:01 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:30099 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S261669AbUBZAa7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 19:30:59 -0500
From: Darren Williams <dsw@gelato.unsw.edu.au>
To: Manfred Spraul <manfred@colorfullife.com>
Date: Thu, 26 Feb 2004 11:30:46 +1100
Cc: davem@redhat.com, akpm@osdl.org, LKML <linux-kernel@vger.kernel.org>,
       anton@samba.org
Subject: Re: [BUG] 2.6.3 Slab corruption: errors are triggered when memory exceeds 2.5GB (correction)
Message-ID: <20040226003046.GA22527@cse.unsw.EDU.AU>
References: <403AF155.1080305@colorfullife.com> <20040223225659.4c58c880.akpm@osdl.org> <403B8C78.2020606@colorfullife.com> <20040225005804.GE18070@cse.unsw.EDU.AU> <403C3F04.20601@colorfullife.com> <20040224230318.19a0e6b9.davem@redhat.com> <20040224232205.4fe87448.akpm@osdl.org> <403CD8E2.2060102@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <403CD8E2.2060102@colorfullife.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Manfred

With the introduction of the unused int the slab corruption
errors are not present.

Darren

On Wed, 25 Feb 2004, Manfred Spraul wrote:

> Andrew Morton wrote:
> 
> >Ah-hah.
> >
> >This should find it:
> > 
> >
> I think we should first check that skb->dataref is really the problem: 
> what about adding an unused field before the dataref? Something like
> 
> struct skb_shared_info {
> +	int		unused;
> 	atomic_t	dataref;
> 	int		debug;
> 
> If the dataref decrease causes the problem, then the affected offset should 
> change to 0x628.
> 
> --
> 	Manfred
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--------------------------------------------------
Darren Williams <dsw AT gelato.unsw.edu.au>
Gelato@UNSW <www.gelato.unsw.edu.au>
--------------------------------------------------
