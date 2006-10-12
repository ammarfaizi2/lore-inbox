Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422753AbWJLPzA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422753AbWJLPzA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 11:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422738AbWJLPy7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 11:54:59 -0400
Received: from cantor2.suse.de ([195.135.220.15]:56450 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1422725AbWJLPy5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 11:54:57 -0400
From: Andreas Schwab <schwab@suse.de>
To: Luca Tettamanti <kronos.it@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: [PATCH 2.6.19-rc1] radeonfb: check return value of sysfs_create_bin_file
References: <20061011235328.GA13264@dreamland.darkstar.lan>
	<1160611646.4792.24.camel@localhost.localdomain>
	<20061012154505.GA6014@dreamland.darkstar.lan>
X-Yow: I'm working under the direct orders of WAYNE NEWTON to deport
 consenting adults!
Date: Thu, 12 Oct 2006 17:54:55 +0200
In-Reply-To: <20061012154505.GA6014@dreamland.darkstar.lan> (Luca Tettamanti's
	message of "Thu, 12 Oct 2006 17:45:05 +0200")
Message-ID: <jey7rlo7g0.fsf@sykes.suse.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luca Tettamanti <kronos.it@gmail.com> writes:

> Il Thu, Oct 12, 2006 at 10:07:26AM +1000, Benjamin Herrenschmidt ha scritto: 
>> On Thu, 2006-10-12 at 01:53 +0200, Luca Tettamanti wrote:
>> > sysfs_create_bin_file() is marked as warn_unused_result but we don't
>> > actually check the return value.
>> > Error is not fatal, the driver can operate fine without the files so
>> > just print a notice on failure.
>> 
>> I find this whole business of must check return value for sysfs files to
>> be gratuitous bloat. There are many cases (like this one) where we don't
>> really care and a printk will just increase the kernel size for no good
>> reason.
>> 
>> Maybe we can have a macro we can use to silence the warning when we
>> don't care about the result ? Can gcc do that ?
>
> Ugly macro:
>
> #define UNCHECKED(func) do { if (func) {} } while(0)

Better, but only marginally:

#define UNCHECKED(func) (void)(func)

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
