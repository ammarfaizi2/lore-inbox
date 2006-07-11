Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030194AbWGKG5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030194AbWGKG5M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 02:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030206AbWGKG5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 02:57:12 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:40927 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030194AbWGKG5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 02:57:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=HFbLq06MU+zFGQYbTL3ky1mTmhIWXROqLOV9NcP9+k3xgqlyT0LjBFDD1c+DEef8tYb1K2MlyQ9siQkUZtogLX16oRRegW0mWYJZ/IREMCqE/tUA4MDF9FLCt74r4s9NjjmtH3ZcVpOT/k97DnTFLtsBkUKpmkN8Y5tgkc7F4yw=
Message-ID: <44B34BBA.4010806@gmail.com>
Date: Tue, 11 Jul 2006 14:56:58 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Matt Reuther <mreuther@umich.edu>
CC: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Depmod errors on 2.6.17.4/2.6.18-rc1/2.6.18-rc1-mm1
References: <200607100833.00461.mreuther@umich.edu> <20060710113212.5ddn42t40ks44s00@engin.mail.umich.edu> <44B27931.30609@gmail.com> <200607102327.38426.mreuther@umich.edu>
In-Reply-To: <200607102327.38426.mreuther@umich.edu>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Reuther wrote:
> On Monday 10 July 2006 11:58 am, Antonino A. Daplas wrote:
>> Matt Reuther wrote:
>>> Quoting "Antonino A. Daplas" <adaplas@gmail.com>:
>>>> CONFIG_FB=n, CONFIG_BACKLIGHT_CLASS_DEVICE=m should not be possible in
>>>> 2.6.18-rc1-mm1 and 2.6.18-rc1.  Can you run kconfig again?
>>>>
>>>> Tony
>>> I am not at the computer right now, but I will try later.
>>>
>>> Here is how I got config-2.6.18-rc1-mm1. I copied this config from
>>> 2.6.18-rc1, which I had created with 'make menuconfig'. I ran 'make
>>> oldconfig' on the config-2.6.18-rc1 and answered the new questions to
>>> generate config-2.6.18-rc1-mm1. I compiled it from there. Does 'make
>>> oldconfig' not work properly anymore?
>> I really don't know.  I have received several bug reports where the
>> main cause was that a kconfig option changed after upgrading kernels.
>>
>> I tested with make menuconfig, and it's not possible to set lcd/backlight
>> options if CONFIG_FB is not set.
>>
>> Tony
> 
> I ran 'make menuconfig' and I got the same warnings. Perhaps CONFIG_FB needs 
> to be part of the 'selects' line for any option that selects the backlight 
> support. I think the USB Apple Cinema display support, which I set as 
> modular, might have selected backlight. I don't need framebuffer support, so 
> I have that shut off. Here are the depmod warnings once again:

Yes, that's the culprit.  I've been thinking for some time to eliminate
the framebuffer dependency from lcd/backlight.  Can you try the patch I sent
in another thread?

Tony
