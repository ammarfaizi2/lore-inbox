Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267215AbSKPEiA>; Fri, 15 Nov 2002 23:38:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267216AbSKPEiA>; Fri, 15 Nov 2002 23:38:00 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:16911 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267215AbSKPEh7>; Fri, 15 Nov 2002 23:37:59 -0500
Date: Sat, 16 Nov 2002 04:44:54 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>, linux-kernel@vger.kernel.org,
       richard@bouska.cz
Subject: Re: NFS mountned  directory  and apache2 (2.5.47)
Message-ID: <20021116044454.A31763@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Petr Vandrovec <VANDROVE@vc.cvut.cz>, linux-kernel@vger.kernel.org,
	richard@bouska.cz
References: <79A23782BB8@vcnet.vc.cvut.cz> <15829.22032.166977.73195@helicity.uio.no> <20021115202649.A18706@infradead.org> <15829.24239.643774.231548@helicity.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <15829.24239.643774.231548@helicity.uio.no>; from trond.myklebust@fys.uio.no on Fri, Nov 15, 2002 at 09:53:03PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2002 at 09:53:03PM +0100, Trond Myklebust wrote:
>      > Linus removed that in early 2.5 because it led to kmap()
>      > deadlocks.  sendfile can fail with EINVAL and userspace must
>      > not rely on it working on any object.
> 
> Fair enough. The kernel may not be the appropriate place for providing
> such an emulation, but there's no reason why glibc shouldn't be able
> to do so for the case where sendfile returns EINVAL.

*nod*

> However none of this changes the matter of the NFS client. The latter
> *does* support a pagecache, and so the one-line patch is appropriate.

just a little bit more then one line :)  nfs needs to do the same
revalidation as in nfs_file_read and then call generic_file_sendfile.

