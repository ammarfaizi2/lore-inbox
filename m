Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964976AbWH2Nym@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964976AbWH2Nym (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 09:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964974AbWH2Nyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 09:54:40 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:26271 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751385AbWH2Nyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 09:54:40 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <44F44639.90103@s5r6.in-berlin.de>
Date: Tue, 29 Aug 2006 15:50:49 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.5) Gecko/20060720 SeaMonkey/1.0.3
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>, David Howells <dhowells@redhat.com>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       zippel@linux-m68k.org
Subject: Re: [PATCH 17/17] BLOCK: Make it possible to disable the block layer
 [try #2]
References: <20060829115138.GA32714@infradead.org> <20060825142753.GK10659@infradead.org> <20060824213252.21323.18226.stgit@warthog.cambridge.redhat.com> <20060824213334.21323.76323.stgit@warthog.cambridge.redhat.com> <10117.1156522985@warthog.cambridge.redhat.com> <15945.1156854198@warthog.cambridge.redhat.com> <20060829122501.GA7814@infradead.org>
In-Reply-To: <20060829122501.GA7814@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Tue, Aug 29, 2006 at 01:23:18PM +0100, David Howells wrote:
>> Christoph Hellwig <hch@infradead.org> wrote:
>>
>>> Same as above.  USB_STORAGE already selects scsi so it shouldn't need
>>> to depend on block.
>> Ah, you've got it the wrong way round.
>>
>> Because USB_STORAGE _selects_ SCSI rather than depending on it, even if SCSI
>> is disabled, USB_STORAGE can be enabled, and that turns on CONFIG_SCSI, even
>> if not all of its dependencies are available.
>>
>> Run "make allyesconfig" and then try to turn off CONFIG_SCSI without this...
> 
> Eeek.  The easy fix is to change USB_STORAGE to depend on SCSI (*), but in
> addition to that we should probably fix Kconfig aswell to adhere to
> such constraints.
> 
> 
> (*) that selects is really wrong to start with, the other scsi drivers don't
>     select scsi either.

It is not wrong per se.

If SCSI is set to "N", then any menu items which depend on SCSI are not 
visible anymore. This is not a problem with any of the items in the SCSI 
configuration section.

But it is a problem for any items that live _in other configuration 
sections_, such as USB_STORAGE (currently not affected because it 
selects SCSI) and IEEE1394_SBP2 (does select SCSI now too in -mm).

If "select" cannot be fixed or is not en vogue for any other reason, the 
configuration tools need to be improved otherwise, so that users are 
guided to options like USB_STORAGE and IEEE1394_SBP2 when SCSI or other 
"foreign" options were disabled.

The kernel configuration is currently presented as a tree, although the 
dependencies of config options are not a tree. That's were "select" helps.
-- 
Stefan Richter
-=====-=-==- =--- ===-=
http://arcgraph.de/sr/
