Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263185AbTHVQmL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 12:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263243AbTHVQmL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 12:42:11 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:48910 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263185AbTHVQmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 12:42:08 -0400
Date: Fri, 22 Aug 2003 17:42:03 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Matthew Wilcox <willy@debian.org>
Cc: "David S. Miller" <davem@redhat.com>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel@vger.kernel.org, parisc-linux@lists.parisc-linux.org,
       drepper@redhat.com
Subject: Re: [parisc-linux] Re: Problems with kernel mmap (failing tst-mmap-eofsync in glibc on parisc)
Message-ID: <20030822174203.H12903@flint.arm.linux.org.uk>
Mail-Followup-To: Matthew Wilcox <willy@debian.org>,
	"David S. Miller" <davem@redhat.com>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	linux-kernel@vger.kernel.org, parisc-linux@lists.parisc-linux.org,
	drepper@redhat.com
References: <1061563239.2090.25.camel@mulgrave> <20030822091447.6ecea6ca.davem@redhat.com> <20030822163429.GH18834@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030822163429.GH18834@parcelfarce.linux.theplanet.co.uk>; from willy@debian.org on Fri, Aug 22, 2003 at 05:34:29PM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 22, 2003 at 05:34:29PM +0100, Matthew Wilcox wrote:
> On Fri, Aug 22, 2003 at 09:14:47AM -0700, David S. Miller wrote:
> > On 22 Aug 2003 09:40:37 -0500
> > James Bottomley <James.Bottomley@SteelEye.com> wrote:
> > > The reason this doesn't happen is because the mapping is not on the
> > > mmap_shared list that flush_dcache_page() updates.
> > 
> > flush_dcache_page() checks both the shared and non-shared mmap lists,
> > so if it is on _either_ list it is flushed.  It does not check only
> > the shared list.

Eww.

> Gah, that's going to get really inefficient.  I still think we want to
> split flush_dcache_page() into two operations -- flush_dcache_user() and
> flush_dcache_kernel().  flush_dcache_user() would flush this specific
> user mapping back to ram and flush_dcache_kernel() would flush the
> kernel mapping.

Where are you proposing calling only _user() and _kernel() from ?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

