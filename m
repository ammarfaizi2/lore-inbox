Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932591AbVI3Vcn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932591AbVI3Vcn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 17:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932595AbVI3Vcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 17:32:43 -0400
Received: from smtpout.mac.com ([17.250.248.83]:33486 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932591AbVI3Vcm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 17:32:42 -0400
In-Reply-To: <433D8D1F.1030005@adaptec.com>
References: <Pine.LNX.4.10.10509300015100.27623-100000@master.linux-ide.org> <433D8542.1010601@adaptec.com> <A0262C6F-6B0E-4790-BA42-FAFD6F026E0A@mac.com> <433D8D1F.1030005@adaptec.com>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <0F03AA4B-D2D1-4C57-B81B-FC95CB863A98@mac.com>
Cc: Andre Hedrick <andre@linux-ide.org>,
       "David S. Miller" <davem@davemloft.net>, jgarzik@pobox.com,
       willy@w.ods.org, patmans@us.ibm.com, ltuikov@yahoo.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org,
       linux-scsi@vger.kernel.org,
       James Bottomley <James.Bottomley@steeleye.com>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into the kernel
Date: Fri, 30 Sep 2005 17:31:35 -0400
To: Luben Tuikov <luben_tuikov@adaptec.com>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 30, 2005, at 15:08:15, Luben Tuikov wrote:
> On 09/30/05 14:50, Kyle Moffett wrote:
>> On Sep 30, 2005, at 14:34:42, Luben Tuikov wrote:
>>
>>> This is how we have the SPI-centric EH methods in the scsi host  
>>> template right now:
>>>    int (* eh_abort_handler)(struct scsi_cmnd *);
>>>    int (* eh_device_reset_handler)(struct scsi_cmnd *);
>>>    int (* eh_bus_reset_handler)(struct scsi_cmnd *);
>>>    int (* eh_host_reset_handler)(struct scsi_cmnd *);
>>
>> So submit patches to fix it!  You clearly understand what is  
>> wrong, so why not help change it?
>
> Because
>   - I do not want to give heart attack to all existing LLDDs

Significance of change is not an issue, assuming the change is broken  
up into a collection of small obvious changes as highlighted in  
Documentation/SubmittingPatches

>   - Some LLDD would never be able to be changed

Why not?  It's easy to change APIs, even stuff as invasive as the VM,  
the device driver model, etc, and those get changed all the time.

>   - Some LLDD work on very _scarce_ hardware which we cannot test.

You don't have to worry all that much about testing.  If your patches  
are small and obviously correct (like they should be), then they will  
get enough review during submission that there will only be a very  
small number of bugs.  The few remaining bugs will probably be ironed  
out in -mm.  In any case, if nobody uses hardware anymore, eventually  
the driver will get sufficiently crufty and out of date that it will  
be recognized as such and removed.

>   - plus such radical changes are neither warranted nor necessary.

Jeff Garzik et. al. seem to think that they are necessary, and I  
agree.  You don't need to fork SCSI-core; doing so would just double  
the maintainer load, and _that_ is neither warranted nor necessary.

> It is better to keep legacy around, until all you'll have on your  
> new serverboard is a SAS/SATA storage chip such as AIC-94xx or say  
> BCM8603.  Then you can compile out most of the legacy stuff.

Precisely.  When nobody uses the legacy drivers to the point that  
they aren't fixed or maintained anymore because no-one reports bugs,  
then said drivers can be removed from the kernel entirely, along with  
any support code.  The model I describe here works better because it  
keeps a _single_ clean core subsystem, and leaves any lack-of- 
maintenance crap in the old drivers.

> I think not breaking anything (for now at least) would be the  
> _easiest_ and most painless way to transition.

Until somebody wants to add a new high-level SCSI feature that works  
for both the new and the old devices.  Then they have to do it _twice_.

>>> The way we do this is we slowly, without disruption to older  
>>> drivers introduce, in parallel, emerge a new, simpler, slimmer,  
>>> faster SCSI Core, whereby we accommodate new infrastructures,  
>>> yet, have 100% backward compatibility, via the current older SCSI  
>>> Core. After all, both would be a bunch of functions in a bunch of  
>>> files.
>>
>> Except this introduces bloat and multiplies maintainer load.  Fix the
>> existing one.  If it breaks other in-core drivers, fix those to
>
> Well, not necessarily.  It would be more painful and more  
> maintainer load if we did what you suggest.  The overhead would be  
> enormous.

So you're saying fixing the current SCSI subsystem once *now* costs  
more than applying all *future* SCSI fixes to _two_ SCSI subsystems,  
handling bug reports for _two_ SCSI subsystems, etc.

>> s/Politics.*//g;  I hate politics.  Keep it off this list.
>
> Me too, but we are idealists.  Politics is an integral part of life.

Politics are not an integral part of productive technical  
discussions, though.  If you discuss technical topics and provide  
realistic technical descriptions, examples, reasons, code, etc, then  
politics tends not to matter in the discussion, and we're all happier  
people.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$ L++++(+ 
++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+ PGP+++ t+(+ 
++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  !y?(-)
------END GEEK CODE BLOCK------


