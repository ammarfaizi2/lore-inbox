Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274789AbRJaWZI>; Wed, 31 Oct 2001 17:25:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275265AbRJaWY6>; Wed, 31 Oct 2001 17:24:58 -0500
Received: from mercury.Sun.COM ([192.9.25.1]:43262 "EHLO mercury.Sun.COM")
	by vger.kernel.org with ESMTP id <S274434AbRJaWYm>;
	Wed, 31 Oct 2001 17:24:42 -0500
Message-ID: <3BE07C91.6BCAB167@sun.com>
Date: Wed, 31 Oct 2001 14:34:57 -0800
From: Tim Hockin <thockin@sun.com>
Organization: Sun Microsystems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.12C5_V i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Patrick Mochel <mochel@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        torvalds@transmeta.com, alan@redhat.com, p_gortmaker@yahoo.com
Subject: Re: [PATCH] don't reset alarm interrupt on RTC
In-Reply-To: <Pine.LNX.4.33.0110311408330.11035-100000@osdlab.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mochel wrote:

> -       tmp &=  ~RTC_AIE;
> +       //tmp &=  ~RTC_AIE;
>         tmp &=  ~RTC_UIE;
>         CMOS_WRITE(tmp, RTC_CONTROL);
>         CMOS_READ(RTC_INTR_FLAGS);
 
> Why would you want to unconditionally enable this interrupt?

We don't unconditionally set it, we just leave it enabled (the code was
uncoditionally UNsetting it).  There are ioctl()s to set/unset PIE, AIE,
UIE.

> And how do you set the alarm time?

ioctl(fd, RTC_ALM_SET);
 
> But, I don't think this should be enabled by default.

if anything, our patch is not correct ENOUGH.  none of AIE, PIE, or UIE,
should be molested by rtc_release().

-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Cobalt Server Appliances
thockin@sun.com
