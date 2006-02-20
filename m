Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030299AbWBTQJJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030299AbWBTQJJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 11:09:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030300AbWBTQJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 11:09:09 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:49880 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1030299AbWBTQJI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 11:09:08 -0500
Message-ID: <43F9E95A.6080103@cfl.rr.com>
Date: Mon, 20 Feb 2006 11:07:54 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: Flames over -- Re: Which is simpler?
References: <200602131116.41964.david-b@pacbell.net> <200602181251.09865.david-b@pacbell.net> <43F80ACC.20704@cfl.rr.com> <200602192150.05567.david-b@pacbell.net>
In-Reply-To: <200602192150.05567.david-b@pacbell.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Feb 2006 16:11:01.0006 (UTC) FILETIME=[3DD4C2E0:01C63638]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14279.000
X-TM-AS-Result: No--10.100000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:
> 
> Exactly:  ignore those disconnects in "some" cases.  Suspend-to-RAM
> will typically never report disconnects without a real unplug.  You
> want to add special casing for hibernate/swsusp.  (A point in favor
> of someone's claim that hibernate/swsusp is structurally harder.)
> 

Typical != always.  It may be more common for suspend to maintain usb 
power, but both suspend and hibernate may or may not maintain usb power, 
so the kernel needs to be prepared to deal with that in both cases.

> 
> Now with /dev/input/mice, the driver stack above USB is able to mask
> such disconnects.  It's not like mice maintain state that matters.
> The "ignore" is in stack layers way above USB, which can know a very
> important thing about mice:  they are stateless.
> 
> But with storage media, there is no such mechanism ... and there's
> significant state involved.  Adding a "reconnect" mechanism, and
> getting it wrong for storage, likely means corrupted file systems.
> And where even if it _is_ the same physical disk, there's no good
> reason to expect it hasn't been modified on some other usb host.
> (Toss hardware in bag, reuse as needed...)
> 

And this is exactly how non USB hardware has behaved for eons, and it 
hasn't been a problem.  If you want to add some verification to make 
reasonably sure that the media has not been modified, that is great, but 
you can't just automatically dump the filesystem and kill running 
processes and loose data just because something bad _may_ have happened.

> No thanks, I prefer data integrity.  And for that matter, re $SUBJECT,
> the much simpler approach of working _with_ the hardware architecture,
> not against it.
> 

Again, the hardware is perfectly free to power off the usb bus during 
suspend to ram.  Most systems choose not to because they allow wake from 
usb, but not all do.

> 
>>> But yes, you're right ... if he's serious about
>>> changing all that stuff, he also needs stop being a
>>> member of the "never submitted a USB patch" club.
>>> Ideally, starting with small things.
>> You're moving off into left field.
> 
> Not hardly.  Unless all you're doing here is flaming?
> One point of $SUBJECT was that flames were _over_ ...
> 

Left field is where flames are, which is what the comment was that I was 
replying to -- a flame.


