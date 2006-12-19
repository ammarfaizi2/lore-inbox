Return-Path: <linux-kernel-owner+w=401wt.eu-S932699AbWLSJYV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932699AbWLSJYV (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 04:24:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932709AbWLSJYV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 04:24:21 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:63183 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932699AbWLSJYU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 04:24:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=peQuRcIfoyZKbVfjXRBC8apHCCfmzB4ZB+KhHT8/vyCaDQ21iA2sPf4ZbTA0Vg83YPdadD751TQaMKwNy+1rrWXBMKlK3dJ+Za2RBWnLhMZ1kJYSl5cRK+ekg7NRcUHAO8fFYl1dfxttLzeeq6jnd1fZTieGXm34ZjAenKhetOA=
Message-ID: <d9def9db0612190124i74a336b7j6dd0d0f638d5466e@mail.gmail.com>
Date: Tue, 19 Dec 2006 10:24:18 +0100
From: "Markus Rechberger" <mrechberger@gmail.com>
To: "Chuck Ebbert" <76306.1226@compuserve.com>
Subject: Re: [solved] Yenta Cardbus allocation failure
Cc: linux-kernel@vger.kernel.org,
       "Dominik Brodowski" <linux@dominikbrodowski.net>
In-Reply-To: <200612190359_MC3-1-D590-3237@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200612190359_MC3-1-D590-3237@compuserve.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19/06, Chuck Ebbert <76306.1226@compuserve.com> wrote:
> In-Reply-To: <d9def9db0612181612v657197ees925609243fc1ef65@mail.gmail.com>
>
> On Tue, 19 Dec 2006 01:12:07 +0100, Markus Rechberger wrote:
>
> > I went on with investigating that problem and found the problem,
> > though I'm not sure if that solution is acceptable..
> >
> > seems like the memory range gets preallocated in setup-bus.c, and
> > CARDBUS_MEM_SIZE defines that size.
> >
> > I changed
> > #define CARDBUS_MEM_SIZE        (32*1024*1024)
> > to
> > #define CARDBUS_MEM_SIZE        (48*1024*1024)
> >
> > and now the system is able to allocate the resources for the 3rd
> > pci/pcmcia function.
> >
> > Can anyone please have a closer look at it too? I think the whole
> > implementation isn't really good there..
> >
> > so this is the new output of iomem:
> > $ cat /proc/iomem
> > ...
> > 30000000-35ffffff : PCI Bus #02
> >   30000000-32ffffff : PCI CardBus #03
> > 36000000-360003ff : 0000:00:1f.1
> > 39000000-3bffffff : PCI CardBus #03
> >   39000000-39ffffff : 0000:03:00.0
> >   3a000000-3affffff : 0000:03:00.1
> >   3b000000-3bffffff : 0000:03:00.2 <- this one failed to allocate
> previously
>
> Wow, 3 regions of 16MB each!  Your change fixes this problem for you, but
> what if someone needs four such regions?
>

I documented everything I found about that issue (even the allocated
resources in window$)
http://linuxtv.org/v4lwiki/index.php/Talk:Pinnacle/310c#PCI_allocation_failed

that's why I wrote that the current implementation isn't nice..
I'm currently on the cx88 driver (which needs that memory region) to
get my Pinnacle Cardbus device work..
I won't get back to the PCI subsystem before I'm done with it.

Markus
