Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750701AbWGFSoq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbWGFSoq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 14:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbWGFSop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 14:44:45 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:44934 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750701AbWGFSoo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 14:44:44 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andi Kleen <ak@muc.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Doug Thompson <norsk5@yahoo.com>,
       akpm@osdl.org, mm-commits@vger.kernel.org, norsk5@xmission.com,
       linux-kernel@vger.kernel.org
Subject: Re: + edac-new-opteron-athlon64-memory-controller-driver.patch added to -mm tree
References: <20060704092358.GA13805@muc.de>
	<1152007787.28597.20.camel@localhost.localdomain>
	<20060704113441.GA26023@muc.de>
	<1152137302.6533.28.camel@localhost.localdomain>
	<20060705220425.GB83806@muc.de>
	<m1odw32rep.fsf@ebiederm.dsl.xmission.com>
	<20060706130153.GA66955@muc.de>
	<m18xn621i6.fsf@ebiederm.dsl.xmission.com>
	<20060706165159.GB66955@muc.de>
	<m18xn6zkx3.fsf@ebiederm.dsl.xmission.com>
	<20060706180826.GA95795@muc.de>
Date: Thu, 06 Jul 2006 12:43:39 -0600
In-Reply-To: <20060706180826.GA95795@muc.de> (Andi Kleen's message of "6 Jul
	2006 20:08:26 +0200, Thu, 6 Jul 2006 20:08:26 +0200")
Message-ID: <m1slley3ok.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@muc.de> writes:

> On Thu, Jul 06, 2006 at 11:46:00AM -0600, Eric W. Biederman wrote:
>> Andi Kleen <ak@muc.de> writes:
>> 
>> >> With EDAC on my next boot I get positive confirmation that I either
>> >> pulled the DIMM that the error happened on, or I pulled a different
>> >> DIMM.
>> >
>> > How? You simulate a new error and let EDAC resolve it?
>> 
>> No. There is a status report that tells you which pieces of hardware
>> your memory controller sees.  It is just a simple list.
>
> Ok but that could be also done easily in user space that reads
> PCI config space. No need for a complicated kernel driver at all.

User/kernel the task the driver has to do is the same, so
the complexity doesn't really change.

On some chipsets the registers are memory mapped, on others the
memory controller is hidden by default.

All of which are hard to deal with from user space.

>> Isn't something that just works, and is not at the mercy of the BIOS
>> developers with too little time worth doing?
>
> I just don't see how it's very useful if you don't know which DIMM
> to replace in the first place. 

You do know which DIMM you just don't know what the label on the
motherboard is.  That is a lot different from knowing that some DIMM
is bad.

> And to know that in your scheme you need
> your magical database with all motherboards ever shipped, which
> I don't consider realistic.

No you do not need a magic database.  Having the mapping will save
you a few minutes as you debug your hardware, but it is not critical.

If you have a map of rank to motherboard label the work flow is:
- Look for the label on the motherboard and pull that DIMM.

If you do not have a map of rank to motherboard label the work flow is:
- Make an educated guess
- Boot up and see if you have pulled your target DIMM.
  If so stop.
- If not turn off the computer
- Replace the DIMM
- start again with a different DIMM.

A simple linear search will not take long, and because you don't
have to reproduce the error on the problem DIMM it will go much
faster then if all you knew was that a DIMM was bad.

If you replace a lot of bad memory on a particular mother board
you will either build the map in your head or you will store it
in a file.  Once you have the map in a file hopefully it will get
sent to the EDAC maintainer and some one else can be saved the
trouble.

Historically memory has had a pretty bad infant mortality so there
are people who replace a lot of memory on particular motherboards.

Eric
