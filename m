Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbUAFIbz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 03:31:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbUAFIbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 03:31:55 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:46321 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261270AbUAFIby
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 03:31:54 -0500
Subject: Re: [2.6.0-mm2] PM timer still has problems
From: john stultz <johnstul@us.ibm.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Karol Kozimor <sziwan@hell.org.pl>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjanv@redhat.com>, jw schultz <jw@pegasys.ws>
In-Reply-To: <200401050117.06681.dtor_core@ameritech.net>
References: <20031230204831.GA17344@hell.org.pl>
	 <20031230200249.107b56f0.akpm@osdl.org>
	 <20040104004449.GA20647@hell.org.pl>
	 <200401050117.06681.dtor_core@ameritech.net>
Content-Type: text/plain
Message-Id: <1073377877.2752.38.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 06 Jan 2004 00:31:18 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-01-04 at 22:17, Dmitry Torokhov wrote:
> I decided to go hpet way and use tsc in ACPI PM timer to do delay stuff
> and monotonic clock. 

I think you have a valid point that as loops_per_jiffy isn't updated,
delay_pmtmr() and delay_pit() are broken w/ CPUFREQ.  

However I don't understand using the TSC for montonic_clock. I have no
clue why the HPET folks implemented it that way (likely my fault for not
enough documentaiton), but I haven't had the time to try to clean up
that code. And really, if your TSC is reliable enough for
monotonic_clock, why are you using the pmtmr? :) Unless it specifically
is resolving an issue, I'd drop that change. 

> Plus there some code rearrangements, and stuff I grabbed
> from the CPUFREQ list (Dominics + Li Shahoua P4 variable tsc info ), etc...
> If there is an interest I can split the code into smaller chinks. 

Yes. Please do split out the white space, and the cpufreq changes as
well. I realize that the patch is very inter-woven, but atleast those
two changes are fairly seperable. 

> For what
> it worth I am running with ACPI PM timer, CPUFREQ (dynamically switching
> frequency based on load) and Synaptics and everything is calm. Ntpd has also
> stopped complaining about loosing sync...

Its very good this is working for you! However, I'd definately like to
narrow down the specific change that causes it to work.

thanks for the strong interest and effort!
-john

