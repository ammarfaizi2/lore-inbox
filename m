Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750748AbWG0Ucn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbWG0Ucn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 16:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbWG0Ucm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 16:32:42 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:11718 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750742AbWG0Ucl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 16:32:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fJ442txbd6uMDfLHWXmalukixdQo2nm778Bq2uknfvhhStbA5S/2Uz0M0sxi3JRzQQqdF792g5uqneHcPSIflkTTc99KMmHBQP2y/iktyXNConqWcouBNSuwMtH5o5XTdA1jnuoVhUYzW9oHO/mquu9oS5756tNEGYtEclAlGjs=
Message-ID: <41840b750607271332q5dea0848y2284b30a48f78ea7@mail.gmail.com>
Date: Thu, 27 Jul 2006 23:32:39 +0300
From: "Shem Multinymous" <multinymous@gmail.com>
To: "Brown, Len" <len.brown@intel.com>
Subject: Re: Generic battery interface
Cc: "Pavel Machek" <pavel@suse.cz>, "Matthew Garrett" <mjg59@srcf.ucam.org>,
       vojtech@suse.cz, "kernel list" <linux-kernel@vger.kernel.org>,
       linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB6011688D8@hdsmsx411.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <CFF307C98FEABE47A452B27C06B85BB6011688D8@hdsmsx411.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/06, Brown, Len <len.brown@intel.com> wrote:
> Why not just specify the union of the different sets,
> and those that don't implement parts leave those parts out?

That's cool, as long as we still let drivers express minor differences
within the framework (see my last message to Daniel).


> >So I've proposed /sys/class/battery/{acpi,apm,thinkpad}/BAT?/*
> >as a comrpromise:
> >A userspace app that only needs a generic voltage readout will try
> >(all of) /sys/class/battery/*/BAT0/voltage. This is your generic
> >interface.
>
> If we have to export all these totally different implementations
> via totally different paths, then we failed.

They're not totally different, they differ in a very specific way
which allows the difference to be ignored by applications that don't
care.


> sysfs is great for demos from a shell prompt,
> but isn't such a great programming interface, either
> from inside the kernel or from user-space.

<shrug>
I have my own list of sysfs gripes (e.g., how do you implement a
"query a register" interface?), but the powers that be decreed we're
supposed to use sysfs for this kind of stuff.


> Also, critical battery alarms are important events.

Yes, but not time-sensitive.


> Please do not add more polling to user-space, else DaveJ
> will be putting it up as a further example of "Why userspace sucks"
> at the next OLS:-)

Battery polling is already used extensively, and its overhead is
completely negligible. I'm yet to see any deployed userspace code
trying to query battery status more than once per second.

On the other hand, if you send an event whenever the voltage or
current change, you'll flood userspace with junk. So you'll need to
have a "fuzz" like in the input device code; but this may be
client-specific or hardware-specific. And you'll need to identify
devices in a useful way, a problem that's not yet solved even for
input devices... You see where it's going.

  Shem
