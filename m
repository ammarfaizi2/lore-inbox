Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272752AbTG1I7m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 04:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272759AbTG1I7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 04:59:42 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:29200 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S272752AbTG1I7k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 04:59:40 -0400
Date: Mon, 28 Jul 2003 02:14:50 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: malloc problem to allocate very large blocks
Message-ID: <20030728091450.GC1333@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <20030728064428.GA32138@xcin> <20030728083730.GB1333@pegasys.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030728083730.GB1333@pegasys.ws>
User-Agent: Mutt/1.3.27i
X-Message-Flag: The contents of this message may cause sleeplessness, irritability, loss of appetite, anxiety, depression, or other psychological disorders.  Consult your doctor if these symptoms persist.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 28, 2003 at 01:37:30AM -0700, jw schultz wrote:
> On Mon, Jul 28, 2003 at 02:44:28PM +0800, Tung-Han Hsieh wrote:
> > Hello,
> > 
> > I am developing applications which requires more than 2GB memory.
> > But I found that in my Linux system the malloc() cannot allocate
> > more than 2GB memory. Here is the details of my system:
> 
> Malloc is a library function, not a syscall.
> 
> That said i'm not surprised.  Malloc front-ends sbrk and
> sometimes mmap.  Sbrk uses a ptrdiff_t to indicate the size
> desired.  ptrdiff_t is signed and on 32 bit platforms should
> be 32 bits.  Therefore, the maximum you can allocate at one
> time with sbrk is going to be 2GB.  That malloc would
> inherit this limitation is to be expected.
> 
> If you need to allocate that much memory in one chunk, don't
> use malloc.

And regarding trying to get it in multiple chunks.  That is
likely to fail with sbrk due to the way the address space is
assigned to the various memory areas.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
