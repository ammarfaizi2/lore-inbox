Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262473AbVC3W5j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262473AbVC3W5j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 17:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262474AbVC3W5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 17:57:39 -0500
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:32433 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S262473AbVC3W5g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 17:57:36 -0500
From: David Brownell <david-b@pacbell.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11, USB: High latency?
Date: Wed, 30 Mar 2005 14:57:35 -0800
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503301457.35464.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoth kus@keba.com:
> Even when the errors described in my previous mail does not occur,
> massive USB stick transfers cause latencies of 1 to 2 milliseconds,
> which is way too much for realtime control systems. 

I couldn't find that previous email in the MARC archives.

Regardless, you'd have to provide a small bit of information about
your hardware configuration.  What device speed:  full or high?
What controller:  EHCI, OHCI, UHCI, something else?  Which driver
for the stick:  usb-storage, or ub?  What else was using memory
and PCI bandwidth at the time?  SMP?


Quoth rlevell@joe-job.com:
> I think this is connected to a problem people have been reporting on the
> Linux audio lists.  With some USB chipsets, USB audio interfaces just
> don't work.  There are dropouts even at very high latencies.  

Well, I'd not yet expect USB audio to work over EHCI quite yet,
though one of the patches Greg just posted should help some of
the issues with full speed iso through USB 2.0 hubs.  (At least
for OUT transfers as to speakers.)

You might consider reporting such issues on the Linux-USB list.
It's been ages since anyone reported such a bug with the OHCI
or UHCI drivers ... probably why folk have assumed there are
no problems there.


Something to consider specifically with audio.  That uses the
isochronous transfer mode, reserving USB bandwidth.  But I've
certainly seen systems with PCI busses that are severely clogged,
so that the USB controllers have a hard time accessing main
memory.  Even a perfectly functional USB stack will have a hard
time with such hardware!

- Dave
