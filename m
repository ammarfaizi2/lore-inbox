Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750773AbWEVLvR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbWEVLvR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 07:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750775AbWEVLvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 07:51:17 -0400
Received: from mail.suse.de ([195.135.220.2]:43917 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750773AbWEVLvQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 07:51:16 -0400
To: "Yitzchak Eidus" <ieidus@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: how stable are the BogoMIPS and the udelay functions on "dynamic clock speed change cpus"
References: <e7aeb7c60605190237w3a8554adof6ec7f1ba7927ba7@mail.gmail.com>
From: Andi Kleen <ak@suse.de>
Date: 22 May 2006 13:32:34 +0200
In-Reply-To: <e7aeb7c60605190237w3a8554adof6ec7f1ba7927ba7@mail.gmail.com>
Message-ID: <p73very5m7h.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Yitzchak Eidus" <ieidus@gmail.com> writes:

> because udelay work on the principle that it know "how much work the
> cpu can do in a time" and it work by just doing a loop of nothing, how
> stable is it when the cpu clock rate is keep changing all the time?
> does it update its loops_per_jiffy varible each time the cpu clock is change?
> or does it have another solution to this problem?
> or since before the cpu enter to this udelay function it must do some
> work like entering the systemcall and so on , the cpu clock rate is
> jump to the original?

Only on very old systems (pre ACPI APM era) does cpu frequency change without
the kernel knowing (ignoring Intel thermal throttling which is a different thing) 

When the kernel knows it fixes loops_per_jiffy and normally does the necessary
synchronization over CPUs. 

Obviously at least on multi core systems there are races with this.

Modern Intel CPUs (Yonah, Prescott) completely avoid the problem
because they have a constantly ticking TSC that is independent from
the actual clock rate. And __delay uses the TSC to measure time.

-Andi
