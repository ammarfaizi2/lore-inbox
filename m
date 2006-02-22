Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751423AbWBVUqX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423AbWBVUqX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 15:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751429AbWBVUqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 15:46:23 -0500
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:56141 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S1751423AbWBVUqW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 15:46:22 -0500
DomainKey-Signature: s=smtpout; d=dell.com; c=nofws; q=dns; b=OxudcewF8YyupFakzb75jvj0FneF/mR9EQuN4rHiF1b8nns/BnQ0EjxNSNJ04aFNRMMlbPSu9Ef0P+qmOU00wW+hQS4c0lVtRW/I6vE8tjS1hKikas/JcwCQLVZc+81I;
X-IronPort-AV: i="4.02,137,1139205600"; 
   d="scan'208"; a="384649632:sNHT31724716"
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: Suppressing softrepeat
Date: Wed, 22 Feb 2006 14:46:21 -0600
Message-ID: <B1939BC11A23AE47A0DBE89A37CB26B4F960DB@ausx3mps305.aus.amer.dell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Suppressing softrepeat
Thread-Index: AcY38C+oAkhGptHyTLizU4O91VgeugAAKSgw
From: <Stuart_Hayes@Dell.com>
To: <vojtech@suse.cz>, <zaitcev@redhat.com>
Cc: <dtor_core@ameritech.net>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 22 Feb 2006 20:46:18.0797 (UTC) FILETIME=[080725D0:01C637F1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> On Wed, Feb 22, 2006 at 12:00:47PM -0800, Pete Zaitcev wrote:
>> On Tue, 21 Feb 2006 22:08:00 +0100, Vojtech Pavlik <vojtech@suse.cz>
>> wrote: 
>> 
>>> A much simpler workaround for the DRAC3 is to set the softrepeat
>>> delay to at least 750ms, using kbdrate(8), which will call the
>>> proper console ioctl, resulting in updating the softrepeat
>>> parameters. 
>>> 
>>> I prefer workarounds for problematic hardware done outside the
>>> kernel, if possible.
>> 
>> I agree with the sentiment when posed in the abstract way, but let me
>> tell you why this case is different.
>> 
>> Firstly, there's nothing "problematic" about this. It's just how it
>> is. The only problematic thing here is our code. Currently, the
>> situation 
>> is assymetric. It is possible to force softrepeat on, but not
>> possible 
>> to force softrepeat off. Isn't it broken?
>> 
>> Secondly, 750ms may be not enough. Stuart is being shy here and
>> posting explanations to Bugzilla for some reason.
>> 
>> Lastly, it's such a PITA to add these things into the userland, that
>> it's completely impractical. Console is needed the most when things
>> go wrong. In such case, that echo(1) may not be reached before the
>> single user shell. And stuffing it into the initrd is for Linux
>> weenies only, unless automated by mkinitrd. 
>> 
>> I think you're being unreasonable here. I am not asking for NFS root
>> or IP autoconfiguration and sort of complicated process which ought
>> to 
>> be done in userland indeed.
> 
> I'm definitely not intending to be unreasonable, and I understand
> your need to have the keyboard working all the way from the grub/lilo
> prompt.  
> 
> I just don't like adding more module options to one that already has
> so many it's hard to understand what they're used for. 
> 
> How about simply this patch instead?
> 
> Setting autorepeat will not be possible on 'dumb' keyboards anymore
> by default, but since these usually are special forms of hardware
> anyway, like the DRAC3, this shouldn't be an issue for most users.
> Using 'softrepeat' on these keyboards will restore the behavior for
> users that need it.    
> 
> diff --git a/drivers/input/keyboard/atkbd.c
> b/drivers/input/keyboard/atkbd.c --- a/drivers/input/keyboard/atkbd.c
> +++ b/drivers/input/keyboard/atkbd.c
> @@ -863,9 +863,6 @@ static int atkbd_connect(struct serio *s
>  	atkbd->softrepeat = atkbd_softrepeat;
>  	atkbd->scroll = atkbd_scroll;
> 
> -	if (!atkbd->write)
> -		atkbd->softrepeat = 1;
> -
>  	if (atkbd->softrepeat)
>  		atkbd->softraw = 1;

That seems reasonable to me, and would fix the issue with the DRAC3.

Shyly,
Stuart
