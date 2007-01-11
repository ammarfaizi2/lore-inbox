Return-Path: <linux-kernel-owner+w=401wt.eu-S1750993AbXAKRjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750993AbXAKRjv (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 12:39:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751002AbXAKRju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 12:39:50 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:44403 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750981AbXAKRjt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 12:39:49 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=eH7vMQZKq08Nq6Quuufbi+PtN/0EetNdtHB9dG9tTzkB8nKe6iuF25mBfFCz6dLDy8PWqo6oXWZGweHGva7iVVg/r5G0ON28lj0Lf0/nMEV22ZxFJ0y9+0F3j/TNmDM0KybrCf/GMdNaoirpwqWrdqfw4WGvsnSmkCh3vjmBeyw=
Message-ID: <13426df10701110939k21f7bb1dy38d2b34ca37a5a36@mail.gmail.com>
Date: Thu, 11 Jan 2007 10:39:47 -0700
From: "ron minnich" <rminnich@gmail.com>
To: "OLPC Developer's List" <devel@laptop.org>,
       "Linux Kernel ML" <linux-kernel@vger.kernel.org>,
       "Mitch Bradley" <wmb@firmworks.com>
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mitch Bradley wrote:
> Request for comments.

Sorry to revive this thread, I just ran through the discussion. I'm
about 50% in agreement with the idea.

I'd like to put in my $.02 in favor of having a way to pass the OF
device tree to the kernel, in much the same way we pass stuff like
ACPI and PIRQ and MP tables now.

I'd like to also put in my $.02 in OPPOSITION go doing this via
callofw() or any bios callback mechanism.

We have hoped, for some years now, to use the OF device tree as a way
to pass information from (e.g.) LinuxBIOS to the kernel. It seemed
like a solid and tested path. The various kernels understand the tree,
especially non-linux kernels which LinuxBIOS boots. It's a simple
format and well-designed, unlike ACPI. We have always though it was a
very nice design.

But any mechanism that depends on a callback to OFW is way too
limiting. As soon as you put that callback in, you lock out
- uBoot
- LinuxBIOS
- Bochs BIOS as used in Xen and other hypervisors and emulators
- any path that uses kexec (since the first kernel probably shut down
   OF)
- etherboot
- GNUFI

So, while the idea of the OF tree is very general, and IMHO very
desirable, the idea of the callback is very specific to one firmware
implementation on one CPU architecture on one platform -- the OLPC --
and is hence not desirable at all.

An idea that is potentially applicable and usable on all BIOSes
becomes usable on only one.

OFW is open source now. I think it's time to reexamine the basic
assumptions about the need for a callback, and see if something better
can't be done. Also, as others mentioned, callback into any sort of
firmware on SMP can and does get messy. I've seen this in practice on
EFI-based machines.

Otherwise, this is just too limited to be of any use to those of us
doing more than just OFW.

Mitch, is there some way to get OF device tree to the kernel without
involving a callback? That would be quite nice.

thanks

ron
