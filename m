Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267099AbSK2QJR>; Fri, 29 Nov 2002 11:09:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267101AbSK2QJR>; Fri, 29 Nov 2002 11:09:17 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:18127 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S267099AbSK2QJQ>; Fri, 29 Nov 2002 11:09:16 -0500
Date: Fri, 29 Nov 2002 17:16:33 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Alan Cox <alan@redhat.com>, johnstul@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-rc4-ac1
Message-ID: <20021129161633.GG6981@fs.tum.de>
References: <20021128130112.GB6981@fs.tum.de> <1568261310.1038471302@[10.10.2.3]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568261310.1038471302@[10.10.2.3]>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 28, 2002 at 08:15:02AM -0800, Martin J. Bligh wrote:

> > Martin, could you please review whether the patch below which does the
> > following is correct?
> > 
> > - kill the last occurence of CLUSTERED_APIC_NUMAQ
> > - only one definition of PCI_CONF1_ADDRESS is needed
> >   (#ifndef CONFIG_MULTIQUAD the BUS2LOCAL() has no effect)
> > - fix an #endif comment
> 
> I'm confused at to what made this break recently .... what release 
> did this break on? Either it was something very recent, everyone 
> else is asleep, or you're doing something wierd (like compling with
> MULTIQUAD on?)

Yes, I tried a compilation with MULTIQUAD on.

The "very recent" might be that I'm talking about -ac (look at the
Subject).

> CLUSTERED_APIC_NUMAQ is a part of the Summit patch introduction, 
> where John (cc'ed) splits clustered_apic_mode from a boolean into
> a switch (in 2.4 ... I did 2.5 differently). Maybe we merged half
> of a summit patch somehow, and didn't get the define?
>...

First of all:
I noticed this problem while doing a compile-only test, I have no real
knowledge of the code.

In 2.4.20-pre the following change was made in several places:
  clustered_apic_mode -> (clustered_apic_mode == CLUSTERED_APIC_NUMAQ)

In 2.4.20-pre-ac they were changed again, this time
  (clustered_apic_mode == CLUSTERED_APIC_NUMAQ) -> clustered_apic_logical

According to grep the occurence of CLUSTERED_APIC_NUMAQ my patch changes
was the last one _in the whole kernel sources of 2.4.20-rc4-ac1_.

It might be that my patch is wrong but there's undoubtable something
that needs to be fixed.

> M.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

