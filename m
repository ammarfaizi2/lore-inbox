Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932673AbWCPSI7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932673AbWCPSI7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 13:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932691AbWCPSI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 13:08:59 -0500
Received: from [84.204.75.166] ([84.204.75.166]:46040 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP id S932673AbWCPSI6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 13:08:58 -0500
Message-ID: <4419A9B8.8060102@yandex.ru>
Date: Thu, 16 Mar 2006 21:08:56 +0300
From: "Artem B. Bityutskiy" <dedekind@yandex.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050923 Fedora/1.7.12-1.5.1
X-Accept-Language: en, ru, en-us
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [Bug? Report] kref problem
References: <1142509279.3920.31.camel@sauron.oktetlabs.ru> <20060316165323.GA10197@kroah.com> <4419A426.9080908@yandex.ru> <20060316175858.GA7124@kroah.com>
In-Reply-To: <20060316175858.GA7124@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> If you use decl_subsys(), you should be fine for this.  Use that instead
> of trying to roll your own subsystem kobjects please.  That
> infrastructure was written for a reason...
Ok, I see, thanks. I just thought that this subsystem stuff will oblige 
me to use the device/driver/bus model which does not suit me.

> Data (kobjects) have a different lifespan than code (modules).
> Seperating them is a good idea, and if not, your reference counting
> issues can be quite nasty.  See the recent EDAC fiasco for a good
> example of how easy it is to mess things up in this manner.

My logic was that the lifetime of that kobject = lifetime of my module 
because I cannot remove the module because every it's user increments 
the module's refcount. So, if refcount of my module is zero then the 
kobject's refcount is zero. Why this doesn't this work?

Note, I do not object, I agree that in general you're right, I'm just 
wonering.

-- 
Best Regards,
Artem B. Bityutskiy,
St.-Petersburg, Russia.
