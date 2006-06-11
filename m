Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932384AbWFKBQN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384AbWFKBQN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 21:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932538AbWFKBQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 21:16:13 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:19770 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932384AbWFKBQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 21:16:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=IUmbsHseb0iuSquZvKNBF/NGidC1/0ahmVJa5Hze5k/Zu54Mea+1tUFq6Qnm8FXH5a5pKZg15FoVZ1DtqFvIr1n7aS4B4SVZ264UeHxhZBiRLb2E+qu/dy6zdJzfSXWmI8UgvJeZXuWZfQ1t1p6Ak75IpLLLYRAkLDFwRzXZjsY=
Message-ID: <448B6ED3.5060408@gmail.com>
Date: Sun, 11 Jun 2006 09:16:03 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
Subject: Re: [PATCH 5/5] VT binding: Add new doc file describing the feature
References: <44893407.4020507@gmail.com>	 <9e4733910606092253n7fe4e074xe54eaec0fe4149f3@mail.gmail.com>	 <448AC8BE.7090202@gmail.com>	 <9e4733910606100916r74615af8i34d37f323414034c@mail.gmail.com>	 <448B38F8.2000402@gmail.com>	 <9e4733910606101644j79b3d8a5ud7431564f4f42c7f@mail.gmail.com>	 <448B61F9.4060507@gmail.com> <9e4733910606101749r77d72a56mbcf6fb3505eb1de0@mail.gmail.com>
In-Reply-To: <9e4733910606101749r77d72a56mbcf6fb3505eb1de0@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:
> On 6/10/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
>> > I see now that you can have tty0-7 assigned to a different console
>> > driver than tty8-63.
>> > Why do I want to do this?
>>
>> Multi-head.  I can have vgacon on the primary card for tty0-7,
>> fbcon on the secondary card for tty8-16.
> 
> That's what I thought, I couldn't see any other reason. The kernel
> doesn't support input from multiple users so multihead can only be
> used by a single user.
> 
> Does anyone use single user multihead on current systems? The kernel
> doesn't have code in it to initialize secondary VGA cards. What modern
> non-VGA hardware does this work on?

matroxfb supports multihead and fbcon already has this feature for a
long time, ie you can bind /dev/fb0 to tty0-3 and /dev/fb1 to tty4-6.
And there are definite users because I happen to break this feature once
and I got rained with complaints :-)

> 
> If this feature doesn't work on current hardware, could it be dropped?
> It would make binding to the vt system much simpler if only one driver
> could be bound at a time. Anything we do to make that system simpler
> would benefit everyone.

You can't drop something that's already in the kernel and has users, well,
the binding part at least. What we don't currently have is the fine-grained
control and because of the reason's you mentioned, I said that it's for the
future.

(Note1: fbcon already has support to selectively bind/unbind drivers
to specific tty's, using the con2fbmap utility.)

So what we have is control for wholescale binding and unbinding of
drivers, which essentially results in only 1 driver loaded at one time.

(Note2: fbcon already has an option to determine what range of vc's to
control, as a kernel boot parameter, so we can't just drop something 
that's already supported by one driver at least.  Though I know of no one,
including myself, who uses this feature.)

> 
> At some future point I would like to explore pushing the VT system out
> to user space where it becomes much easier to make it multi-user and
> multi-head. If you do that, something like a single user, in-kernel
> system management console makes more sense.

Yes.

Tony
 

