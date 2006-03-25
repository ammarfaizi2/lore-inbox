Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751272AbWCYAiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbWCYAiM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 19:38:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbWCYAiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 19:38:12 -0500
Received: from smtpq3.tilbu1.nb.home.nl ([213.51.146.202]:11984 "EHLO
	smtpq3.tilbu1.nb.home.nl") by vger.kernel.org with ESMTP
	id S1751238AbWCYAiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 19:38:10 -0500
Message-ID: <4424912F.2080109@keyaccess.nl>
Date: Sat, 25 Mar 2006 01:39:11 +0100
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Takashi Iwai <tiwai@suse.de>
CC: Greg Kroah-Hartman <gregkh@suse.de>,
       ALSA devel <alsa-devel@alsa-project.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ALSA] ISA drivers bailing on first IS_ERR
References: <4423848E.9030805@keyaccess.nl> <s5hslp8nlpk.wl%tiwai@suse.de>
In-Reply-To: <s5hslp8nlpk.wl%tiwai@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai wrote:

> These looks OK to me.  Could you regenerate patches against the latest
> git (or ALSA CVS) ?
> 
> Or, it might be better against to mm tree, since pnp registrations
> will be modified there, too.  They should go also to mainstream
> together.

Will do.

> Nevertheless, the patches (this and the previous one) are good to go
> to stable tree, too.

I'll wait a bit for a comment from Greg on the error propagation thing 
and will submit both then.

Even when simply returning the error as the patch to bus_add_device() 
did, there's a problem in that driver_probe_device() specifically 
ignores -ENODEV and -ENXIO. I suppose that's for hotpluggable stuff, 
where do you do want the driver loaded even without devices...

I guess for -stable the minimal fix would be to make sure all the probe 
methods do not return -ENODEV. I'll audit them for that. For mainline, 
it might be a better idea to have an option in the platform_driver 
struct that, no, we certainly don't want to ignore -ENODEV for this 
ancient non-hotplug non-pnp ISA stuff.

Needs a comment from Greg as well.

Rene.
