Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135991AbRDTTGF>; Fri, 20 Apr 2001 15:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135990AbRDTTFz>; Fri, 20 Apr 2001 15:05:55 -0400
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:30094 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S135991AbRDTTFc>; Fri, 20 Apr 2001 15:05:32 -0400
Date: Fri, 20 Apr 2001 19:51:50 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Venkatesh Ramamurthy <venkateshr@softhome.net>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: RFC: pageable kernel-segments
Message-ID: <20010420195150.A7325@redhat.com>
In-Reply-To: <040201c0c9a5$87d05c60$7253e59b@megatrends.com> <E14qcE1-0001Pu-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14qcE1-0001Pu-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Apr 20, 2001 at 03:49:30PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Apr 20, 2001 at 03:49:30PM +0100, Alan Cox wrote:

> There is a proposal (several it seems) to make 2.5 replace the conventional
> unix swap with a filesystem of backing store for anonymous objects. That will
> mean each object has its own vm area and inode and thus we can start blowing
> away all user mode page tables when we want.

Not without major VM overhaul.

The problem is MAP_PRIVATE, where a single vma can contain both normal
file-backed pages and anonymous pages at the same time.  You don't
even know whose anonymous page it is --- a process with anon pages can
fork, so that later on some of the child's anon pages actually come
from the parent's anon space instead of the child's.

Right now all of the magic that makes this work is in the page tables.
To remove page tables we'd need additional structures all through the
VM to track anonymous pages, and that's exactly where the FreeBSD VM
starts to get extremely messy compared to ours.

--Stephen
