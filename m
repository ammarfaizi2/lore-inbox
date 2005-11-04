Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161064AbVKDFLX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161064AbVKDFLX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 00:11:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161066AbVKDFLX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 00:11:23 -0500
Received: from smtp110.sbc.mail.re2.yahoo.com ([68.142.229.95]:54439 "HELO
	smtp110.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1161064AbVKDFLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 00:11:23 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: keyboard dies during failed suspend attempt
Date: Fri, 4 Nov 2005 00:11:17 -0500
User-Agent: KMail/1.8.3
Cc: Vojtech Pavlik <vojtech@ucw.cz>, LKML <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@suse.cz>
References: <4369D04C.70509@drzeus.cx>
In-Reply-To: <4369D04C.70509@drzeus.cx>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511040011.18393.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 November 2005 03:54, Pierre Ossman wrote:
> I discovered a problem with my laptop keyboard when the machine failed 
> to suspend. Pavel Machek pointed me in your direction for guidance. :)
> 
> The original issue (swsusp failing) is in this thread:
> 
> http://marc.theaimsgroup.com/?t=113093802700002&r=1&w=2
> 
> The side issue is that the keyboard goes completely dead when the 
> suspend fails like this. Not even hardware buttons that control the 
> intensity of the TFT backlight work.
> 

Are these controlled by ACPI?

> The problem doesn't happen every time, but it seems to be often enough 
> to do some decent testing.
> 
> The problem seems to have appeared after 2.6.14 was released. Since the 
>   problem is intermittent I can't be 100% sure of this, but it's fairly 
> likely since none of the tests before 2.6.14 failed.
>

It feels like device_resume is not called somewhere when swsusp fails.

Could you try activating debug mode for i8042:

	echo 1 > /sys/modules/i8042/parameters/debug

...and then making it fail. Then we'll see if i8042 resume methods are
called and whether they succeed.

-- 
Dmitry
