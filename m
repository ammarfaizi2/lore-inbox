Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129055AbRBNCFn>; Tue, 13 Feb 2001 21:05:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129066AbRBNCFc>; Tue, 13 Feb 2001 21:05:32 -0500
Received: from vp175097.reshsg.uci.edu ([128.195.175.97]:24585 "EHLO
	moisil.dev.hydraweb.com") by vger.kernel.org with ESMTP
	id <S129055AbRBNCFW>; Tue, 13 Feb 2001 21:05:22 -0500
Date: Tue, 13 Feb 2001 18:05:19 -0800
Message-Id: <200102140205.f1E25Je02309@moisil.dev.hydraweb.com>
From: Ion Badulescu <ionut@moisil.cs.columbia.edu>
To: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>
Cc: Gerard Roudier <groudier@club-internet.fr>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Donald Becker <becker@scyld.com>,
        Linux-Kernel <linux-kernel@vger.kernel.org>,
        Jes Sorensen <jes@linuxcare.com>
Subject: Re: [PATCH] starfire reads irq before pci_enable_device.
In-Reply-To: <200102132029.f1DKTGM01731@moisil.dev.hydraweb.com>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.2.18 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Feb 2001 12:29:16 -0800, Ion Badulescu <ionut@moisil.cs.columbia.edu> wrote:
> On Tue, 13 Feb 2001 07:06:44 -0600 (CST), Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com> wrote:
> 
>> On 12 Feb 2001, Jes Sorensen wrote:
>>> In fact one has to look out for this and disable the feature in some
>>> cases. On the acenic not disabling Memory Write and Invalidate costs
>>> ~20% on performance on some systems.
>> 
>> And in another message, On Mon, 12 Feb 2001, David S. Miller wrote:
>>> 3) The acenic/gbit performance anomalies have been cured
>>>    by reverting the PCI mem_inval tweaks.
>> 
>> Just to be clear, acenic should or should not use MWI?

With the zerocopy patch, acenic always disables MWI by default.

>> And can a general rule be applied here?  Newer Tulip hardware also
>> has the ability to enable/disable MWI usage, IIRC.
> 
> And so do eepro100 and starfire. On the eepro100 we're enabling MWI 
> unconditionally, and on the starfire we disable it unconditionally...
> 
> I should probably take a look at acenic's use of PCI_COMMAND_INVALIDATE
> to see when it gets activated. Some benchmarking would probably help,
> too -- maybe later today.

I did some testing with starfire, and the results are inconclusive --
at least on my P-III is makes absolutely no difference. Does it make
a difference on other architectures? sparc64, ia64 maybe? 

I should probably rephrase this: MWI makes no difference on i386, but
it is claimed that using MWI *reduces* performance on some systems.
Are there any systems on which MWI *increases* performance?

I've added some code to the starfire driver that allows changing the
use of MWI at module load time, just in case. By default, it activates
it.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
