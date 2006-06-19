Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932123AbWFSB0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbWFSB0A (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 21:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbWFSB0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 21:26:00 -0400
Received: from mail23.syd.optusnet.com.au ([211.29.133.164]:37349 "EHLO
	mail23.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751145AbWFSBZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 21:25:59 -0400
From: Con Kolivas <kernel@kolivas.org>
To: "Albert Cahalan" <acahalan@gmail.com>
Subject: Re: [ckpatch][15/29] hz-no_default_250.patch
Date: Mon, 19 Jun 2006 11:25:49 +1000
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <787b0d920606181752j4b7c7309t9c0ab9bf8da1537a@mail.gmail.com>
In-Reply-To: <787b0d920606181752j4b7c7309t9c0ab9bf8da1537a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606191125.50826.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 19 June 2006 10:52, Albert Cahalan wrote:
> > Make 250 HZ a value that is not selected by default and give some
> > better recommendations in help.
>
> No, 250 is a good default.
>
> We can't reliably do 1000. There are many systems, including both
> laptops and servers, which have a BIOS that uses SMM/SMI to grab
> the CPU for longer than a millisecond. We'd lose clock ticks if
> we had HZ at 1000.

We do not lost clock ticks on ordinary desktops at HZ==1000 which is what I'm 
recommending here. For servers and laptops I'm recommending 100.

> NTSC video is 59.94 fields per second. Though a sample rate of
> double that would satisfy the Nyquest theory, in practice you
> need to go to 4x to 5x the rate you want. This comes out to be
> around 240 to 300 as a minimum.

Yes I understand that but there is also the matter that we don't guarantee 
timers actually even succeed at the HZ value. In practice our timers, even at 
almost no load, only can guarantee firing 2 or 3 ticks after the time we 
requested. This means we need timers to be about 3x higher than the 250 we 
need.

> Then there is the matter of picking a value that is very close
> to being an integer factor of the standard PC clock. I don't
> remember how well 250 did, but here is the code I once used
> to compute such things:

Yes I stored a family of these values and 864 was ~ the optimum for a high 
value for desktops and ~84 for a low value but were unpopular for not being 
something decimally familiar. Also lots of code kind of broke with values 
below 100 in the kernel.

Thanks!

-- 
-ck
