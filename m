Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129906AbRBTThp>; Tue, 20 Feb 2001 14:37:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130228AbRBTThe>; Tue, 20 Feb 2001 14:37:34 -0500
Received: from ns2.cypress.com ([157.95.67.5]:60641 "EHLO ns2.cypress.com")
	by vger.kernel.org with ESMTP id <S129906AbRBTTh3>;
	Tue, 20 Feb 2001 14:37:29 -0500
Message-ID: <3A92C76C.6519DF1A@cypress.com>
Date: Tue, 20 Feb 2001 13:37:16 -0600
From: Thomas Dodd <ted@cypress.com>
Organization: Cypress Semiconductor Southeast Design Center
X-Mailer: Mozilla 4.76 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en-US, en-GB, en, de-DE, de-AT, de-CH, de, zh-TW, zh-CN, zh
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: kernel/printk.c: increasing the buffer size to capture devfsd debug 
 messages.
In-Reply-To: <3A92A99E.2F255CB3@yk.rim.or.jp> <20010220111542.A4106@tenchi.datarithm.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Read wrote:
> 
> On Wed, Feb 21, 2001 at 02:30:08AM +0900, Ishikawa wrote:
> >
> > Has anyone tried 128K buffer size in kernel/printk.c
> > and still have the kernel boot (without
> > hard to notice memory corruption problems  and other subtle bugs)?
> > Any hints and tips will be appreciated.
> 
> I have used 128k and larger buffer sizes, and I just noticed this
> fragment in the RedHat Tux Webserver patch.  It creates a 2MB buffer:

I think this should be a config option.
I use software RADI (md.o) and with 9 md devices,
the 16k buffer overflows, and I get md6-md0 in
the logs, but nothing prior to md6 being detected/started.

I bumbed it upo to 32K and checked the size ofter boot
and it's ~26K right now. If I add more partitions/disks
to the arrays, or more arrays, that'll be too small.

A dynamic size would be even better. Start with 1M
or so and add a dmesg hook to rezize it to 8-16K
and frre up the rest, so init scripts can save the
boot buffer, then keep a smaller buffer during
normal use. If you have problems you can change the
dmesg call to not change the buffer, and keep the
bigger buffer or perhaps make it even bigger.

Has anyone tried this before?

	-Thomas
