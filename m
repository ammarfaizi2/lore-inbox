Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268331AbRHKP5H>; Sat, 11 Aug 2001 11:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268382AbRHKP44>; Sat, 11 Aug 2001 11:56:56 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:55670 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S268331AbRHKP4o>; Sat, 11 Aug 2001 11:56:44 -0400
Date: Sat, 11 Aug 2001 17:56:26 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Johannes Erdfelt <johannes@erdfelt.com>
Cc: "David S. Miller" <davem@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: struct page to 36 (or 64) bit bus address?
Message-ID: <20010811175626.O19169@athlon.random>
In-Reply-To: <20010809151022.C1575@sventech.com> <E15UvLO-0007tH-00@the-village.bc.nu> <15218.61869.424038.30544@pizda.ninka.net> <20010809163531.D1575@sventech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010809163531.D1575@sventech.com>; from johannes@erdfelt.com on Thu, Aug 09, 2001 at 04:35:32PM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2001 at 04:35:32PM -0400, Johannes Erdfelt wrote:
> It's not a big deal. It's just less efficient which isn't the end of the
> world.

It's not only less efficient, your machine is going to crash as soon as
you ask the iommu to map some giga of ram with the current state of
drivers (the API says that if you get null out of the map call you
should fallback, but no driver checks for this null retval and so in
turn they're all prone to crash, not going to be fixed in 2.4 I guess).
So try to reduce as much as possible the number of simultaneous pci
mappings and it will probably not crash.

Andrea
