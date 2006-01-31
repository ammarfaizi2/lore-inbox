Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030291AbWAaDXK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030291AbWAaDXK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 22:23:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030297AbWAaDXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 22:23:10 -0500
Received: from 66.239.25.20.ptr.us.xo.net ([66.239.25.20]:49037 "EHLO
	zoot.lnxi.com") by vger.kernel.org with ESMTP id S1030291AbWAaDXJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 22:23:09 -0500
To: Dave Peterson <dsp@llnl.gov>
Cc: Gunther Mayer <gunther.mayer@gmx.net>,
       "bluesmoke-devel@lists.sourceforge.net" 
	<bluesmoke-devel@lists.sourceforge.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: noisy edac
References: <20060130185931.71975.qmail@web50112.mail.yahoo.com>
	<200601301552.09955.dsp@llnl.gov> <43DEA922.3030602@gmx.net>
	<200601301653.15984.dsp@llnl.gov>
From: ebiederman@lnxi.com (Eric W. Biederman)
Date: Mon, 30 Jan 2006 20:22:42 -0700
In-Reply-To: <200601301653.15984.dsp@llnl.gov> (Dave Peterson's message of
 "Mon, 30 Jan 2006 16:53:15 -0800")
Message-ID: <m3zmldjd31.fsf@maxwell.lnxi.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Peterson <dsp@llnl.gov> writes:

> On Monday 30 January 2006 16:02, Gunther Mayer wrote:
>> Just printk() the exact driver specific low-level error, even if non-fatal.
>>
>> Single non-fatal errors just show your system recovers correctly.
>>
>> Multiple (e.g. noisy) non-fatal are either an indication of a serious
>> problem
>>   (e.g. after how many corrected ECC errors on the same address in which
>>     time interval will you replace your dimm? How many S-ATA CRC-errors
>>      will indicate marginal bad cabling? )
>> or it shows the problem needs to be root analyzed. But don't disable the
>> messages as this will only hide the real problem.
>>
>> Concerning Non-Fatal PCI Express errors, the error cause registers need
>> to be printed in case of error, too (see Intel Chipset Specifications)
>
> I agree that in general, the kernel should not be silent when errors are
> detected.  However, for a particular type of error, it may be that the
> user is aware of the error (because (s)he has seen the messages), the user
> has determined the root cause, and it turns out that the error is benign.
> Therefore the user may want to suppress further messages of this type to
> avoid cluttering the logs.  If you don't provide that option to the user,
> then it can be viewed as hardcoding a certain aspect of sysadmin policy
> into the kernel.
>
> Depending on the particular type of error, it may be appropriate to just
> offer the user two options: either printk() or be silent.  For other types
> of errors, it may make sense to give the user more than two options (for
> instance ignore, printk(), or panic()).  I think developers of chipset
> drivers can make this decision individually for each type of error.

One piece missing from this conversation is the issue that we need errors
in a uniform format.  That is why edac_mc has helper functions.

However there will always be errors that don't fit any particular model.
Could we add a edac_printk(dev, );  That is similar to dev_printk but
prints out an EDAC header and the device on which the error was found?
Letting the rest of the string be user specified.

For actual control that interface may be to blunt, but at least for people
looking in the logs it allows all of the errors to be detected and harvested.

Eric
