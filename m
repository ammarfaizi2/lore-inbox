Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266048AbRGCXJM>; Tue, 3 Jul 2001 19:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266051AbRGCXJC>; Tue, 3 Jul 2001 19:09:02 -0400
Received: from pizda.ninka.net ([216.101.162.242]:58066 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S266048AbRGCXIv>;
	Tue, 3 Jul 2001 19:08:51 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15170.20516.201818.401387@pizda.ninka.net>
Date: Tue, 3 Jul 2001 16:07:16 -0700 (PDT)
To: Guenter.Millahn@Informatik.TU-Cottbus.DE (Guenter Millahn)
Cc: Aaron Lehmann <aaronl@vitelus.com>, linux-kernel@vger.kernel.org,
        jakub@redhat.com
Subject: Re: Linux speed on sun4c
In-Reply-To: <20010703175922.A7970@pt.Informatik.TU-Cottbus.DE>
In-Reply-To: <20010630220612.C14361@vitelus.com>
	<15166.50418.583094.554723@pizda.ninka.net>
	<20010703175922.A7970@pt.Informatik.TU-Cottbus.DE>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Guenter Millahn writes:
 > David, can you publish your idea for a fix? Possibly anybody elese can make
 > the patch?

Currently under Linux when a constext is recycled because a new
context is needed but all are in use, we basically toss all of
the MMU segments that context owned.

This is bogus because if the contexts are the limited resource
not the MMU segments themselves, we take a lot of false MMU
misses on each context switch for no reason.

The solution is to link the MMU segment software state structures
into the mm_struct.  When an 'mm' reacquires a hw context, if any
MMU segments remain on the mm's list, just pluck them back into
the MMU.

Later,
David S. Miller
davem@redhat.com
