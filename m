Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283689AbRK3Psp>; Fri, 30 Nov 2001 10:48:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283685AbRK3Psf>; Fri, 30 Nov 2001 10:48:35 -0500
Received: from hermes.domdv.de ([193.102.202.1]:7443 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S283689AbRK3Psb>;
	Fri, 30 Nov 2001 10:48:31 -0500
Message-ID: <XFMail.20011130164603.ast@domdv.de>
X-Mailer: XFMail 1.5.1 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <E169ndI-0003WU-00@the-village.bc.nu>
Date: Fri, 30 Nov 2001 16:46:03 +0100 (CET)
Organization: D.O.M. Datenverarbeitung GmbH
From: Andreas Steinmetz <ast@domdv.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: kapm-idled no longer idling CPU?
Cc: <dglidden@illusionary.com ((Derek Glidden))>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not really. It depends on 'how in sync' kapm-idled is running with other
processes. It's easy to monitor on the laptop as the bios changes the color of
a LED during idle calls. Quite often when the laptop is nearly fully idle (a
bit of CPU for kmix and the dhcp client, easily verified with top) there are no
idle calls. When there's idle calls in this state (0.00<load<0.1) it's always
less than 50% idle time.
Maybe taking the load average into account for going idle or introducing some
jitter around HZ for the kamp-idled sleep can help.
What may irritate other people furthermore is that if the system idles via
kapm-idled this is accounted as system cpu time instead of idle time so it does
look like the system is constantly under load when it actually does idle calls.

On 30-Nov-2001 Alan Cox wrote:
>> system_idle itself just checks, if nr_running is 1. This means that if any
>> single other process is runnable every HZ time when apm_idled checks the
>> system
>> state it won't switch to idle state even if the system is otherwise idle. I
>> do
>> see this behaviour e.g. all the time with KDE.
> 
> Uggh - yes, that makes horrible sense. Does it behave any better if you
> check say load average for the past 15 seconds < .1 ?
> 

Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH
