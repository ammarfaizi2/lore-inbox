Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130531AbRBQM5w>; Sat, 17 Feb 2001 07:57:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130430AbRBQM5m>; Sat, 17 Feb 2001 07:57:42 -0500
Received: from nathan.polyware.nl ([193.67.144.241]:57350 "EHLO
	nathan.polyware.nl") by vger.kernel.org with ESMTP
	id <S129136AbRBQM52>; Sat, 17 Feb 2001 07:57:28 -0500
Date: Sat, 17 Feb 2001 13:57:23 +0100
From: Pauline Middelink <middelink@polyware.nl>
To: linux-kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] a more efficient BUG() macro
Message-ID: <20010217135723.A26653@polyware.nl>
Mail-Followup-To: Pauline Middelink <middelin@polyware.nl>,
	linux-kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <3A8E3BA5.4B98E94E@yahoo.com> <3A8E6E0C.2F205328@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3A8E6E0C.2F205328@colorfullife.com>; from manfred@colorfullife.com on Sat, Feb 17, 2001 at 01:26:52PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Feb 2001 around 13:26:52 +0100, Manfred Spraul wrote:
> Paul Gortmaker wrote:
> > 
> > Anyway this small patch makes sure there is only one "kernel BUG..." string,
> > and dumps __FILE__ in favour of an address value since System.map data is
> > needed to make full use of the BUG() dump anyways.  The memory stats of two
> > otherwise identical kernels:
> >
> 
> Shouldn't the linker drop duplicate strings?

Yes, but that wasn't his patch. He split off the
constant text in the bugline to a separate string and
made sure /that/ string was used only once.

The old way contained the 'kernel BUG at' string a
zillion times, now it only contains 'bla.c: 412'
and variants thereof a lot of times. (And most of
them are NO duplicates, or you would have had 2 BUGs
at the same line...

    Met vriendelijke groet,
        Pauline Middelink
-- 
GPG Key fingerprint = 2D5B 87A7 DDA6 0378 5DEA  BD3B 9A50 B416 E2D0 C3C2
For more details look at my website http://www.polyware.nl/~middelink
