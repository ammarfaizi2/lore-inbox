Return-Path: <linux-kernel-owner+w=401wt.eu-S965094AbXAJUxd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965094AbXAJUxd (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 15:53:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965099AbXAJUxd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 15:53:33 -0500
Received: from smtp109.sbc.mail.mud.yahoo.com ([68.142.198.208]:43046 "HELO
	smtp109.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S965095AbXAJUxc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 15:53:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Disposition:Message-Id:Content-Type:Content-Transfer-Encoding;
  b=CANq/gKChi79bHRrxZKRqLI1r29lGV9lXiAuRXl+bNa7zYiyso5DlntDIExFgdirTKB0LCtFCpLoutJzLxQJ3mM9RdK9jhyjYRnWObAfKMvSnmgo6L90oglMPaKPY7yLTH41QEVD3ujtjgrOVCNUAVaziqvMbWUmh/xjAysFtwg=  ;
X-YMail-OSG: 4JWGangVM1m99Iga5Pl523gEogtUTvXKpXoWbEhGAyRhDCmAHTu1po9pDu0qZygI6qqS3qLW5KjK1Dhwou1diobIiR8w9jEvfz9h0zKFEYmZ4cJfDyxukG5_CJmq71QySRc2S8rAnzenqyU-
From: David Brownell <david-b@pacbell.net>
To: Nicolas Ferre <nicolas.ferre@rfo.atmel.com>
Subject: Re: [patch 2.6.20-rc1 6/6] input: ads7846 directly senses PENUP state
Date: Wed, 10 Jan 2007 12:04:08 -0800
User-Agent: KMail/1.7.1
Cc: Dmitry Torokhov <dtor@insightbb.com>, Imre Deak <imre.deak@solidboot.com>,
       linux-kernel@vger.kernel.org, tony@atomide.com
References: <20061222192536.A206A1F0CDB@adsl-69-226-248-13.dsl.pltn13.pacbell.net> <200612291226.46984.david-b@pacbell.net> <459D05EC.9010907@rfo.atmel.com>
In-Reply-To: <459D05EC.9010907@rfo.atmel.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200701101204.08859.david-b@pacbell.net>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 January 2007 5:49 am, Nicolas Ferre wrote:
> 
> I face an issue using the hrtimer instead of the old timer framework 
> (your patch #4/6). It seems that I do not sample at a sufficient rate 
> using hrtimer : I see squares when drawing circles ;-)

Why do you suspect the sample rate rather than e.g. filtering or lowlevel
SPI issues?  Have you verified that e.g. the voltage sensor on ads7843
is giving you the right results?


> Do you know if the hrtimer framework has an issue on at91 or do I have 
> to code something to have a low res timer support in the hrtimer framework ?

No particular notion here ... I thought that if the hrtimer patch wasn't
installed (plus clocksource and clockevents patches, which struck me as
awkward on the at91sam926x parts compared to the at91rm9200) it would work
automagically in low-res timer mode (jiffies) using the same API.

So while applying highres timer patches would be possible, it's not supposed
to matter.  I suspect you could just revert the ads7846 hrtimer patch, to
see if that's the issue.

Did you rule out the issue being with the lowlevel AT91 SPI driver?  It's
been problematic in the past ... there's a bitbanging driver that could
help rule that out (or in).

Another low-effort tweak would be telling Kconfig to use HZ=512 or somesuch.
(A power-of-two value dividing the 32KHz clock better than multiple-of-ten.)
That'd increase the resolution of your "low res" timestamps.

- Dave
