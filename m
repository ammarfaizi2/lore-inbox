Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313930AbSDUXC4>; Sun, 21 Apr 2002 19:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313933AbSDUXC4>; Sun, 21 Apr 2002 19:02:56 -0400
Received: from panic.tn.gatech.edu ([130.207.137.62]:1970 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S313930AbSDUXCz>;
	Sun, 21 Apr 2002 19:02:55 -0400
Date: Sun, 21 Apr 2002 19:02:55 -0400
From: Jeff Garzik <garzik@havoc.gtf.org>
To: "Ivan G." <ivangurdiev@yahoo.com>
Cc: Urban Widmark <urban@teststation.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: your mail
Message-ID: <20020421190255.B22314@havoc.gtf.org>
In-Reply-To: <02042115164004.00745@cobra.linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 21, 2002 at 03:16:40PM -0600, Ivan G. wrote:
> Urban,
> 
> About the suggestion to make via_rhine_error handle more interrupts,
> 
> enum intr_status_bits {
>         IntrRxDone=0x0001, IntrRxErr=0x0004, IntrRxEmpty=0x0020,
>         IntrTxDone=0x0002, IntrTxAbort=0x0008, IntrTxUnderrun=0x0010,
>         IntrPCIErr=0x0040,
>         IntrStatsMax=0x0080, IntrRxEarly=0x0100, IntrMIIChange=0x0200,
>         IntrRxOverflow=0x0400, IntrRxDropped=0x0800, IntrRxNoBuf=0x1000,
>         IntrTxAborted=0x2000, IntrLinkChange=0x4000,
>         IntrRxWakeUp=0x8000,
>         IntrNormalSummary=0x0003, IntrAbnormalSummary=0xC260,
> };
> 
> RxEarly, RxOverflow, RxNoBuf are not handled
> (which brings up another question - how should they be handled 
> and where?? It doesn't seem to me that those should end up in error,
> sending CmdTxDemand. )

*blink*  I had not noticed that.

All drivers actually need to handle RxNoBufs and RxOverflow, assuming
they have similar meaning to what I'm familiar with on other chips.
The chip may recover transparently, but one should be at least aware of
them.

RxEarly you very likely do -not- want to handle...

	Jeff




