Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964992AbWHHQke@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964992AbWHHQke (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 12:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964995AbWHHQkd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 12:40:33 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:64651 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964994AbWHHQka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 12:40:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=KYWriEtPC9nrmuN5SZgFKbaPbOStUGkNM5YrrfzlO+nLXlVWAzBZLtW+wmZJmc5b37w6RelMtWI0VCIYE4YUtZpdN9zD40wrHmQZy1LLOx7HPQuQzVQLug1IwLS9kXSMaiAlnhD1OQYmn1dePZ/8yEq5rK0aOteIlZYogGxNawQ=
Message-ID: <44D8BE88.4080809@gmail.com>
Date: Tue, 08 Aug 2006 18:40:17 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: "Rafael J. Wysocki" <rjw@sisk.pl>, Jason Lunz <lunz@gehennom.net>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       andre@linux-ide.org, pavel@suse.cz, linux-pm@osdl.org,
       linux-ide@vger.kernel.org
Subject: Re: swsusp regression [Was: 2.6.18-rc3-mm2]
References: <20060806030809.2cfb0b1e.akpm@osdl.org> <200608081316.00749.rjw@sisk.pl> <20060808111925.GO4025@suse.de> <200608081550.36054.rjw@sisk.pl> <20060808140601.GU31726@suse.de>
In-Reply-To: <20060808140601.GU31726@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Tue, Aug 08 2006, Rafael J. Wysocki wrote:
>> On Tuesday 08 August 2006 13:19, Jens Axboe wrote:
>>> On Tue, Aug 08 2006, Rafael J. Wysocki wrote:
>>>> On Tuesday 08 August 2006 13:07, Jens Axboe wrote:
>>>>> On Tue, Aug 08 2006, Jens Axboe wrote:
>>>>>>> Indeed, that looks broken now. That must be what is screwing it up. With
>>>>>> the former patch applied, did cdrom detection still look funny to you?
>>>> Hm, I'm not sure what you mean ...
>>> -hdc: ATAPI 63X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
>>> +hdc: ATAPI CD-ROM drive, 0kB Cache, UDMA(33)
>> Ah, that.
>>
>>> But perhaps that wasn't you?
>> No, that wasn't me. :-)

It was me and it's OK.

>>>>>> I'll concoct a fix for that breakage.
>>>>> Something like this.
>>>> Looks good, I'll give it a try.
>>> Thanks!
>> It fixes this particular issue for me, but your first patch (appended)
>> is also needed to prevent the box from hanging later during the resume
>> (when it tries to save the image).
> 
> Yes certainly, that's a separate bug, sorry if I didn't make that clear.
> Both fixes are in the block repo now, so next -mm should work fine
> again.

And even this is OK.

I'm just curious, what
@@ -387,3 +398,5 @@
  EXT3 FS on md0, internal journal
  EXT3-fs: mounted filesystem with ordered data mode.
  Adding 506036k swap on /dev/hda3.  Priority:-1 extents:1 across:506036k
+JBD: barrier-based sync failed on hda2 - disabling barriers
+JBD: barrier-based sync failed on md0 - disabling barriers

means. Another bug?

thanks,
-- 
<a href="http://www.fi.muni.cz/~xslaby/">Jiri Slaby</a>
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
