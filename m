Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932179AbWGaTf2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbWGaTf2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 15:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932190AbWGaTf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 15:35:28 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:56806 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S932179AbWGaTf1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 15:35:27 -0400
Date: Mon, 31 Jul 2006 21:35:07 +0200
From: bert hubert <bert.hubert@netherlabs.nl>
To: Robert Hancock <hancockr@shaw.ca>
Cc: David Rees <drees76@gmail.com>, Arjan van de Ven <arjan@infradead.org>,
       Tomasz Torcz <zdzichu@irc.pl>, linux-kernel@vger.kernel.org,
       zwane@arm.linux.org.uk
Subject: Re: 2.6.18 regression: cpufreq broken since 2.6.18-rc1 on pentium4
Message-ID: <20060731193507.GC16797@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <bert.hubert@netherlabs.nl>,
	Robert Hancock <hancockr@shaw.ca>, David Rees <drees76@gmail.com>,
	Arjan van de Ven <arjan@infradead.org>,
	Tomasz Torcz <zdzichu@irc.pl>, linux-kernel@vger.kernel.org,
	zwane@arm.linux.org.uk
References: <fa.I17h4UhBWCsvus2I0Myp7dcrW/c@ifi.uio.no> <fa.+Nle/k4hS56BZtGd2LF1VOaLvRg@ifi.uio.no> <44CE567D.40305@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44CE567D.40305@shaw.ca>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2006 at 01:14:05PM -0600, Robert Hancock wrote:

> per watt. As well, when the CPU has nothing to do it will be halted 
> anyway which does pretty much the same as what clockmod is doing.

You are empirically wrong in my case. I can't make you hear the difference
in noise, but perhaps this will convince you:

$ sensors | grep CPU
CPU_Fan:   2359 RPM  (min = 4000 RPM)                     
CPU:         +61 C  (low  =   +10 C, high =   +50 C)     

$ sudo /etc/init.d/powernowd start
 * Starting powernowd...  			[ ok ]

$ sensors | grep CPU
CPU_Fan:   1411 RPM  (min = 4000 RPM)                     
CPU:         +57 C  (low  =   +10 C, high =   +50 C)     

$ sudo /etc/init.d/powernowd stop
 * Stopping powernowd:				[ ok ]

$ sensors | grep CPU
CPU_Fan:   2452 RPM  (min = 4000 RPM)                     
CPU:         +61 C  (low  =   +10 C, high =   +50 C)     

And this with only seconds in between starting and stopping, on an idle
system.

> Essentially clockmod is there as a way to limit the thermal output of 
> the CPU in thermal emergencies, it's not really very good as a 
> power-saving feature.

That I've measured, and indeed, the same amount of power is drawn from the
mains. But the reduction in fan noise is worth it.

On this CPU, HLT may simply not be doing as good a job. Who knows.

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 4
model name      : Intel(R) Pentium(R) 4 CPU 3.00GHz
stepping        : 1
cpu MHz         : 3000.000
cache size      : 1024 KB

It does reduce effective CPU to 300MHz though, which is a lot.

Kind regards,

bert

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://netherlabs.nl              Open and Closed source services
