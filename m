Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932425AbWDMC2b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932425AbWDMC2b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 22:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932427AbWDMC2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 22:28:31 -0400
Received: from smtpq1.tilbu1.nb.home.nl ([213.51.146.200]:6839 "EHLO
	smtpq1.tilbu1.nb.home.nl") by vger.kernel.org with ESMTP
	id S932425AbWDMC2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 22:28:30 -0400
Message-ID: <443DB7AE.4090605@keyaccess.nl>
Date: Thu, 13 Apr 2006 04:30:06 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: Russell King <rmk+lkml@arm.linux.org.uk>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Jean Delvare <khali@linux-fr.org>, Takashi Iwai <tiwai@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Is platform_device_register_simple() deprecated?
References: <443D3DED.5030009@keyaccess.nl> <20060412214108.GA12480@suse.de>
In-Reply-To: <20060412214108.GA12480@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

>> ALSA is using platform_device_register_simple(). Jean Delvare pointed:
>>
>> http://marc.theaimsgroup.com/?l=linux-kernel&m=113398060508534&w=2
>>
>> out, where _simple looks to be slated for removal. Is this indeed the 
>> case? ALSA isn't using the resources -- doing a manual alloc/add would 
>> not be a problem...
> 
> Great, care to convert ALSA to use the proper api so we can remove
> platform_device_register_simple()?

Sure. Before I go over them though, could you perhaps confirm that just 
doing a manual alloc/add _is_ this proper API? Ie, something like:

     device = platform_device_alloc(NAME, i);
     if (!device)
             return -ENOMEM;

     error = platform_device_add(device);
     if (error) {
             platform_device_put(device);
             return error;
     }

(there by the way are still a few users left outside ALSA as well)

Rene.
