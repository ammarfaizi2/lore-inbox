Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261663AbVCIPLX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261663AbVCIPLX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 10:11:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbVCIPLX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 10:11:23 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:43490 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261663AbVCIPLU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 10:11:20 -0500
Date: Wed, 9 Mar 2005 20:50:47 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Badari Pulavarty <pbadari@us.ibm.com>, Daniel McNeil <daniel@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       S?bastien Dugu? <sebastien.dugue@bull.net>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.6.10 -  direct-io async short read bug
Message-ID: <20050309152047.GA4588@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <1110189607.11938.14.camel@frecb000686> <20050307223917.1e800784.akpm@osdl.org> <20050308090946.GA4100@in.ibm.com> <1110302614.24286.61.camel@dyn318077bld.beaverton.ibm.com> <1110309508.24286.74.camel@dyn318077bld.beaverton.ibm.com> <1110324434.6521.23.camel@ibm-c.pdx.osdl.net> <1110326043.24286.134.camel@dyn318077bld.beaverton.ibm.com> <20050309040757.GY27331@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050309040757.GY27331@ca-server1.us.oracle.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2005 at 08:07:57PM -0800, Joel Becker wrote:
> On Tue, Mar 08, 2005 at 03:54:04PM -0800, Badari Pulavarty wrote:
> > > 1. return EINVAL if the DIO goes past EOF.
> > > 
> > > 2. truncate the request to file size (which is what your patch does)
> > >     and if it works, it works.
> > > 
> > > 3. truncate the request to a size that actually works - like a multiple
> > >     of 512.
> > > 
> > > 4. Do the full i/o since the user buffer is big enough, truncate the
> > >     result returned to file size (and clear out the user buffer where it
> > >     read past EOF).
> > > 
> > > Number 4 would make it easy on the user-level code, but AIO DIO might be
> > > a bit tricky and might be a security hole since the data would be dma'ed
> > > there and then cleared.  I need to look at the code some more.
> 
> 	Solaris, which does forcedirectio as a mount option, actually
> will do buffered I/O on the trailing part.  Consider it like a bounce
> buffer.  That way they don't DMA the trailing data and succeed the I/O.
> The I/O returns actual bytes till EOF, just like read(2) is supposed to.
> 	Either this or a fully DMA'd number 4 is really what we should
> do.  If security can only be solved via a bounce buffer, who cares?  If
> the user created themselves a non-aligned file to open O_DIRECT, that's
> their problem if the last part-sector is negligably slower.

If writes/truncates take care of zeroing out the rest of the sector
on disk, might we still be OK without having to do the bounce buffer
thing ?

Regards
Suparna

> 
> -- 
> 
> Life's Little Instruction Book #3
> 
> 	"Watch a sunrise at least once a year."
> 
> Joel Becker
> Senior Member of Technical Staff
> Oracle
> E-mail: joel.becker@oracle.com
> Phone: (650) 506-8127
> --
> To unsubscribe, send a message with 'unsubscribe linux-aio' in
> the body to majordomo@kvack.org.  For more info on Linux AIO,
> see: http://www.kvack.org/aio/
> Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

