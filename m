Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270451AbRHQTUg>; Fri, 17 Aug 2001 15:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270495AbRHQTU0>; Fri, 17 Aug 2001 15:20:26 -0400
Received: from chaos.analogic.com ([204.178.40.224]:34176 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S270451AbRHQTUM>; Fri, 17 Aug 2001 15:20:12 -0400
Date: Fri, 17 Aug 2001 15:20:19 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: David Christensen <David_Christensen@Phoenix.com>,
        Holger Lubitz <h.lubitz@internet-factory.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Encrypted Swap
In-Reply-To: <m11ymaplzm.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.3.95.1010817151211.4584A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Aug 2001, Eric W. Biederman wrote:

> "Richard B. Johnson" <root@chaos.analogic.com> writes:
> 
> > On Fri, 17 Aug 2001, David Christensen wrote:
> > 
> > > > > Ryan Mack proclaimed:
> > > Most modern firmware does NOT clear memory during POST, it takes too long.
> 
> Clearing memory on most machines takes a 1s or less.  Think of memory
> fill rates at the 800MB/s level.  Most BIOS's seem to clear some of
> the memory but I haven't read their code to see what they are doing.
> 
> > > Certain compatibility areas are usually cleared (such as the 1st megabyte)
> > > but the rest is
> > > left as is, except for a few read/writes (usually on a megabyte boundary).
> > > The 
> > > exception to this rule is ECC systems.  They have to be written to make sure
> > > the 
> > > ECC information is correct.  
> Correct.
> 
> > > SDRAM memory sizing is usually done by reading an EEPROM on the SDRAM DIMM.
> > > The BIOS doesn't need to guess the correct timing values, it simply reads
> > > the EEPROM and programs the memory controller.  In the case of a BIOS that
> > > doesn't use EEPROM you might lose data as the BIOS iteratively tries 
> > > different memory timings and tests if they work.
> 
> This would totally depend on your controller.  But different timings
> shouldn't affect your memory cells just the read/write paths to your
> memory.
> 
> > > I have done work implementing ACPI S3 (suspend-to-RAM) in DOS by simply
> > > hitting 
> > > the RESET button and restoring the memory controller settings.  The contents
> > > of 
> > > RAM have always been valid.
> 
> Hmm.  That sounds a little risky.  I have measured single bit errors
> occuring as early as 1s after writing the data without somekind of
> refresh running.
> 
> > > David Christensen
> > > 
> > 
> > I just posted working SDRAM controller initialization code. The SDRAM
> > controller must be initialized in a specific step-by-step manner or
> > else you don't even get to "restoring the memory controller settings".
> 
> Comments frequently don't match the code.  And how the SDRAM controller
> must be initialized totally depends on the chipset and vendor.  SDRAM
> itself must be initialized in a specific matter.  
> 

That's what I said, and the comments match the code.

> But for the case of a warm reset there is not need to reset the SDRAM
> controller.  Memory really only needs to be cleared in the case when
> some form of error checking is being used.
>

Memory needs to be written (with anything). It must be written before
it's used so that there are no "almost" logic levels within the cells.

The parasitic currents from having some cells "just barely on" will
totally screw up data retention in other cells. If anybody ever
writes memory initialization software that doesn't perform this
extremely important step, they just don't know what the hell they are
doing and will contribute towards a poor reputation for software
engineering.

> Personally I think writing such code carries more credibility then
> simply posting it anyway....
> 

Well I wrote the code. And I have written SDRAM initialization code
for many chip-sets.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


