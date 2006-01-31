Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965054AbWAaAx1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965054AbWAaAx1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 19:53:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964976AbWAaAx1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 19:53:27 -0500
Received: from smtp-1.llnl.gov ([128.115.3.81]:34976 "EHLO smtp-1.llnl.gov")
	by vger.kernel.org with ESMTP id S965054AbWAaAx0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 19:53:26 -0500
From: Dave Peterson <dsp@llnl.gov>
To: Gunther Mayer <gunther.mayer@gmx.net>
Subject: Re: noisy edac
Date: Mon, 30 Jan 2006 16:53:15 -0800
User-Agent: KMail/1.5.3
Cc: "bluesmoke-devel@lists.sourceforge.net" 
	<bluesmoke-devel@lists.sourceforge.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060130185931.71975.qmail@web50112.mail.yahoo.com> <200601301552.09955.dsp@llnl.gov> <43DEA922.3030602@gmx.net>
In-Reply-To: <43DEA922.3030602@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601301653.15984.dsp@llnl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 30 January 2006 16:02, Gunther Mayer wrote:
> Just printk() the exact driver specific low-level error, even if non-fatal.
>
> Single non-fatal errors just show your system recovers correctly.
>
> Multiple (e.g. noisy) non-fatal are either an indication of a serious
> problem
>   (e.g. after how many corrected ECC errors on the same address in which
>     time interval will you replace your dimm? How many S-ATA CRC-errors
>      will indicate marginal bad cabling? )
> or it shows the problem needs to be root analyzed. But don't disable the
> messages as this will only hide the real problem.
>
> Concerning Non-Fatal PCI Express errors, the error cause registers need
> to be printed in case of error, too (see Intel Chipset Specifications)

I agree that in general, the kernel should not be silent when errors are
detected.  However, for a particular type of error, it may be that the
user is aware of the error (because (s)he has seen the messages), the user
has determined the root cause, and it turns out that the error is benign.
Therefore the user may want to suppress further messages of this type to
avoid cluttering the logs.  If you don't provide that option to the user,
then it can be viewed as hardcoding a certain aspect of sysadmin policy
into the kernel.

Depending on the particular type of error, it may be appropriate to just
offer the user two options: either printk() or be silent.  For other types
of errors, it may make sense to give the user more than two options (for
instance ignore, printk(), or panic()).  I think developers of chipset
drivers can make this decision individually for each type of error.
