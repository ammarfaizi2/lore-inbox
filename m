Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129289AbQLARnp>; Fri, 1 Dec 2000 12:43:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129700AbQLARng>; Fri, 1 Dec 2000 12:43:36 -0500
Received: from cp912944-a.mtgmry1.md.home.com ([24.18.149.178]:20693 "EHLO
	zalem.puupuu.org") by vger.kernel.org with ESMTP id <S129289AbQLARnW>;
	Fri, 1 Dec 2000 12:43:22 -0500
Date: Fri, 1 Dec 2000 12:12:48 -0500
From: Olivier Galibert <galibert@pobox.com>
To: Tigran Aivazian <tigran@veritas.com>
Cc: Alexander Viro <viro@math.psu.edu>, Hugh Dickins <hugh@veritas.com>,
        Andries Brouwer <aeb@veritas.com>, linux-kernel@vger.kernel.org
Subject: Re: access() says EROFS even for device files if /dev is mounted RO
Message-ID: <20001201121248.A13401@zalem.puupuu.org>
Mail-Followup-To: Tigran Aivazian <tigran@veritas.com>,
	Alexander Viro <viro@math.psu.edu>, Hugh Dickins <hugh@veritas.com>,
	Andries Brouwer <aeb@veritas.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0011291051010.14112-100000@weyl.math.psu.edu> <Pine.LNX.4.21.0011291636440.1306-100000@penguin.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.21.0011291636440.1306-100000@penguin.homenet>; from tigran@veritas.com on Wed, Nov 29, 2000 at 04:40:29PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2000 at 04:40:29PM +0000, Tigran Aivazian wrote:
> b) what should be the return of access(W_OK) (or, the same, open() for 
> write with switched uid) for devices on a readonly-mounted filesystems?
> 
> Should the majority win? I.e. should we say OK, as we do now?

My gut feeling on this is that when you mount a filesystem readonly
you mean "I don't want the filesystem to be modifiable".  Opening a
device for write never modifies the filesystem directly.  Devices are
gateways to resources external to the filesystem, the write permission
means something different for them.

Same is for sockets/pipes btw.

And I really wonder how you plan to fsck / if it has been uncleanly
unmounted and includes /dev.

  OG.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
