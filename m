Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751118AbVI1WKx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbVI1WKx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 18:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751119AbVI1WKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 18:10:53 -0400
Received: from magic.adaptec.com ([216.52.22.17]:39587 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S1751118AbVI1WKw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 18:10:52 -0400
Message-ID: <433B14E1.6080201@adaptec.com>
Date: Wed, 28 Sep 2005 18:10:41 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
 the kernel
References: <43384E28.8030207@adaptec.com> <4339BFE9.1060604@pobox.com> <4339CCD6.5010409@adaptec.com> <4339F9A8.2030709@pobox.com> <433AFEB2.7090003@adaptec.com> <433B0457.7020509@pobox.com>
In-Reply-To: <433B0457.7020509@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Sep 2005 22:10:50.0599 (UTC) FILETIME=[7C557770:01C5C479]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/28/05 17:00, Jeff Garzik wrote:
> Luben Tuikov wrote:
> 
>>Ideally SATL is just a _data transformation function_ and
>>getting to the ATA device is transport dependent.
> 
> 
> Incorrect.  It needs to issue multiple ATA commands to emulate a single 
> SCSI command, cache some state, and other details.  Not purely data 
> transformation.

Yes, this is right and I'm aware of it.  I really, really,
had some wishful thinking.

> What needs to happen is that SPI-specific stuff in the SCSI core needs 
> to be moved to SPI-specific transport code.
> 
> Then all transports will be at an equal level, and the SCSI core will be 
> fully transport-agnostic.

Yeah, I've been saying this for ages:
Read half way through my message from 2003 here:
http://marc.theaimsgroup.com/?l=linux-scsi&m=104257405408078&w=2

> "time and again" means that we have been specific multiple times. 
> Re-read your emails from James and Christoph :)

So you're saying that they are right and I'm wrong,
and I should listen to them.

Which is _exactly_ what I've been pointing out:
"the community" thinks that only they are the
experts on the planet regarding new technologies,
thus they are right, engineers "outside the community"
are dead wrong and they should listen to what
"the community" says.

Shall I point out a multitude of emails whereby some
"community members" go out on _technology_ public lists
and start a flame war, until they are warned to behave
or be expelled?  Is this what you mean the "they" are
right, and "we" are wrong?

The community calls specs "techno-gibberish"
and think that LUNs can be u64, that REQUEST SENSE
clears ACA, and that HCIL is here for ever, etc.

Excuse me if I simply ignore their "SCSI storage advice".

>>If you understood how different those architectures are,
>>you'd understand what I mean.
> 
> 
> James is wrong here.

Either you meant "Luben" here or you've been banned
forever from "the community" and your patches would never
ever be accepted.

> The "transport class" in reality winds up as a 
> transport lib, in addition to simply exporting attributes.
> 
> There will always be functions that are common to a transport. 
> Christoph calls this "libsas", since software-driven SAS implementations 

Look at the pictures (since its easier) in SAM/SAS/SPC.
It is not a "lib" it is a _layer_ in its own right,
which is completely and fully implemented in the FW
of an MPT-like (IOP in package) solution.

Access to _anything_ transport specific is _FIRMWARE_
specific and doesn't yield to unification as does
a SAS Transport Layer management.

The only unification you get is: "Here is a LLDD giving
you LUs to manage, and oh yeah, here is some FIRMWARE
dependent way to peek at the transport and transport
attributes".

>> I do not _know_ how to consolidate the completely broken
>> "design" set forth by JB and company.
>> 
>>It is _completely_ not to SAM spec.
> 
> Not true.  Just because SCSI core lacks an explicit "execute SCSI 
> command" RPC hook, does not imply that that capability is non-existent.
> 
> Stare at the Scsi_Host_Template some more and you'll see it.

Well, then, how can I reply to this?

I say "1+1=2", you say "Not true.  1+1=3."

Show me the equivalence between the Scsi_Host_Template
and SAM, give me section references as well.

What I meant is that the place and design of JB's transport
attribute "blessing" is completely out of whack for SAM
abiding implementation.

Look at the pictures: the transport layer is _below_
the application client and the application client
is completely unaware of the transport.

Now lets translate (http://www.t10.org/scsi-3.gif) :
    Command set drivers  <-->  sd, st, etc (application client)
                SAM/SPC  <-->  SCSI Core to be
        Transport layer  <-->  SAS (all others implemented in LLDD)
                    SDS  <-->  LLDD + Firmware
           Interconnect  <-->  Firmware + hardware.

It is _this_ SAM architecture which allows you to say,
send SATA commands over SAS links (via STP), and do other
interesting things.

I guarantee you that any _new_ SCSI transport would yield
to a Transport Layer abstraction just as SAS does.

Since, this is what SAM _is_ (all about).

I don't mind James Bottomley entertaining his
"transport attribute" code, as long as he's not shoving
it down my throat (again because of pictures like the one
above).

As I've said before both implementations are _orthogonal_
and can coexist.

>>But an AIC-94xx and BCM8603 _is_ NOT a scsi_host material.  It is just
>>an interface to the interconnect.
> 
> A scsi_host is simply a container.  You're being too literal.

By "too literal" do you mean "following specs too closely",
or do you mean "being realistic without tweaking things".

> Yes.  We need to evolve the SCSI core to separate out SPI-specific 
> pieces, to make it more transport-agnostic.

2003:
http://marc.theaimsgroup.com/?l=linux-scsi&m=104257405408078&w=2

> James and Christoph have been asking you to submit patches for a long 
> time now.

Not patches to fix SCSI Core or to get "struct scsi_domain_device"
into SCSI Core or to get 64 bit LUNs into the kenrel.

They've been asking me for me to abandon the complete
SAS transport layer which I have, which is 1000 years ahead
of theirs and ahead of SCSI Core and to go and work
on LSI's and on "transport attributes".

Sorry, but SAM seems to disagree.

> James, Christoph and the rest of linux-scsi have been saying this over 
> and over again.

They've never said it: why else do you think we do not
have 64 bit LUNS or why else do you think we have HCIL in
SCSI Core.

Instead, what James does is he goes off to implement
"transport attributes" and to submit patches to IDR
after I myself submitted patches to IDR?  Why?  So he can
undermine my patches?  Well, as you can see I completely
removed IDR's usage from aic94xx.  Now "the community" is happy.

> Everybody knows the SCSI core is too SPI-centric, and you have been 
> given a recipe for fixing this.

I "have been given recipe for fixing this"?

Are you all right Jeff?

Yep, the recipe was given to me by people who think that
we should stay with HCIL, who have found purpose for
the "second channel" in HCIL, who think that REQUEST SENSE
clears ACA, who think that 64 bit LUN is just a waste, and
so forth with their antics.

So excuse me if I don't see or recognize the recipe
given to me.  Mind pointing out a link?  This way we
will have a hard coded evidence of what that recipe is.
And we can see the exact steps it outlines.

Thank you,
	Luben


