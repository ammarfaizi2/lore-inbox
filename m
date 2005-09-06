Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964797AbVIFKer@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964797AbVIFKer (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 06:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964798AbVIFKer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 06:34:47 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:31697 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964797AbVIFKeq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 06:34:46 -0400
Date: Tue, 6 Sep 2005 12:32:32 +0200
From: Pavel Machek <pavel@suse.cz>
To: Lee Revell <rlrevell@joe-job.com>
Cc: vatsa@in.ibm.com, linux-kernel@vger.kernel.org, arjan@infradead.org,
       s0348365@sms.ed.ac.uk, kernel@kolivas.org, tytso@mit.edu,
       cfriesen@nortel.com, trenn@suse.de, george@mvista.com,
       johnstul@us.ibm.com, akpm@osdl.org
Subject: Re: [PATCH 1/3] Updated dynamic tick patches - Fix lost tick calculation in timer_pm.c
Message-ID: <20050906103232.GA22278@elf.ucw.cz>
References: <20050831165843.GA4974@in.ibm.com> <20050831171211.GB4974@in.ibm.com> <1125720301.4991.41.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1125720301.4991.41.camel@mindpipe>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > With this patch, time had kept up really well on one particular
> > machine (Intel 4way Pentium 3 box) overnight, while
> > on another newer machine (Intel 4way Xeon with HT) it didnt do so
> > well (time sped up after 3 or 4 hours). Hence I consider this
> > particular patch will need more review/work.
> > 
> 
> Are lost ticks really that common?  If so, any idea what's disabling
> interrupts for so long (or if it's a hardware issue)?  And if not, it
> seems like you'd need an artificial way to simulate lost ticks in order
> to test this stuff.

Try running this from userspace (and watch for time going completely
crazy). Try it in mainline, too; it broke even vanilla some time
ago. Need to run as root. 

								Pavel

void
main(void)
{
        int i;
        iopl(3);
        while (1) {
                asm volatile("cli");
                //              for (i=0; i<20000000; i++)
                for (i=0; i<1000000000; i++)
                        asm volatile("");
                asm volatile("sti");
                sleep(1);
        }
}


-- 
if you have sharp zaurus hardware you don't need... you know my address
