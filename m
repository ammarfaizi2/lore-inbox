Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751054AbWJWUfZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054AbWJWUfZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 16:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751076AbWJWUfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 16:35:24 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:27625 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751054AbWJWUfY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 16:35:24 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Avi Kivity <avi@qumranet.com>
Subject: Re: [PATCH 5/13] KVM: virtualization infrastructure
Date: Mon, 23 Oct 2006 22:35:29 +0200
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <453CC390.9080508@qumranet.com> <200610232135.02684.arnd@arndb.de> <453D2604.5010208@qumranet.com>
In-Reply-To: <453D2604.5010208@qumranet.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200610232235.29287.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 23 October 2006 22:28, Avi Kivity wrote:

> >> +struct segment_descriptor {
> >> +    u16 limit_low;
> >> +    u16 base_low;
> >> +    u8  base_mid;
> >> +    u8  type : 4;
> >> +    u8  system : 1;
> >> +    u8  dpl : 2;
> >> +    u8  present : 1;
> >> +    u8  limit_high : 4;
> >> +    u8  avl : 1;
> >> +    u8  long_mode : 1;
> >> +    u8  default_op : 1;
> >> +    u8  granularity : 1;
> >> +    u8  base_high;
> >> +} __attribute__((packed));
> >>    
> >
> > Bitfields are generally frowned upon. It's better to define
> > constants for each of these and use a u64.
>
> Any specific reasons?  I find the code much more readable (and
> lowercase) with bitfields.

The strongest reason against bitfields is that they are not
endian-clean. This doesn't apply on a architecture-specific
patch such as KVM, but it just feels wrong to read code
with bit fields in the kernel.

> The structure's size is defined by the hardware (struvt vmcs is just a
> header).  In addition, current_vmcs changes when another guest is
> switched in (it is somewhat like the scheduler's current for the VT
> hardware).

Ok, I see.

> >> +static long kvm_dev_ioctl(struct file *filp,
> >> +                      unsigned int ioctl, unsigned long arg)
> >> +{
> >> +    struct kvm *kvm = filp->private_data;
> >> +    int r = -EINVAL;
> >> +
> >> +    switch (ioctl) {
> >> +    default:
> >> +            ;
> >> +    }
> >> +out:
> >> +    return r;
> >> +}
> >>    
> >
> > Huh? Just leave out stuff like this. If the ioctl function is introduced
> > in a later patch, you can still add the whole function there. 
>
> Several different patches add content here, so I thought I wouldn't play
> favorite.
>
> It also makes reordering the patches a little less painful.  Any tips on
> that or is that a normal ramp up?  I'm using quilt for now and syncing
> to a conventional source control repository.

I saw later how you add specific calls to this function. I guess it's
already as good as it gets, so just leave it this way.

	Arnd <><
