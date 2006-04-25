Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932310AbWDZARL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932310AbWDZARL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 20:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932315AbWDZARL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 20:17:11 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:4540 "EHLO
	biscayne-one-station.mit.edu") by vger.kernel.org with ESMTP
	id S932305AbWDZARJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 20:17:09 -0400
Message-ID: <20060425195943.7a6apx4ci65ticos@webmail.mit.edu>
Date: Tue, 25 Apr 2006 19:59:43 -0400
From: abelay@MIT.EDU
To: "Brown, Len" <len.brown@intel.com>, Arjan van de Ven <arjan@infradead.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, "Yu, Luming" <luming.yu@intel.com>,
       Andrew Morton <akpm@osdl.org>, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: RE: [PATCH] reverse pci config space restore order
References: <CFF307C98FEABE47A452B27C06B85BB6466300@hdsmsx411.amr.corp.intel.com>
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB6466300@hdsmsx411.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) H3 (4.0.3)
X-Spam-Score: -1.638
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting "Brown, Len" <len.brown@intel.com>:

>
>> On Tue, 2006-04-25 at 11:48 +0100, Matthew Garrett wrote:
>>> On Tue, Apr 25, 2006 at 02:50:57PM +0800, Yu, Luming wrote:
>>>
>>> > -	for (i = 0; i < 16; i++)
>>> > +	for (i = 15; i >= 0 ; i--)
>>>
>>> We certainly need to do /something/ here, but I'm not sure
>>> this is it.
>>> Adam Belay has code to limit PCI state restoration to the
>>> PCI-specified
>>> registers, with the idea being that individual drivers fix things up
>>> properly. While this has the obvious drawback that almost every PCI
>>> driver in the tree would then need fixing up, it's also probably the
>>> right thing.
>>
>> it has a second drawback: it assumes all devices HAVE a driver, which
>> isn't normally the case...
>
> Adam mentioned earlier, and I agree, that it is probably a bad
> idea for this code to blindly scribble on the BIST field at i=3.
> Probably we should clear that field before restoring it.
>
> Re: this patch
> I think that this patch is likely a positive forward step.
> It seems logical to restore the BARs before the CMD/STATUS in general,
> nothing specific to the ICH here.
>
> But yes, this is a helper routine and devices where it hurts
> instead of helps should have their own routine.  Complex devices
> need to handle the device-specific config space state above these
> 1st 16 locations anyway.

Right, and because we only restore the first 0x40 or so registers (they're all
standard), I don't think implementing pci_save/restore_state() properly 
is going
to break much at all.  I'm planning to merge these changes with -mm, so
hopefully it won't be difficult to tell. :)

Re: devices without drivers

We can certainly call a generic save and restore function when there isn't a
driver available, but beyond handling standard registers mentioned in 
the spec,
if important hardware context is lost there's really no way around it.

-Adam

