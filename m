Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266052AbUGEMPF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266052AbUGEMPF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 08:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266056AbUGEMPF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 08:15:05 -0400
Received: from mlf.linux.rulez.org ([192.188.244.13]:64520 "EHLO
	mlf.linux.rulez.org") by vger.kernel.org with ESMTP id S266052AbUGEMPA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 08:15:00 -0400
Date: Mon, 5 Jul 2004 14:14:50 +0200 (MEST)
From: Szakacsits Szabolcs <szaka@sienet.hu>
To: Andries Brouwer <Andries.Brouwer@cwi.nl>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       "Patrick J. LoPresti" <patl@users.sourceforge.net>, bug-parted@gnu.org,
       Steffen Winterfeldt <snwint@suse.de>, Thomas Fehr <fehr@suse.de>,
       linux-kernel@vger.kernel.org, Andrew Clausen <clausen@gnu.org>,
       buytenh@gnu.org, msw@redhat.com
Subject: Restoring HDIO_GETGEO semantics for 2.6 (was: Re: [RFC] Restoring
 HDIO_GETGEO semantics)
In-Reply-To: <20040703005555.GA20808@apps.cwi.nl>
Message-ID: <Pine.LNX.4.21.0407041920480.11076-100000@mlf.linux.rulez.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 3 Jul 2004, Andries Brouwer wrote:
> 
> But it is true, returning 0 in all other fields would have made
> it more clear that there is no attempt to return the BIOS geometry.
> It might be a good idea to do that.

I fail to see how that would solve _now_ the _current_ serious problem
with HDIO_GETGEO.

There are three different problems.

 1) 2.6 kernels made very visible that the widely used Parted, libparted,
    etc are severely broken. They should be FIXED. Off-topic on linux-kernel.

 2) The semantic change of HDIO_GETGEO severely broke widely used, critical 
    tools. This issue should be HANDLED, preferable as soon as possible. 
    The original thread was supposed to be only about this issue.

 3) There are cases when tools need to invent, not-to-be-discussed-now,
    geometry for different kind of purposes. This should be IMPLEMENTED.

The HDIO_GETGEO facts we have are

    - the new HDIO_GETGEO code seriously broke backward compatibility

    - the old HDIO_GETGEO code still exists, just the values are thrown 
      away, as Andries wrote recently

    - nobody could point out any _technical_ benefit why the new HDIO_GETGEO
      code is better than the old one (the _way_ Andries wanted to push the
      code to user space was quite "unlucky")

    - nobody complained if anything would break if HDIO_GETGEO were restored

    - returning 0 values have an unpredictable impact. Hence perhaps the
      change shouldn't be done in the 2.6 kernels to avoid yet another 
      brown paper bag.

Considering all the above points, it seems logical from practical point 
of view, that the restoration of the old HDIO_GETGEO functionality (or
something that's very close to its behaviour) _temporarily_ for 2.6
kernels makes sense.

Of course this wouldn't mean to be as a fix for the above 1) and 3)
problems. It's the restoration of the user space compatibility _and_
preparation for appropriate HDIO_GETGEO removal.

	Szaka

