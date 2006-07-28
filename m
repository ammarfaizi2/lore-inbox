Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750920AbWG1A1E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750920AbWG1A1E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 20:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750918AbWG1A1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 20:27:04 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:62609 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750790AbWG1A1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 20:27:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=H8OjN4jPoI963hB4a2erT/1RCMyqZaIEUn3RREoVERhuD3ZIi1VBI0rDD/xI1Qupw2ynuaV/YlvYfOMXOESD4/iCfobU5gjdQ4lDqR48nBjv4HbszdxioSDZhfT9ic+caD2V8xc/H94ak97zdMKTc8fkW7bcbcEkd4x4+FKKYKA=
Message-ID: <41840b750607271727q7efc0bb2q706a17654004cbbc@mail.gmail.com>
Date: Fri, 28 Jul 2006 03:27:00 +0300
From: "Shem Multinymous" <multinymous@gmail.com>
To: "Vojtech Pavlik" <vojtech@suse.cz>
Subject: Re: Generic battery interface
Cc: "Brown, Len" <len.brown@intel.com>, "Pavel Machek" <pavel@suse.cz>,
       "Matthew Garrett" <mjg59@srcf.ucam.org>,
       "kernel list" <linux-kernel@vger.kernel.org>,
       linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org
In-Reply-To: <20060727232427.GA4907@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <CFF307C98FEABE47A452B27C06B85BB6011688D8@hdsmsx411.amr.corp.intel.com>
	 <41840b750607271332q5dea0848y2284b30a48f78ea7@mail.gmail.com>
	 <20060727232427.GA4907@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/28/06, Vojtech Pavlik <vojtech@suse.cz> wrote:
> > Battery polling is already used extensively, and its overhead is
> > completely negligible.
>
> You're joking, right? On quite a number of laptops, it takes quite a
> while to read the battery, spent in BIOS through SMI, polling the I2C
> bus while talking to the battery. The less often this is done, the
> better.

Yes, I know -- tp_smapi does that too. And it's still negligible,
usually a few microseconds.

Heck, the hdaps driver polls that same I2C bus 50 times per seconds
and still doesn't tickle the load average.


> > I'm yet to see any deployed userspace code
> > trying to query battery status more than once per second.
>
> The applets that were doing it (yes, up to 100 times per second)
> corrected their ways pretty quickly, because some machines became
> unusable with the applet enabled.

Exactly -- and they've been working merrily ever since.
And if you don't want to trust applet developers, cache the latest
reads and refresh them only if X jiffies have passed.


> You could, trivially, mirror the behavior of current applets: Not report
> the changes to the battery status more often than each N seconds, except
> for critical events.

You're taking a polling-based hardware, exposing it as an event-based
interface, and then and kludging it so that it behaves like polling
again...

So, in this scheme, how many lines of code does is the equivalent of
"cat /sys/devices/platform/smapi/BAT0/voltage"?


> > And you'll need to identify devices in a useful way, a problem that's
> > not yet solved even for input devices... You see where it's going.
>
> May you be more specific here? I'm not aware of any problems in this
> area. This may be my fault: What needs to be fixed there?

"Generic interface for accelerometers (AMS, HDAPS, ...)" on LKML, a
few weeks ago, about moving accelerator-based hard disk parking from
sysfs polling to the the input infrastructure. One unresolved issue
was how to find which input device happens to be the relevant
accelerometer.

  Shem
