Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268071AbRHQStO>; Fri, 17 Aug 2001 14:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270012AbRHQStD>; Fri, 17 Aug 2001 14:49:03 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:7035 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S268071AbRHQSsy>; Fri, 17 Aug 2001 14:48:54 -0400
To: root@chaos.analogic.com
Cc: David Christensen <David_Christensen@Phoenix.com>,
        Holger Lubitz <h.lubitz@internet-factory.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Encrypted Swap
In-Reply-To: <Pine.LNX.3.95.1010817131800.2216B-100000@chaos.analogic.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 17 Aug 2001 12:41:49 -0600
In-Reply-To: <Pine.LNX.3.95.1010817131800.2216B-100000@chaos.analogic.com>
Message-ID: <m11ymaplzm.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" <root@chaos.analogic.com> writes:

> On Fri, 17 Aug 2001, David Christensen wrote:
> 
> > > > Ryan Mack proclaimed:
> > Most modern firmware does NOT clear memory during POST, it takes too long.

Clearing memory on most machines takes a 1s or less.  Think of memory
fill rates at the 800MB/s level.  Most BIOS's seem to clear some of
the memory but I haven't read their code to see what they are doing.

> > Certain compatibility areas are usually cleared (such as the 1st megabyte)
> > but the rest is
> > left as is, except for a few read/writes (usually on a megabyte boundary).
> > The 
> > exception to this rule is ECC systems.  They have to be written to make sure
> > the 
> > ECC information is correct.  
Correct.

> > SDRAM memory sizing is usually done by reading an EEPROM on the SDRAM DIMM.
> > The BIOS doesn't need to guess the correct timing values, it simply reads
> > the EEPROM and programs the memory controller.  In the case of a BIOS that
> > doesn't use EEPROM you might lose data as the BIOS iteratively tries 
> > different memory timings and tests if they work.

This would totally depend on your controller.  But different timings
shouldn't affect your memory cells just the read/write paths to your
memory.

> > I have done work implementing ACPI S3 (suspend-to-RAM) in DOS by simply
> > hitting 
> > the RESET button and restoring the memory controller settings.  The contents
> > of 
> > RAM have always been valid.

Hmm.  That sounds a little risky.  I have measured single bit errors
occuring as early as 1s after writing the data without somekind of
refresh running.

> > David Christensen
> > 
> 
> I just posted working SDRAM controller initialization code. The SDRAM
> controller must be initialized in a specific step-by-step manner or
> else you don't even get to "restoring the memory controller settings".

Comments frequently don't match the code.  And how the SDRAM controller
must be initialized totally depends on the chipset and vendor.  SDRAM
itself must be initialized in a specific matter.  

But for the case of a warm reset there is not need to reset the SDRAM
controller.  Memory really only needs to be cleared in the case when
some form of error checking is being used.

Personally I think writing such code carries more credibility then
simply posting it anyway....

Eric
