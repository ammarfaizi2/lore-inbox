Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262316AbUDOT2n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 15:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262101AbUDOT2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 15:28:43 -0400
Received: from fmr01.intel.com ([192.55.52.18]:29571 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S262316AbUDOT2e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 15:28:34 -0400
Subject: Re: IO-APIC on nforce2 [PATCH]
From: Len Brown <len.brown@intel.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Ross Dickson <ross@datscreative.com.au>, christian.kroener@tu-harburg.de,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.55.0404141220500.17639@jurand.ds.pg.gda.pl>
References: <200404131117.31306.ross@datscreative.com.au>
	 <200404131703.09572.ross@datscreative.com.au>
	 <1081893978.2251.653.camel@dhcppc4>
	 <200404141502.14023.ross@datscreative.com.au>
	 <Pine.LNX.4.55.0404141220500.17639@jurand.ds.pg.gda.pl>
Content-Type: text/plain
Organization: 
Message-Id: <1082057295.24424.149.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 15 Apr 2004 15:28:15 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-04-14 at 06:37, Maciej W. Rozycki wrote:
> On Wed, 14 Apr 2004, Ross Dickson wrote:

> > The clock skew is an interesting one, I think the clock uses tsc if available
> > to interpolate between timer ints and if so should it not also be used to 
> > validate the timer ints in case of noise? Apparently the clock speeds up not
> > slows down in those cases?
> 
>  With real hardware perhaps it can be debugged.  The interaction between
> the 8254, the 8259As and the APICs seems interesting in the chipset.

> Perhaps the override to INTIN2 is to tell the timer is really unavailable
> directly?

That would be way too subtle for a BIOS writer;-)

> I can't see a way to have an ACPI override that specifies an
> ISA interrupt is not connected to the I/O APIC (unlike with the MPS).

I agree.  And I think the existence of this /proc/interrupts
entry on an ACPI-enabled system should probably go away.

           CPU0       CPU1
  2:          0          0          XT-PIC  cascade

ACPI also doesn't support sharing more than 1 pin on an IRQ.
So if you see a construct like this below, it is also a bug:

IRQ to pin mappings:
IRQ23 -> 0:23-> 0:7

cheers,
-Len


