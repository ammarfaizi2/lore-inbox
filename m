Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261655AbVCIVha@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261655AbVCIVha (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 16:37:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262450AbVCIVgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 16:36:15 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:17650 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261655AbVCIVfP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 16:35:15 -0500
Subject: Re: [PATCH] 2.6.10 -  direct-io async short read bug
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: suparna@in.ibm.com, Daniel McNeil <daniel@osdl.org>,
       sebastien.dugue@bull.net, "linux-aio@kvack.org" <linux-aio@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050309115348.2b86b765.akpm@osdl.org>
References: <1110189607.11938.14.camel@frecb000686>
	 <20050307223917.1e800784.akpm@osdl.org> <20050308090946.GA4100@in.ibm.com>
	 <1110302614.24286.61.camel@dyn318077bld.beaverton.ibm.com>
	 <1110309508.24286.74.camel@dyn318077bld.beaverton.ibm.com>
	 <1110324434.6521.23.camel@ibm-c.pdx.osdl.net>
	 <1110326043.24286.134.camel@dyn318077bld.beaverton.ibm.com>
	 <20050309040757.GY27331@ca-server1.us.oracle.com>
	 <20050309152047.GA4588@in.ibm.com>  <20050309115348.2b86b765.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1110403885.24286.216.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 09 Mar 2005 13:31:26 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-09 at 11:53, Andrew Morton wrote:
> Suparna Bhattacharya <suparna@in.ibm.com> wrote:
> >
> >  > 	Solaris, which does forcedirectio as a mount option, actually
> >  > will do buffered I/O on the trailing part.  Consider it like a bounce
> >  > buffer.  That way they don't DMA the trailing data and succeed the I/O.
> >  > The I/O returns actual bytes till EOF, just like read(2) is supposed to.
> >  > 	Either this or a fully DMA'd number 4 is really what we should
> >  > do.  If security can only be solved via a bounce buffer, who cares?  If
> >  > the user created themselves a non-aligned file to open O_DIRECT, that's
> >  > their problem if the last part-sector is negligably slower.
> > 
> >  If writes/truncates take care of zeroing out the rest of the sector
> >  on disk, might we still be OK without having to do the bounce buffer
> >  thing ?
> 
> We can probably rely on the rest of the sector outside i_size being zeroed
> anyway.  Because if it contains non-zero gunk then the fs already has a
> problem, and the user can get at that gunk with an expanding truncate and
> mmap() anyway.
> 

Rest of the sector or rest of the block ? Are you implying that, we
already do this, so there is no problem reading beyond EOF to user
buffer ? Or we need to zero out the userbuffer beyond EOF ?


Thanks,
Badari


