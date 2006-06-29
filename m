Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932256AbWF2TMm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256AbWF2TMm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 15:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932263AbWF2TMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 15:12:42 -0400
Received: from wx-out-0102.google.com ([66.249.82.198]:51095 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932256AbWF2TMl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 15:12:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=g+r6rKCYKdJ1Re662sUQkbD4G7H83uN4fm0qqMuFRpb3T0kxmnwCr9SzvF0CvqLxfktO3IUsVVCG3wsQ4tjoUQX16Yum5Ci43f+lgCRnFf9u/Suu38gkPlKd42QAWrbmTP6S4YKFMkCsTSxRZieVFa5g78LGqq7BBgtaFylWQ9I=
Message-ID: <39f633820606291212v40b0016cl@mail.gmail.com>
Date: Thu, 29 Jun 2006 21:12:40 +0200
From: "Robert Nagy" <robert.nagy@gmail.com>
To: "Jesse Barnes" <jbarnes@virtuousgeek.org>
Subject: Re: Intel RAID Controller SRCU42X in SGI Altix 350
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200606291132.51866.jbarnes@virtuousgeek.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <39f633820606290818g1978866ap@mail.gmail.com>
	 <200606291132.51866.jbarnes@virtuousgeek.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've tried the diff but there is no difference.
I've also tried to use the EFI driver from Intel, but that did not work either.

2006/6/29, Jesse Barnes <jbarnes@virtuousgeek.org>:
> On Thursday, June 29, 2006 8:18 am, Robert Nagy wrote:
> > Hi,
> >
> > Distribution: Debian testing/unstable
> > Hardware Environment: SGI Altix 350, 2xItanium 2, EFI (read dmesg)
> > http://bsd.hu/~robert/altix.dmesg
> > http://bsd.hu/~robert/altix.kconf
> >
> > Problem Description: I've installed an Intel(r) RAID Controller
> > SRCU42X (PCI-X) controller to this machine.
> > http://www.intel.com/design/servers/raid/srcu42x/index.htm
> > I've never used such a controller so if someone has any idea about
> > this please tell me. The dmesg will show everyhing, but:
> >
> > megaraid cmm: 2.20.2.6 (Release Date: Mon Mar 7 00:01:03 EST 2005)
> > megaraid: 2.20.4.8 (Release Date: Mon Apr 11 12:27:22 EST 2006)
> > megaraid: probe new device 0x1000:0x0407:0x8086:0x0532: bus 2:slot
> > 0:func 0 megaraid: out of memory, megaraid_alloc_cmd_packets 965
> > megaraid: maibox adapter did not initialize
>
> IIRC some Altix boxes don't support 32 bit DMA for PCI-X devices.  Based
> on the initialization code I looked at (just a quick scan), it looks
> like the command packet initialization is done before the switch to a 64
> bit DMA mask, which might cause the failure you see here.  You can try
> this patch out (totally untested).  It's not fully correct, it should
> probably try 64 bit first then fall back to 32 bit if that fails then
> give up, and the other 64 bit DMA mask call should probably be removed.
>
> Anyway, good luck.  If this one doesn't work you'll have to talk with one
> of the SGI guys and get some more debug info about the allocation
> failure for the command packets.
>
> Jesse
>
>
>
