Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751256AbWEZSfc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbWEZSfc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 14:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbWEZSfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 14:35:32 -0400
Received: from spirit.analogic.com ([204.178.40.4]:36110 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1751256AbWEZSfc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 14:35:32 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 26 May 2006 18:35:24.0641 (UTC) FILETIME=[2700CD10:01C680F3]
Content-class: urn:content-classes:message
Subject: Re: [PATCH] POSIX-hostname up to 255 characters
Date: Fri, 26 May 2006 14:35:24 -0400
Message-ID: <Pine.LNX.4.61.0605261430370.8339@chaos.analogic.com>
In-Reply-To: <447748E4.4050908@redhat.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] POSIX-hostname up to 255 characters
Thread-Index: AcaA8ycKx1PeWnm6QqGb91Efj+PNEg==
References: <20060525204534.4068e730.rdunlap@xenotime.net> <m1zmh5b129.fsf@ebiederm.dsl.xmission.com> <20060526144216.GZ13513@lug-owl.de> <Pine.LNX.4.58.0605261025230.9655@shark.he.net> <20060526180131.GA13513@lug-owl.de> <Pine.LNX.4.61.0605261409300.8002@chaos.analogic.com> <447748E4.4050908@redhat.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Ulrich Drepper" <drepper@redhat.com>
Cc: "Jan-Benedict Glaw" <jbglaw@lug-owl.de>,
       "Randy.Dunlap" <rdunlap@xenotime.net>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       "lkml" <linux-kernel@vger.kernel.org>, "akpm" <akpm@osdl.org>,
       <serue@us.ibm.com>, <sam@vilain.net>, <clg@fr.ibm.com>, <dev@sw.ru>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 26 May 2006, Ulrich Drepper wrote:

> linux-os (Dick Johnson) wrote:
>
>> MAXHOSTNAMELEN, defined by POSIX, is 64 bytes.
>
> Where do you think this is written?  The minimum maximum for the host
> name length in POSIX is 255.  This is the whole motivation of the patch.
> Linux currently cannot conform because this is one of the things the
> kernel gets wrong.
>
It is written (on so-called compatible machines like my Sun) as:

#define MAXHOSTNAMELEN _POSIX_HOST_NAME_MAX

Then in limits.h, I see:

#define _POSIX_HOST_NAME_MAX 64

Since somebody uses "POSIX" in the define, I assumed it had something
to do with POSIX. Further review using google shows even 256 as the
minimum-maximum so it's likely something that is now biting lots
of people.

>
>> You can't just
>> change it to 255. If you did, all servers in the universe, all
>> everything would have to be shutdown, recompiled, and rebooted
>> simultaneously. You can't have a name-server returning a 255-byte
>> string when a mail-server can only handle 64 bytes.
>
> The hostname is a machine-local value.  How the machine is represented
> to the outside world is governed by services like DNS.  DNS defines its
> own limits on the length of the name and each component.  So, if a host
> name (without domain) exceeds 64 bytes you need a different external
> name for the machine.  But this doesn't stop anybody from locally using
> a longer name.
>
> Can there be programs which have problems?  Certainly.  But
> gethostname() won't just overwrite memory.  It'll return an error and
> the programs with the wrong assumptions can be fix.
>
> --
> ÿÿ Ulrich Drepper ÿÿ Red Hat, Inc. ÿÿ 444 Castro St ÿÿ Mountain View, CA ÿÿ
>
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.73 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
