Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992884AbWJTW3G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992884AbWJTW3G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 18:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992887AbWJTW3G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 18:29:06 -0400
Received: from webserve.ca ([69.90.47.180]:15048 "EHLO computersmith.org")
	by vger.kernel.org with ESMTP id S2992884AbWJTW3F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 18:29:05 -0400
Message-ID: <45394D10.3000503@wintersgift.com>
Date: Fri, 20 Oct 2006 15:26:24 -0700
From: teunis <teunis@wintersgift.com>
User-Agent: Icedove 1.5.0.7 (X11/20061013)
MIME-Version: 1.0
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: various laptop nagles - any suggestions? (note: 2.6.19-rc2-mm1
 but applies to multiple kernels)
References: <4537A25D.6070205@wintersgift.com>	 <20061019194157.1ed094b9.akpm@osdl.org>	 <4538F9AD.8000806@wintersgift.com>	 <20061020110746.0db17489.akpm@osdl.org> <d120d5000610201213v3ee2144cp4642f1812dfe7884@mail.gmail.com>
In-Reply-To: <d120d5000610201213v3ee2144cp4642f1812dfe7884@mail.gmail.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Dmitry Torokhov wrote:
> On 10/20/06, Andrew Morton <akpm@osdl.org> wrote:
>> On Fri, 20 Oct 2006 09:30:37 -0700
>> teunis <teunis@wintersgift.com> wrote:
>>
>> >
>>
>> Please don't play with the Cc:s!  Just do reply-to-all, thanks.
>>
>> > Andrew Morton wrote:
>> > > On Thu, 19 Oct 2006 09:05:49 -0700
>> > > teunis <teunis@wintersgift.com> wrote:
>> > >
>> > >> -----BEGIN PGP SIGNED MESSAGE-----
>> > >> Hash: SHA1
>> > >>
>> > >> Setting the internal clock to 100 Hz stablizes the laptop - and the
>> > >> synaptics touchpad stops "crashing"  (when "crashed" the pad
>> reads out
>> > >> all kinds of seemingly random values).   I would suspect the driver
>> > >> needs adjusting for the variable clock.   Also - it's definitely
>> nicer
>> > >> on the laptop power use as far as I can tell - should this be in the
>> > >> documentation?
>> > >
>> > > So you're saying that CONFIG_NO_HZ breaks the touchpad?
>> >
>> > yes.  At least for Acer Travelmate 8000 and HP nx6310 and HP nx7400.
>> > Other than the touchpad - there is not a lot of common hardware between
>> > these units.   The readout becomes highly unreliable.   (in X it starts
>> > jumping around - it SORT OF resembles the output)
>> >
>> > My suspicion is a timing problem in the synaptic USB driver
>>
>> OK, that's going to be hard to fix and it'd be awkward (and unpopular) to
>> make inclusion of the dynamic-ticks feature dependent on fixing this.
>> (Then again, it'd get Ingo into device drivers ;))
>>
> 
> I wonder if the problem is with the in-kernel synaptics driver or with
> X (itself or synaptics driver in it). Does the touchpad misbehaves
> when you using GPM on text console? What about when you using legacy
> mouse driver (as opposed to synaptics) in X?
> 

Not sure - but testing now.

on the flip side it seems that ACPI C3 (???) - restore after suspend to
RAM anyways - halts high resolution timer and NO_HZ on one of the laptops.
At that point the synaptics freezes solid.

I've had CONFIG_NO_HZ disabled already but am now testing with high
resolution timer turned off.  (I'm too used to desktops)

with that test I can be -almost- certain it's a kernel problem.

now off to figure why ndiswrapper now doesn't load....  (it's a GPL
module and the kernel claims it isn't... something changed but I'm not
sure what yet as it works with rc1-git6)

- - Teunis
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFOU0GbFT/SAfwLKMRAiufAJ4nds4qf7e29GWHTwabrrqV/kjt+wCdE+h4
OFnqetyHrxg5O8GyNErgA2U=
=oc4d
-----END PGP SIGNATURE-----
