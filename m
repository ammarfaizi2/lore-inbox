Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262164AbTEEMjo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 08:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262165AbTEEMjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 08:39:44 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:31754 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262164AbTEEMjn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 08:39:43 -0400
Date: Mon, 5 May 2003 13:52:11 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Terje Eggestad <terje.eggestad@scali.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Arjan van de Ven <arjanv@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, D.A.Fedorov@inp.nsk.su
Subject: Re: The disappearing sys_call_table export.
Message-ID: <20030505135211.A21658@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Terje Eggestad <terje.eggestad@scali.com>,
	Arjan van de Ven <arjanv@redhat.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, D.A.Fedorov@inp.nsk.su
References: <1052122784.2821.4.camel@pc-16.office.scali.no> <20030505092324.A13336@infradead.org> <1052127216.2821.51.camel@pc-16.office.scali.no> <20030505112531.B16914@infradead.org> <1052133798.2821.122.camel@pc-16.office.scali.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1052133798.2821.122.camel@pc-16.office.scali.no>; from terje.eggestad@scali.com on Mon, May 05, 2003 at 01:23:19PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 05, 2003 at 01:23:19PM +0200, Terje Eggestad wrote:
> The problem occur when you 
> 1. pinn a buffer  
> 2. sbrk(-n) or munmap() (usually thru free()) the area the buffer  
> 3. a new malloc() resulting in a sbrk(+n) or mmap()
> 4. then my new buffer has the exactly same virtual address as the prev.
> 
> (belive it or not this happens, and relatively frequently). 

That only shows that you really don't want to use glibc's malloc and
sbrk implementations, but ones that are implemented as mmap in your
driver so you can keep track of it properly. LD_PRELOAD is your friend.

> Lets deal, I'll GPL the trace module if you get me a 
> EXPORT_SYMBOL_GPL(sys_call_table);

Who cares about your trace module?  That's the wrong approach to start
with.  And the removal of the sys_call_table export is not a political
issue but a technical one.   The interesting thing would be your memory
manager, but given the above hints you really should be able to fix it yourself
now..

