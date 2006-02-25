Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030249AbWBYNe5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030249AbWBYNe5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 08:34:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030250AbWBYNe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 08:34:57 -0500
Received: from ns1.suse.de ([195.135.220.2]:33431 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030249AbWBYNe4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 08:34:56 -0500
From: Andi Kleen <ak@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: Status of X86_P4_CLOCKMOD?
Date: Sat, 25 Feb 2006 14:36:29 +0100
User-Agent: KMail/1.9.1
Cc: Johannes Stezenbach <js@linuxtv.org>, Dave Jones <davej@redhat.com>,
       Dmitry Torokhov <dtor_core@ameritech.net>, davej@codemonkey.org.uk,
       Zwane Mwaikambo <zwane@commfireservices.com>,
       Samuel Masham <samuel.masham@gmail.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, cpufreq@lists.linux.org.uk
References: <20060214152218.GI10701@stusta.de> <200602250527.03493.ak@suse.de> <20060225125326.GJ3674@stusta.de>
In-Reply-To: <20060225125326.GJ3674@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602251436.29546.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 25 February 2006 13:53, Adrian Bunk wrote:
On Sat, Feb 25, 2006 at 05:27:01AM +0100, Andi Kleen wrote:
> > On Saturday 25 February 2006 02:57, Johannes Stezenbach wrote:
> > > On Thu, Feb 23, 2006, Dave Jones wrote:
> > > > On Thu, Feb 23, 2006 at 08:59:37PM +0100, Adrian Bunk wrote:
> > > >  > And if the option is mostly useless, what is it good for?
> > > >
> > > > It's sometimes useful in cases where the target CPU doesn't have any
> > > > better option (Speedstep/Powernow).  The big misconception is that it
> > > > somehow saves power & increases battery life. Not so.
> > > > All it does is 'not do work so often'.  The upside of this is
> > > > that in some sit> uations, we generate less heat this way.
> > >
> > > Doesn't less heat imply less power consumption?
> >
> > Not in this case no.
> >...
>
> Sorry for the dumb question, but how could this work physically?
>
> If a computer produces less heat with the same power consumption, what
> happens with the other energy?

It's consumed over a longer time. In throttling mode the CPU skips
doing work on clock ticks. This temporarily lowers the local heat
that comes from switching transistors, but if the system has some 
computation to do it will take longer to do it until the machine can go to 
idle again and do real power saving.

This means on a global scale you're not saving anything, in fact
you're wasting more power.

There are sometimes secondary effects like the air condition
of your server room may consume less power if the peak
heat is lower, but they likely only apply in very specialized 
circumstances.

It's basically only a last measure that the CPU tries to cool itself
down a bit before forcibly shutting down. It's also not really
designed to be used in normal operation, so you end up
with problems like TSC timing being wrong or extremly
long user visible latencies to switch back to normal operation.

-Andi
