Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289378AbSAJKfa>; Thu, 10 Jan 2002 05:35:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289379AbSAJKfK>; Thu, 10 Jan 2002 05:35:10 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:54306 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S289378AbSAJKfG>; Thu, 10 Jan 2002 05:35:06 -0500
Date: Thu, 10 Jan 2002 11:34:22 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@redhat.com>,
        linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: [PATCH] PAGE_SIZE IO for RAW (RAW VARY)
Message-ID: <20020110113421.H3357@inspiron.school.suse.de>
In-Reply-To: <E16ORfZ-0002Zu-00@the-village.bc.nu> <200201092348.g09NmHg25671@eng2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <200201092348.g09NmHg25671@eng2.beaverton.ibm.com>; from pbadari@us.ibm.com on Wed, Jan 09, 2002 at 03:48:17PM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2002 at 03:48:17PM -0800, Badari Pulavarty wrote:
> Alan,
> 
> > 
> > > If it is not reasonable to fix all the brokern drivers,
> > > how about making this configurable (to do variable size IO) ?
> > > Do you favour this solution ?
> > 
> > We have hardware that requires aligned power of two for writes (ie 4K on
> > 4K boundaries only). The 3ware is one example Jeff Merkey found
> > 
> 
> emm.. come to think of it, I can easily (2 line) change my patch to
> do 512 byte buffer heads till we get PAGE alignment and then start
> issuing 4K IO buffer heads. What do you think ? will this work ? 

you should make sure the buffer is naturally aligned with the b_size (so
you emulate the change of blocksize in a filesystem), if it wasn't the
case you should fix it.

> 
> And also, do you know any low level drivers Ben mentioning:
> 
> > low level drivers, some of which assume that 
> > all buffer heads within a request have the same block size.
> 
> Is it still true for 2.4 ? 

yes, you simply need to call submit_bh or to use separate ll_rw_blocks
when you change b_size.

> 
> Regards,
> Badari


Andrea
