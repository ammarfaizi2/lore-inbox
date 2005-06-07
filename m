Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261937AbVFGRn7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261937AbVFGRn7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 13:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261942AbVFGRn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 13:43:59 -0400
Received: from magic.adaptec.com ([216.52.22.17]:18054 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S261937AbVFGRn4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 13:43:56 -0400
Message-ID: <42A5DCB3.7050000@adaptec.com>
Date: Tue, 07 Jun 2005 13:43:15 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adam Belay <ambx1@neo.rr.com>
CC: Greg KH <gregkh@suse.de>, Roland Dreier <roland@topspin.com>,
       Dave Jones <davej@redhat.com>,
       Grant Grundler <grundler@parisc-linux.org>, tom.l.nguyen@intel.com,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       davem@davemloft.net
Subject: Re: pci_enable_msi() for everyone?
References: <20050603224551.GA10014@kroah.com> <20050604013112.GB16999@colo.lackof.org> <20050604064821.GC13238@suse.de> <20050604070537.GB8230@colo.lackof.org> <20050604071803.GA13684@suse.de> <20050604072348.GA28293@redhat.com> <20050606230118.GD11184@suse.de> <5264wrj9l3.fsf@topspin.com> <20050607052202.GD17734@suse.de> <20050607054604.GA8340@neo.rr.com>
In-Reply-To: <20050607054604.GA8340@neo.rr.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Jun 2005 17:42:58.0196 (UTC) FILETIME=[57C1A540:01C56B88]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/05 01:46, Adam Belay wrote:
> On Mon, Jun 06, 2005 at 10:22:03PM -0700, Greg KH wrote:
> 
>>On Mon, Jun 06, 2005 at 05:26:32PM -0700, Roland Dreier wrote:
>>
>>>    davej> What if MSI support has been disabled in the bridge due to
>>>    davej> some quirk (like the recent AMD 8111 quirk) ?  Maybe the
>>>    davej> above function should check pci_msi_enable as well ?
>>>
>>>    Greg> Yes, you are correct.  I said it wasn't tested :)
>>>
>>>Huh?  If a host bridge doesn't support MSI, and a device below it has
>>>its MSI capability enabled, we're in big trouble.  Because that device
>>>is going to send interrupt messages whether the bridge likes it or
>>>not.
>>
>>No, that device would never get MSI enabled on it.  See the patch I
>>posted to make sure I didn't get it wrong...
>>
>>thanks,
>>
>>greg k-h
> 
> 
> How are we handling the case where a device has multiple MSI messages.
> Is any driver interaction needed for that?  Will this change affect it?
> I haven't had a chance to look through the MSI code yet.
> 
> Thanks,
> Adam

Yes, this is a very good point (PCI MSI-X).

All in all, given all the hardware quirks of both
PCI bridges and PCI devices, I'd leave PCI MSI
control to the PCI LLDD.

	Luben


