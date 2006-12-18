Return-Path: <linux-kernel-owner+w=401wt.eu-S1753952AbWLRNSg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753952AbWLRNSg (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 08:18:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753987AbWLRNSg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 08:18:36 -0500
Received: from smtp-vbr3.xs4all.nl ([194.109.24.23]:2967 "EHLO
	smtp-vbr3.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753952AbWLRNSf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 08:18:35 -0500
X-Greylist: delayed 679 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Dec 2006 08:18:34 EST
Date: Mon, 18 Dec 2006 14:07:02 +0100
From: Erik Mouw <mouw@nl.linux.org>
To: Manish Regmi <regmi.manish@gmail.com>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       kernelnewbies@nl.linux.org
Subject: Re: Linux disk performance.
Message-ID: <20061218130702.GA14984@gateway.home>
References: <652016d30612172007m58d7a828q378863121ebdc535@mail.gmail.com> <1166431020.3365.931.camel@laptopd505.fenrus.org> <652016d30612180439y6cd12089l115e4ef6ce2e59fe@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <652016d30612180439y6cd12089l115e4ef6ce2e59fe@mail.gmail.com>
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 18, 2006 at 06:24:39PM +0545, Manish Regmi wrote:
> On 12/18/06, Arjan van de Ven <arjan@infradead.org> wrote:
> >if you want truely really smooth writes you'll have to work for it,
> >since "bumpy" writes tend to be better for performance so naturally the
> >kernel will favor those.
> >
> >to get smooth writes you'll need to do a threaded setup where you do an
> >msync/fdatasync/sync_file_range on a frequent-but-regular interval from
> >a thread. Be aware that this is quite likely to give you lower maximum
> >performance than the batching behavior though.
> >
> 
> Thanks...
> 
> But isn't O_DIRECT supposed to bypass buffering in Kernel?

It is.

> Doesn't it directly write to disk?

Yes, but it still uses an IO scheduler.

> I tried to put fdatasync() at regular intervals but there was no
> visible effect.

In your first message you mentioned you were using an ancient 2.6.10
kernel. That kernel uses the anticipatory IO scheduler. Update to the
latest stable kernel (2.6.19.1 at time of writing) and it will default
to the CFQ scheduler which has a smoother writeout, plus you can give
your process a different IO scheduling class and level (see
Documentation/block/ioprio.txt).


Erik
