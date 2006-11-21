Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934296AbWKUCsF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934296AbWKUCsF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 21:48:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934294AbWKUCsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 21:48:05 -0500
Received: from smtp113.sbc.mail.mud.yahoo.com ([68.142.198.212]:59550 "HELO
	smtp113.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S966898AbWKUCsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 21:48:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=2n2BJ9jrDVsiMN+8/BLDIHXuxWslNrzjGZgvGMpPvAKC8+RS0Y/CGIq2D70/DcMh1Y4q551jRNzL5f66/CsAiW0NpWFTPIYls/Gopjr20H5qSEpU7rtjjGVj1QSIkCtLBxR6eYqoPeFsm2ZT/pMkHYUjGTil4jCHYBhBbdI4dxo=  ;
X-YMail-OSG: xq7DxCUVM1kZSI1VkgcOibssKKCOIfw4S2bUqdv8vCqFt3tABgDjNy4y5LPLB43.stKpM44uwNS5b7zukm8nOTFDzDLiXfBGaiLxH0IdtqUbxMM3K.wgZ2H761_ZXdWnM0UEVEEpms5pcFG9hvZehEEfzsyMnQ7P9oo-
From: David Brownell <david-b@pacbell.net>
To: Alessandro Zummo <alessandro.zummo@towertech.it>
Subject: Re: [Bulk] Re: [patch 2.6.19-rc6 1/6] rtc class /proc/driver/rtc update
Date: Mon, 20 Nov 2006 18:47:57 -0800
User-Agent: KMail/1.7.1
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
References: <200611201014.41980.david-b@pacbell.net> <200611201017.19961.david-b@pacbell.net> <20061121001352.55f3ce2b@inspiron>
In-Reply-To: <20061121001352.55f3ce2b@inspiron>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611201847.58135.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 November 2006 3:13 pm, Alessandro Zummo wrote:
> On Mon, 20 Nov 2006 10:17:19 -0800
> David Brownell <david-b@pacbell.net> wrote:
> 
> > Fix two minor botches in the procfs dumping of RTC alarm status:
> > 
> >  - Stop confusing "alarm enabled" with "wakeup enabled".
> > 
> >  - Don't display bogus "irq pending/un-acked" status; those are the rather
> >    pointless semantics EFI assigned to this (for a no-IRQs environment).
> 
>  I wouldn't change that, the /proc interface to rtc is old
>  and should not be used anyhow. Here I'm trying to mimic
>  the behaviour of the original one.

The "original" one never had such fields.  Even the efirtc.c
code (which originated those flags) didn't call them that;
it used "Enabled" not "alrm_enabled", so at least this patch
moves closer to that "original" behavior.


>  sysfs provides a much better interface
>  (once we'll have all the attributes exported, of course :) )

That's an orthgonal issue.  (Though one can argue that the
procfs file should be /proc/driver/rtc0 etc, one per RTC,
rather than /proc/driver/rtc...)


>  I don't know if there's any user space tool relying on this.

There shouldn't be any code parsing /proc/driver/rtc ... if there
is such stuff, it's already got so many variants to cope with that
adding one that actually matches the rest of the system would be
a net simplification.


>  If yes, then it should be fixed.
> 
>  Any thoughts?

The whole RTC framework is still labeled "experimental", and
AFAIK I'm the first person to audit the use of those flags.

Until it's no longer experimental, I have a hard time thinking
that backwards compatibility should prevent fixing such interface
bugs ... interface bugs are normally in the "fix ASAP" category,
since if you delay fixing them the costs grow exponentially.

- Dave
