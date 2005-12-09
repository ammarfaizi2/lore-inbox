Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964864AbVLISad@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964864AbVLISad (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 13:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964869AbVLISac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 13:30:32 -0500
Received: from mx1.suse.de ([195.135.220.2]:60365 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964867AbVLISac (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 13:30:32 -0500
Message-ID: <4399CD28.9080000@suse.de>
Date: Fri, 09 Dec 2005 19:30:00 +0100
From: Stefan Seyfried <seife@suse.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050715 Thunderbird/1.0.6 Mnenhy/0.7.2.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@suse.cz>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][mm] swsusp: limit image size
References: <200512072246.06222.rjw@sisk.pl> <4399A737.40809@suse.de> <200512091804.22397.rjw@sisk.pl>
In-Reply-To: <200512091804.22397.rjw@sisk.pl>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael J. Wysocki wrote:
> On Friday, 9 December 2005 16:48, Stefan Seyfried wrote:
>
>> What happens if IMAGE_SIZE is bigger than free swap? Do we "try harder"
>> or do we fail?
> 
> First, with swsusp the image can't be bigger than 1/2 of lowmem (1/2 of RAM
> on x86-64) and the too great values of IMAGE_SIZE have no effect.  Still, if
> the amount of free swap is smaller than 1/2 of RAM and the image happens
> to be bigger, we will fail.

ok. This is not nice since we might fail without any _real_ need. Can we
make this parameter userspace-tweakable, so that my userspace app can do
something like (pseudocode):

    echo 500 > /sys/power/swsusp/imagesize
    echo disk > /sys/power/state
    R=$?
    if [ $R -eq $ENOMEM ]; then
        echo 100 > /sys/power/swsusp/imagesize # try again
        echo disk > /sys/power/state
        R=$?
    fi
    if [ $R -ne 0 ]; then
        pop_up_some_loud_beeping_window "suspend failed!"
    fi

This would at least give us a chance for a second try. I know that Pavel
dislikes userspace tunables, but i dislike failing suspends ;-)

Best regards,

    Stefan
-- 
Stefan Seyfried                  \ "I didn't want to write for pay. I
QA / R&D Team Mobile Devices      \ wanted to be paid for what I write."
SUSE LINUX Products GmbH, Nürnberg \                    -- Leonard Cohen
