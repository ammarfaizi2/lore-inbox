Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751336AbVILPHD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbVILPHD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 11:07:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbVILPG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 11:06:59 -0400
Received: from magic.adaptec.com ([216.52.22.17]:22182 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S1751336AbVILPGp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 11:06:45 -0400
Message-ID: <4325997D.3050103@adaptec.com>
Date: Mon, 12 Sep 2005 11:06:37 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
CC: ltuikov@yahoo.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 2.6.13 5/14] sas-class: sas_discover.c Discover process
 (end devices)
References: <20050910024454.20602.qmail@web51613.mail.yahoo.com> <1126368081.4813.46.camel@mulgrave>
In-Reply-To: <1126368081.4813.46.camel@mulgrave>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Sep 2005 15:06:43.0683 (UTC) FILETIME=[962E3B30:01C5B7AB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10/05 12:01, James Bottomley wrote:
> On Fri, 2005-09-09 at 19:44 -0700, Luben Tuikov wrote:
> 
>>>this one completely duplicates the
>>>mid-layer infrastructure for handling devices with Logical Units.
>>
>>No, it does *not*.  James, you have _stop_ spreading FUD, relying
>>that other people have not read the SCSI Core code.
> 
> 
> We have an infrastructure in the mid-layer for doing report lun scans.
> You have a parallel one in your code.  In my book, that's duplication.

This infrastructure is broken.  Its interface is broken.  It is a horrible
excuse of LUN scanning written initially to support a certain hardware.

LUN scanning is done a tad bit differently with a tad bit different
interface.  Read the specs, study the code I submitted.

It is poinless for you to argue back just with a sentence and for
me to reply back to you with *code*.

Again, unless you point out code, you're spreading FUD!

Here is excerpt from my previous message to the list:
---cut-start----
Look at scsi_scan_target() declaration:

void scsi_scan_target(struct device *parent, unsigned int channel,
		      unsigned int id, unsigned int lun, int rescan);

Channel, id, lun, rescan?  WTF?

Do you see any of this in the proprely implemented LU discovery
code in the SAS discovery code I submitted?
---cut-end---

>>See here:
>>    SCSI Core has *no representation* of a SCSI Device with a
>>SCSI Target Port.
> 
> 
> A scsi target is represented by struct scsi_target.

No, it is NOT!  Stop spreading FUD.  struct scsi_target is
*your idea of what a SCSI target is*.  It is not what
a SCSI Device with a Target Port _actually_ is.  Take a look at
struct domain_device in my code.  _This_ is what that is.
Study it.  Ask questions.

James, either you didn't look in the code or you've lost
your touch to _envision_ things.

Why are you arguing stupid sh1t?

Why don't you ask to understand why the code was done the
way it is?

>>I've _clearly_ outlined that in the comments of the code,
>>which you _conveniently_ did _not_ cut and paste here.
>>
>>I've been asking for a generic SCSI Target representation for
>>the last 5 years, which you conventiently skip to mention.
>>Or shall we search linux-scsi archives?
>>
>>As to duplication: NOT!
>>
>>Why?
>>
>>Look at scsi_scan_target() declaration:
>>
>>void scsi_scan_target(struct device *parent, unsigned int channel,
>>		      unsigned int id, unsigned int lun, int rescan);
>>
>>Channel, id, lun, rescan?  WTF?
> 
> 
> So you want to rehash that argument again.
> 
> Either you can do what others like FC currently do:
> 
> http://marc.theaimsgroup.com/?l=linux-scsi&m=110546207223304

Oh, more FUD from you? No?

Why are you posting a link to a FC patch adding "remote port"
support?

This is completely irrelevant and a *red herring* from you,
since:
	* it is for FC
	* there is no "remote port" in SAS,
	* similar concept in SAS is completely supported
	in the code I submitted.

When posting something technical, explain the mechanism,
the steps, the _proof of it_.  Posting a link to a patch,
which only very few would understand *does not* make you
look smart.

Why didn't you post an email expalining how shameful it is
to allow HCIL to stick in SCSI Core for so long as it did,
and how shameful it is that all new technologies have to
invent it in their lower layers to support the OLD OUTDATED
COMPLETELY BROKEN SCSI CORE?

Do you want SCSI Core/Linux to be enterprise storage OS of
choice?  (Please do not answer.)

Parallel SCSI has been _completely_ replaced by SAS in any
new storage subsystem.

IDE has been _completely_ replaced by SATA in any new
desktop computer as well.

I've written to you in private email that the best thing
you can do is: *listen*, learn and accept.

Give up Parallel SCSI and its ways.

All developlment you've done for the last X years has been
to accomodate HCIL/SPI centric SCSI Core.

No new _SCSI_ enhancements. (Note the underlined SCSI.)

> Or you can follow the recipe you were given for making the mid-layer use
> arbitrary identifiers for the target
> 
> http://marc.theaimsgroup.com/?l=linux-scsi&m=112487476527470

This is that thread where I started explaining what an _arbitrary_
label is and how it is given at each layer and how we can dispense
with HCIL.  Then the link you've pasted is Christoph's response.
But I replied to his email:

http://marc.theaimsgroup.com/?l=linux-scsi&m=112507133514575&w=2

It seems to me you cannot see things _indepth_.  There is
_a lot more_ riding on those "arbitrary labels" I talked about,
than what you seemingly undersand (if you can paste a link like this).

Remember my email about Dopey, Sleepy and Bashful storage entities
behind a black box I sent to you on that same thread?

http://marc.theaimsgroup.com/?l=linux-scsi&m=112508024707227&w=2

> Simply writing your own because you don't like the former and the
> latter's too much work isn't acceptable.

Oh, yes it is acceptable.

When for the last 5 years I've been asking for a SCSI target
representation, and you've dismissed all my requests, it _is_
acceptable.

And secondly, the routine which I've written is NOT duplication.
It is the _correct_ way to do it, while the one in SCSI Core
is *crap*, thus there is no duplication.

I think I'm beginning to understand now your point of view:
pre-SCSI-3 (SCSI-2) SPI pure point of view.

So in effect we don't speak the same language or come off of
the same base.

>>Do you see any of this in the proprely implemented LU discovery
>>code in the SAS discovery code I submitted?
> 
> 
> Yes, of course, I did notice the W_LUN support which we could do with in
> scsi_report_lun_scan() if you'd care to play nicely with others.

I've been asking for 64 bit LUN support and pure REPORT LUN scanning
for the *last 5 years* due to my work on iSCSI 5 years ago.

Others have also been asking for the same functionality over
the years.  E.g. FireWire, iSCSI, etc.

*YOU HAVE IGNORED* all those requests!

>>I asked for pure SCSI device with Target port implementation of
>>scsi_target and _you_ rejected it about 4 years ago.  Shall I search
>>for this message in the linux-scsi archives?
> 
> 
> You can ask for all the features you want ... however, unless you can
> persuade someone else to do the implementation, you get to write the
> code yourself...

1. I have -- all 40 patches I submitted.

2. Your initial reaction to _anything_ _anyone_ has requested to
be done for SCSI Core as an enhancement, according to any spec,
you have *rejected*.  The archives speak of themselves.

The only code you've allowed in is if some other Linux guru
wanted in: like Andi with my commands from the slab cache,
done_q, softirq processing, etc, etc.

OR, if you or Christoph wrote it.

This has created a dissent in the community and vendors,
and in effect you've established yourself _not_ as a _servant_
(maintainer) but as a _dictator_.  Just look at the language
people are using when asking you to include their patches in.

It is shameful.

>>>>+ * REPORT LUNS is mandatory.  If a device doesn't support it,
[cut]
>>Second, SAS devices being very recent have their firmware written
>>to latest specs, and advertised as SPC-3 and SAM-3.
> 
> 
> We have boatloads of devices that claim SCSI-n or SPC-n compliance then
> fail in various ways.  That's what the list in scsi_devinfo.c is all
> about.  I'm sure the manufacturers of those devices didn't intentionally
> set out to violate the specs; however, what they actually released does.
> I'm sure that SAS vendors will start out with the best of intentions
> too ...

I've run this code on pre-pre-pre-.... firmware and it handles
really broken REPORT LUNS devices.  It works *without the need* for
a blacklist lookup table.

>>But that generic code you talk about is complete *crap* and needs
>>rewriting.  When that generic code, can handle "SCSI device with
>>a Target port" then I'd love to off load that to SCSI Core.
>>
>>In fact initially I _really_ tried to offload that to SCSI Core,
>>but it didn't quite work, then I wrote LU discovery.  Just run it on
>>real hardware.
> 
> 
> The practise of allowing Vendors to duplicate code just because they
> didn't like what's in the generic subsystem or because it lacks a
> feature they need hasn't been acceptable for a long time now.  Either
> use what we have or fix it to do what you want.

First, I do not see myself as a "Vendor".  If I cut you a check for
money, and sent _you_ some hardware, _then_ I'd see myself as
a "Vendor".  Right now, I'm a _contributor_.

Second, I did ask for REPORT LUNS mechanism into SCSI Core before it
was there.

Third, no advice by me has *ever been accepted by you*, unless
the previous maintainer told you so or Andi said so.

Fourth, over the last 5 years, I've learned that you would
not accept any advice, a lot less _storage_ advice, or patch
from me, unless see "Third" above.

Fifth, you only say: submit a patch, but you do not actually
accept it.  Instead you come up with your own version of that
patch and accept that.  This happens with almost *every* patch
going into SCSI Core.

Are you asking me to submit a patch for SCSI Core to do proper
REPORT LUNS?   *This is ubelievable.*  I would like the whole
world to note it (for your sake).

	Luben

