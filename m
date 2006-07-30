Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932270AbWG3LdF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbWG3LdF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 07:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932272AbWG3LdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 07:33:05 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:1098 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932271AbWG3LdD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 07:33:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JA7cnpQOSsLmKq+WzZjhMQ9Vb68/3dT+Uyq2Muf3dsC6YbqTwe28so1a/pjNy+3FMnjZGSntAv6k9sSaCdGeCsPiEb/DXuCFEXKXmVKNby2rQRIpxOnX+1hyvfhWopmTqF0DiEeaE4Nhb2lUEz3n97xUGglW7ymlTIpPWjYJGnE=
Message-ID: <41840b750607300433t7a0c3708q1bd1ccbcfca9c31d@mail.gmail.com>
Date: Sun, 30 Jul 2006 14:33:01 +0300
From: "Shem Multinymous" <multinymous@gmail.com>
To: "Pavel Machek" <pavel@suse.cz>
Subject: Re: Generic battery interface
Cc: "Vojtech Pavlik" <vojtech@suse.cz>, "Brown, Len" <len.brown@intel.com>,
       "Matthew Garrett" <mjg59@srcf.ucam.org>,
       "kernel list" <linux-kernel@vger.kernel.org>,
       linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org,
       "Greg KH" <greg@kroah.com>, "Jean Delvare" <khali@linux-fr.org>
In-Reply-To: <41840b750607300314t3280fd04ne17bb663c385fd6b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <CFF307C98FEABE47A452B27C06B85BB6011688D8@hdsmsx411.amr.corp.intel.com>
	 <41840b750607271332q5dea0848y2284b30a48f78ea7@mail.gmail.com>
	 <20060727232427.GA4907@suse.cz>
	 <41840b750607271727q7efc0bb2q706a17654004cbbc@mail.gmail.com>
	 <20060728074202.GA4757@suse.cz> <20060728122508.GC4158@elf.ucw.cz>
	 <20060728134307.GD29217@suse.cz> <20060730091848.GC3801@elf.ucw.cz>
	 <41840b750607300314t3280fd04ne17bb663c385fd6b@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/30/06, Shem Multinymous <multinymous@gmail.com> wrote:
> Alternatively, we can add an extra parameter to that new
> syscall/ioctl: "block until the time is T+N and you have a refresh
> that was received from the hardware at time T+M, whichever is later"
> (where T is the current time and N>M).
>
> That's semantically equivalent to an msleep(M) followed by the
> original delayed_update(N-M),  but will save one timer interrupt per
> iteration in some cases (e.g., an event-based hardware data source).

No, wait, the explicit two-parameter version is far superior.

First, it makes it easier to poll multiple attributes. How'd you do
that with the one-parameter version, if you need to sleep separately
for each attribute?

Second, it gives the driver (or its sysfs support infrastructure) a
better picture of the future, which it can use to optimize the
hardware query scheduling. No, I don't think anyone will implement
*that* soon, but it's good to have an API that lets us add it later
without affecting userspace.


Is anyone interested in adding this "delayed updates" support to
sysfs, for the benefit of hwmon, tp_smapi and probably numerous other
drivers?
I have some ideas for how to do it so that that per-driver support is
really easy (or even free), but I don't know sysfs well enough to
implement it and don't have the resources.

  Shem
