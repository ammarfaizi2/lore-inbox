Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287408AbSBISUP>; Sat, 9 Feb 2002 13:20:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289055AbSBISUH>; Sat, 9 Feb 2002 13:20:07 -0500
Received: from ns1.alcove-solutions.com ([212.155.209.139]:58634 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S287408AbSBIST6>; Sat, 9 Feb 2002 13:19:58 -0500
Date: Sat, 9 Feb 2002 19:19:55 +0100
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Felix Seeger <felix.seeger@gmx.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: sonypi in 2.4.18-pre9
Message-ID: <20020209181955.GB32401@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
In-Reply-To: <20020209115453Z288878-13996+19685@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020209115453Z288878-13996+19685@vger.kernel.org>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 09, 2002 at 12:48:34PM +0100, Felix Seeger wrote:

> Great I just want to say that sonypi in 2.4.18-pre9 works fine.

Thanks.

> I have a vaio pcg qr10. This is the first kernel Version in which I can 
> changing the background lite.

Strange, the screen brightness code wasn't modified in a while. What
was your latest kernel ?

> Just one Problem. Maybe a spicctrl Problem but if I try to get infos like:
> spicctrl -p
> BAT1: 2202/2479 88.83%
> 
> It works fine.
> 
> But sometimes (every 10 times) I get this:
> BAT1: 2191/44975 4.87%
[...]

Known problem, not sure if it's a timing io port access problem 
or something else. This will be properly resolved in the 2.5
version of the sonypi driver, when the screen brightness / battery
status etc will be directly accessed through the ACPI layer.

> As you can see I can get the battery status from spicctrl. But apm can't get 
> the status, is there a way to enable apmd to use sonypi, or work correct.
> This is the output from /proc/apm:
> 1.16 1.2 0x03 0x01 0xff 0x80 -1% -1 ?

APM is screwed on most sony (and other recent, not  sony) laptops.
The only way to get this working is to use ACPI instead of APM 
(but since ACPI support is not and will not be complete in the 2.4
kernels, you will not have sleep/hibernation support etc).

That's why I added the battery query functions to the sonypi driver,
to work around buggy apm bioses and incomplete ACPI kernel support.
You can then hack the application inquiring the power status to
execute spicctrl instead of reading from /proc/apm.

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
