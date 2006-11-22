Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162038AbWKVKzL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162038AbWKVKzL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 05:55:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162016AbWKVKzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 05:55:10 -0500
Received: from nz-out-0102.google.com ([64.233.162.204]:11021 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1162038AbWKVKzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 05:55:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TnVY8ydKwqDPelCh605EzkuTIIMdUaCgpUfyxl7AcH55LpcqKxkut2bVEdlRdMqcDKxwjuZu1nh81OHyPcrGZOflU2zPskYpzCYYpghGnA8/gtBw7p8VXlTRVBZGVHzrg/rJ++Axf9mbJvPbMBbgCJfCqSzfmyYjVYtWhzypkD8=
Message-ID: <9a8748490611220255v53bc667y74b05e2b69281f25@mail.gmail.com>
Date: Wed, 22 Nov 2006 11:55:08 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Jens Axboe" <jens.axboe@oracle.com>
Subject: Re: Simple script that locks up my box with recent kernels
Cc: "Linus Torvalds" <torvalds@osdl.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <20061122080312.GL8055@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0610062000281.3952@g5.osdl.org>
	 <Pine.LNX.4.64.0610071408220.3952@g5.osdl.org>
	 <9a8748490610081633k7bf011d1q131b2f9e06f2808d@mail.gmail.com>
	 <9a8748490610161545i309c416aja4f39edef8ea04e2@mail.gmail.com>
	 <Pine.LNX.4.64.0610161554140.3962@g5.osdl.org>
	 <9a8748490610161613y7c314e64rfdfafb4046a33a02@mail.gmail.com>
	 <9a8748490610231330y65f3e243pe1101d11a28dbbfa@mail.gmail.com>
	 <9a8748490611211646o2c92564dmfe8d6ffdf66228ba@mail.gmail.com>
	 <Pine.LNX.4.64.0611211827590.3338@woody.osdl.org>
	 <20061122080312.GL8055@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/11/06, Jens Axboe <jens.axboe@oracle.com> wrote:
> On Tue, Nov 21 2006, Linus Torvalds wrote:
> > I don't think we use any irq-disable locking in the VM itself, but I could
> > imagine some nasty situation with the block device layer getting into a
> > deadlock with interrupts disabled when it runs out of queue entries and
> > cannot allocate more memory..
>
> Not likely. Request allocation is done with GFP_NOIO and backed by a
> memory pool, so as long the vm doesn't go totally nuts because
> __GFP_WAIT is set, we should be safe there. If it did go crazy, I
> suspect a sysrq-t would still work.
>
> If bouncing is involved for swap, we do have a potential deadlock issue
> that isn't fixed yet. I just whipped up this completely untested patch,
> it should shed some light on that issue.
>
Thanks Jens, I'll apply that later tonight and force a few lockups and
see if I get any extra details with that patch.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
