Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277550AbRJOPbh>; Mon, 15 Oct 2001 11:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277546AbRJOPbR>; Mon, 15 Oct 2001 11:31:17 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:34630 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S277494AbRJOPbN>; Mon, 15 Oct 2001 11:31:13 -0400
To: Andi Kleen <ak@muc.de>
Cc: Gerhard Mack <gmack@innerfire.net>, Tommy Faasen <tommy@vuurwerk.nl>,
        linux-kernel@vger.kernel.org
Subject: Re: SMP processor rework help needed
In-Reply-To: <k2wv1yhsh4.fsf@zero.aec.at>
	<Pine.LNX.4.10.10110141349510.31660-100000@innerfire.net>
	<20011014230709.47894@colin.muc.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 15 Oct 2001 09:20:25 -0600
In-Reply-To: <20011014230709.47894@colin.muc.de>
Message-ID: <m18zedorpi.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@muc.de> writes:

> On Sun, Oct 14, 2001 at 10:50:50PM +0200, Gerhard Mack wrote:
> > This may sound like a dumb question but wouldn't simply swapping the CPUs
> > have the same affect?
> 
> In theory yes, assuming the determination of the boot cpu is fully
> deterministic. the spec says it is the one with the lowest apic number; but
> who knows if that is true in every weird board.

I do recall that the apics have programmable numbers.  We even test
that as part of our cpu initialization.  So that means little.  

For intel the initial determination is made having the cpus race on
the apic bus.  The cpu that sends a message first gets the lowest
apicid.  Though I need to see how the P4 Xeon does it, as the apic
bus is actually unused.

Also many boards have logic so that allows the second cpu to become the
boot cpu if the first cpu fails to boot.  This logic might be as
simple as round-robin, so even a deterministic may make this
difficult.

So the only reliable way to force the boot cpu is with software that
runs before the operating system, usually the firmware.

I'll keep this in mind for linuxBIOS, as that would be an ideal place
to implement something like that.  

Eric
