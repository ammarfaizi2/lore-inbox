Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750891AbWG0Qte@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750891AbWG0Qte (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 12:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751751AbWG0Qte
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 12:49:34 -0400
Received: from iabervon.org ([66.92.72.58]:35088 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1750889AbWG0Qtd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 12:49:33 -0400
Date: Thu, 27 Jul 2006 12:50:39 -0400 (EDT)
From: Daniel Barkalow <barkalow@iabervon.org>
To: Shem Multinymous <multinymous@gmail.com>
cc: "Brown, Len" <len.brown@intel.com>, Pavel Machek <pavel@suse.cz>,
       Matthew Garrett <mjg59@srcf.ucam.org>, vojtech@suse.cz,
       kernel list <linux-kernel@vger.kernel.org>,
       linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org
Subject: Re: Generic battery interface
In-Reply-To: <41840b750607270923j21074661v6254ba52ec67b67a@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0607271236440.9789@iabervon.org>
References: <CFF307C98FEABE47A452B27C06B85BB6011259C4@hdsmsx411.amr.corp.intel.com>
 <41840b750607270923j21074661v6254ba52ec67b67a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jul 2006, Shem Multinymous wrote:

> On 7/27/06, Brown, Len <len.brown@intel.com> wrote:
> > Path names and file names in sysfs are an API, so it is important
> > to choose them wisely.  The string "acpi" should not appear in
> > any path-name or file-name in sysfs that is intended to be generic,
> > as it would make no sense on a non-ACPI system.
> >
> > Neither the ACPI /proc/acpi/battery API or
> > the tp_smapi /sys/devices/platform/smapi API qualify as generic.
> > It it a historical artifact that /proc/acpi exists, I'd delete it
> > immediately if that wouldn't instantly break every distro on earth.
> 
> Yes. But it looks like we'll have a hard time finding this common
> interface, due to overlaps and omissions between battery drivers.

Maybe it would be best to have a virtual driver that knows about the union 
of the features, and makes whatever features are provided by the 
underlying driver available to userspace. That way, all of the drivers are 
implementing features out of a shared set, so you don't end up with 
thinkpad/force_discharge and something/discharge_battery. This is the 
principle behind, for example, the generic cdrom driver, which doesn't 
actually implement much but rather provides uniformity across devices 
handled by different drivers.

I don't think this is a case where each driver provides very similar 
functionality, but with critical differences which can't be corrected for; 
it seems like features are clearly available or not.

Of course, userspace can figure out which features are available by 
checking which files exist in the sysfs directory.

	-Daniel
*This .sig left intentionally blank*
