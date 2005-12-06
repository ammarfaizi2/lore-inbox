Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964931AbVLFCYe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964931AbVLFCYe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 21:24:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964932AbVLFCYe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 21:24:34 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:15254 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S964931AbVLFCYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 21:24:32 -0500
Subject: Re: swsusp performance problems in 2.6.15-rc3-mm1
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Andy Isaacson <adi@hexapodia.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20051206020626.GO22168@hexapodia.org>
References: <20051205081935.GI22168@hexapodia.org>
	 <20051205121728.GF5509@elf.ucw.cz>
	 <1133791084.3872.53.camel@laptop.cunninghams>
	 <200512052328.01999.rjw@sisk.pl> <1133832773.6360.38.camel@localhost>
	 <20051206020626.GO22168@hexapodia.org>
Content-Type: text/plain
Organization: Cyclades
Message-Id: <1133835586.3896.33.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 06 Dec 2005 12:21:08 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi. Tue, 2005-12-06 at 12:06, Andy Isaacson wrote:
> Could we rework it to avoid writing clean pages out to the swsusp image,
> but keep a list of those pages and read them back in *after* having
> resumed?  Maybe do the /dev/initrd ('less +/once Documentation/initrd.txt'
> if you're not familiar with it) trick to make the list of pages available 
> to a userland helper.

The problem is that once you let userspace run, you have absolutely no
control over what pages are read from or written to, and if a userspace
app assumes that data is there in a page when it isn't, you have a
recipe for an oops at best, and possibly for on disk corruption. Pages
that haven't been read yet could conceivably be set up to be treated as
faults, but then we're making things a lot more complicated than Pavel
or I want to do. That's why a good portion of the improvements in
Suspend2 have concentrated on making the process work faster - doing
more than one I/O at a time results in a good performance improvement.

Regards,

Nigel

