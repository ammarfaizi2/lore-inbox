Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262206AbUBXIq0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 03:46:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262216AbUBXIqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 03:46:25 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:1921 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S262206AbUBXIqG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 03:46:06 -0500
From: Darren Williams <dsw@gelato.unsw.edu.au>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 24 Feb 2004 19:45:59 +1100
Cc: LKML <linux-kernel@vger.kernel.org>, manfred@colorfullife.com
Subject: Re: [BUG] 2.6.3 Slab corruption: errors are triggered when memory exceeds 2.5GB (correction)
Message-ID: <20040224084559.GA993@cse.unsw.EDU.AU>
References: <403AF155.1080305@colorfullife.com> <20040223225659.4c58c880.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20040223225659.4c58c880.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Yes the machine is using ECC though I will need to confirm tommorrow that
it is enabled, from memory it is. I am currently running memtest over the
memory however it is limited to testing 2GB because it uses malloc, so this
is not a reliable test.
I will continue to swap the memory modules to see if I can find a failed
module.
                                                                                                                             
If this fails to help I will then look for the offending atomic_t or
spinlock_t.
                                                                                                                             
Thanks for the replies
Darren 

Mon, 23 Feb 2004, Andrew Morton wrote:

> Manfred Spraul <manfred@colorfullife.com> wrote:
> >
> >  From your logs:
> > 
> > >Feb 23 14:54:24 calypso kernel: Slab corruption: start=e00000017e84ea00, expend=e00000017e84f1ff, problemat=e00000017e84f020
> > >Feb 23 14:54:24 calypso kernel: Last user: [<a0000001003c9f30>](kfree_skbmem+0x30/0x80)
> > >Feb 23 14:54:24 calypso kernel: Data: ************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************!
> **!
> > ***************************************
> > >Feb 23 14:54:28 calypso kernel: **************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************6A *************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************!
> **!
> > ***************************************
> > >Feb 23 14:54:28 calypso kernel: ************************************************************A5 
> > >  
> > >
> > "6a" instead of 0x6b. One bit is wrong, this is often an indication of a 
> > hardware problem. Do you use ECC memory and is ECC enabled in the BIOS?
> 
> Actually, it's often caused by someone doing atomic_dec_and_test() against
> something which was already freed.  Or spin_lock().  One would need to work
> out what field is at that offset.  If it is an atomic_t or a spinlock_t,
> there you are.
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
