Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262636AbSJPSWk>; Wed, 16 Oct 2002 14:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262645AbSJPSWj>; Wed, 16 Oct 2002 14:22:39 -0400
Received: from maila.telia.com ([194.22.194.231]:25852 "EHLO maila.telia.com")
	by vger.kernel.org with ESMTP id <S262636AbSJPSWj>;
	Wed, 16 Oct 2002 14:22:39 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
To: Johannes Erdfelt <johannes@erdfelt.com>
Cc: David Brownell <david-b@pacbell.net>, Greg KH <greg@kroah.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] 2.5.40 panic in uhci-hcd
References: <Pine.LNX.4.44.0210082025570.16233-100000@p4.localdomain>
	<3DA34204.1030708@pacbell.net> <m2n0peuw5e.fsf@p4.localdomain>
	<20021016133443.U32760@sventech.com>
From: Peter Osterlund <petero2@telia.com>
Date: 16 Oct 2002 20:28:22 +0200
In-Reply-To: <20021016133443.U32760@sventech.com>
Message-ID: <m2ptuatf09.fsf@p4.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Erdfelt <johannes@erdfelt.com> writes:

> On Wed, Oct 16, 2002, Peter Osterlund <petero2@telia.com> wrote:
> > 
> > The problem is back in 2.5.43, although it doesn't happen on every
> > boot. I think I first saw this problem in 2.5.35.
> > 
> > The oops looks the same as usual. The oops happens because urb->hcpriv
> > is NULL in uhci_result_control() so the list_empty() check oopses.
> > 
> > At the end of uhci_urb_enqueue() this code
> > 
> > 	if (ret != -EINPROGRESS) {
> > 		uhci_destroy_urb_priv (uhci, urb);
> > 		return ret;
> > 	}
> > 
> > appears to be calling uhci_destroy_urb_priv() without having acquired
> > the urb_list_lock. Can this be the cause of my problem?
> 
> Have you tried this patch? It's in Greg's BK tree, but hasn't been
> picked up by Linus yet.

I applied it to 2.5.39 (which always died at boot before this patch)
and now it boots without problems, so this looks like the correct fix
for my problem. Thanks.

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
