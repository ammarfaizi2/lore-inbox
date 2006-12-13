Return-Path: <linux-kernel-owner+w=401wt.eu-S1751800AbWLMXjd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751800AbWLMXjd (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 18:39:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751803AbWLMXjd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 18:39:33 -0500
Received: from wx-out-0506.google.com ([66.249.82.226]:33373 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751800AbWLMXjc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 18:39:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JoTZ7uedV5XTI8MFWhLCIJY+htl8Lz7x3PVo4uNYjQuIzaGvkiA3WmHktnK+e37QPWPgahnBZAxledzJMHqDCT4I9faNVu2y+kWdOZXkkP98sfjaYHQBt5NXAc2nISVazh8s+CPxGUToa4Z1Io/g6DVGtsZju6u1uEVambrHg8Y=
Message-ID: <f2b55d220612131539jdbaf6e2g3444d7f77b9a1421@mail.gmail.com>
Date: Wed, 13 Dec 2006 15:39:28 -0800
From: "Michael K. Edwards" <medwards.linux@gmail.com>
To: tglx@linutronix.de
Subject: Re: [GIT PATCH] more Driver core patches for 2.6.19
Cc: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
       "Linus Torvalds" <torvalds@osdl.org>, "Greg KH" <gregkh@suse.de>,
       "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1166051517.29505.66.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061213195226.GA6736@kroah.com>
	 <Pine.LNX.4.64.0612131205360.5718@woody.osdl.org>
	 <1166044471.11914.195.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0612131323380.5718@woody.osdl.org>
	 <1166048081.11914.208.camel@localhost.localdomain>
	 <1166049055.29505.47.camel@localhost.localdomain>
	 <1166049549.11914.218.camel@localhost.localdomain>
	 <1166051517.29505.66.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/06, Thomas Gleixner <tglx@linutronix.de> wrote:
> Aside of that there are huge performance gains for certain application /
> driver scenarios and I really don't see an advantage that people are
> doing excactly the same thing in out of tree hackeries with a lot of
> inconsistent user land interfaces.

Greg's effort is noble but I think it is targeted at the wrong problem
and would actually make things worse.  Inconsistent interfaces from
one "driver" to another are the surface design flaw that obscures the
fundamental design flaw of exposing hardware to userland: abdication
of the driver writer's responsibility to choose and justify which
things belong in the driver and which belong in a hardware-agnostic
driver framework or a userspace library instead.

When you are talking about unique, one-off hardware, it doesn't really
matter whether the shim for a closed, out-of-tree, userspace driver
fits into a framework or not.  Who cares whether they use the
preferred MMIO reservation paths or just throw ioctl(POKE_ME_HARDER)
or mmap(/dev/mem) at the problem?  But I don't want to see ALSA or
iwconfig or i2c-core or any of the other competently designed and
implemented driver frameworks mangled into unusability by attempts to
facilitate this "design pattern".

Truth in advertising is an advantage even if it doesn't change the
underlying reality.  I can (and do) tell chip vendors, "that's not a
driver, that's a shim for some other customer's pre-existing eCos
task", and justify the cost of writing an actual driver to the client.
 I may or may not succeed in arguing that the new driver should be
designed to an existing API when that means rethinking the userspace
app, or that it should be implemented against a current kernel and
offered promptly up to the appropriate Linus lieutenant.  But at least
the project isn't crippled by confusion about whether or not the
existing blob constitutes a driver.

Cheers,
- Michael
