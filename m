Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266352AbUINX7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266352AbUINX7E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 19:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266633AbUINX7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 19:59:04 -0400
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:24495 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S266352AbUINX7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 19:59:02 -0400
Date: Wed, 15 Sep 2004 01:58:24 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Gianni Tedesco <gianni@scaramanga.co.uk>
Cc: Greg KH <greg@kroah.com>, "Marco d'Itri" <md@Linux.IT>,
       "Giacomo A. Catenazzi" <cate@pixelized.ch>,
       linux-kernel@vger.kernel.org
Subject: Re: udev is too slow creating devices
Message-ID: <20040914235824.GH3365@dualathlon.random>
References: <41474926.8050808@nortelnetworks.com> <20040914195221.GA21691@kroah.com> <414757FD.5050209@pixelized.ch> <20040914213506.GA22637@kroah.com> <20040914214552.GA13879@wonderland.linux.it> <20040914215122.GA22782@kroah.com> <20040914224731.GF3365@dualathlon.random> <20040914230409.GA23474@kroah.com> <20040914232011.GG3365@dualathlon.random> <1095204880.8493.153.camel@sherbert>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095204880.8493.153.camel@sherbert>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 12:34:40AM +0100, Gianni Tedesco wrote:
> Surely fsck can be done on top of /etc/dev.d/ by just writing to a FIFO?
> That'll serialize up the fsck caller...

with file locking in /var/run I didn't necessairly meant to call
flock(2), the fifo in your example would act like a mutex lock, but more
than the fifo, we need a bit more of API, the dev.d script will have to
look for a certain file in /var/run and block on it to serialize. I just
hope the spin loops will go away soon from the userspace ;)
