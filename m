Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031262AbWK3TeW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031262AbWK3TeW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 14:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031264AbWK3TeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 14:34:22 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:60574 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1031262AbWK3TeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 14:34:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=V8m6aB+DQhDnzSMuq2t4ssDudVe6bWGVG2NtjcTl/tSBBULqgNFIoH82oyVB39h/p/N/dvTQDvyLYK4J8QOqDN0GLS0B8x1SRITcT1mBh7osJh+p8jZwyg1vRJLJgNK39p4ep/941gea+/mZO/EPcImd8VwhmJ0HVIzwo3I4IKE=
Message-ID: <4807377b0611301134q33d1cd78l5a1f2eda33da21bc@mail.gmail.com>
Date: Thu, 30 Nov 2006 11:34:19 -0800
From: "Jesse Brandeburg" <jesse.brandeburg@gmail.com>
To: "Amin Azez" <azez@ufomechanic.net>
Subject: Re: e100 breakage located
Cc: linux-kernel@vger.kernel.org, Michael.ODonnell@stratus.com,
       "NetDEV list" <netdev@vger.kernel.org>,
       "Auke Kok" <auke-jan.h.kok@intel.com>
In-Reply-To: <45641A4E.6020505@ufomechanic.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <45641A4E.6020505@ufomechanic.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sorry for the delay, your mail got marked as spam.  In the future
please copy networking issues to netdev@vger.kernel.org, and be sure
to copy the maintainers of the driver you're having problems with
(they are in the MAINTAINERS file)

On 11/22/06, Amin Azez <azez@ufomechanic.net> wrote:
> I notice a patch in 2005 from Micahel O'Donnel to the e100.c driver has
> stopped auto-crossover working on some e100 devices we use.
>
> On one system the auto-negotiation was restored by commenting out:
> (nic->mac == mac_82551_10) in function e100_phy_init where the MDI/MDI-X
> is disabled.

are you sure that patch did that?  What version of e100 are you using?
we've since enabled MDI-X on most parts with this patch:
http://git.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=60ffa478759f39a2eb3be1ed179bc3764804b2c8;hp=09e590e5d5a93f2eaa748a89c623258e6bad1648

Please try the latest kernel or the latest e100 available from e1000.sf.net
if that doesn't work we'll need to know what kernel are you using?

> lspci reports:
>  01:04.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100]
> (rev 10)
>  01:04.0 Class 0200: 8086:1229 (rev 10)
>
> and on another device
>  01:05.0 Ethernet controller: Intel Corp. 82559ER (rev 10)
>  01:01.0 Class 0200: 8086:1209 (rev 10)
>
> So it is true that we are revision 10, but 82557/9 not 82551.

you're getting confused between decimal and hex.  82551 is rev 16 (0x10)

> I must confess that having gotten this far, I am lost. Of course I can
> "fix" the driver for our hardware but I am not sure how to contrive a
> general fix.
>
> Maybe the actual damage is done in
>  e100_get_defaults(struct nic *nic)
> where nic->mac is set to nic->rev_id ?
>
> But it generally seems to be a failure to take into account the actual
> hardware type, and only consider the revision.

the only relevant way to tell e100 parts apart is the revision id
