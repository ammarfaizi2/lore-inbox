Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318693AbSHAJnr>; Thu, 1 Aug 2002 05:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318697AbSHAJnC>; Thu, 1 Aug 2002 05:43:02 -0400
Received: from h249n1fls32o848.telia.com ([213.66.33.249]:44541 "EHLO
	erland.stk.mvista.com") by vger.kernel.org with ESMTP
	id <S318689AbSHAJmb>; Thu, 1 Aug 2002 05:42:31 -0400
Message-Id: <200208010944.g719ioV04827@erland.stk.mvista.com>
Content-Type: text/plain; charset=US-ASCII
From: Erland Hedman <erland.hedman@mvista.com>
Reply-To: erland.hedman@mvista.com
Organization: MontaVista Software (Nordic)
To: linux-kernel@vger.kernel.org
Subject: APM Console blanking not complete ?
Date: Thu, 1 Aug 2002 11:44:50 +0200
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

With a 2.4.18 kernel running on a Dell Inspiron 8000 I have the BIOS APM 
console blanking working properly for both the VT consoles as well as in X, 
but only when the laptop's internal keyboard and mouse is used. After having 
browsed the kernel source I guess that this blanking, turning off the power 
to the laptop backlight, is handled by the APM features in the BIOS 
independent of the Linux kernel.

The problem is that when I use an external mice, in this case a wireless 
track ball connected to an USB port some distance from the laptop, a touch of 
that mice does not turn on the laptop backlight again as I first took for 
granted. It works in windows 2k  ;-(

By adding a timer routine to drivers/input/mousedev.c (inspired by console.c) 
I managed to "fix" my particular problem by implicitly  call the 
apm_console_blank()  (apm.c) via the console_blank_hook used by console.c and 
do the display blanking  timimg independent of the BIOS settings.

This is a fix however, and does not address the problem in a general way and 
I guess that USB a keyboard and possible other external devices will face the 
same problem. In addition it does not sync with any BIOS settings of the 
blanking time, nor does this  fix reset the timer if the laptops mouse or 
keyboard is touched.

So my question here (if my observations are valid) is if there are interest 
to address this issue and/or if there is any work in progress for future 
releases.

PS. The question is not related to DPMS, nor  to the VT console's blanking 
controlled by setterm. DS.

Please CC me at erland.hedman@telia.com
-- 

Best Regards,
Erland Hedman
