Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262367AbVBCLXl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262367AbVBCLXl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 06:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262311AbVBCLNz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 06:13:55 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:64388 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262472AbVBCLI2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 06:08:28 -0500
Subject: Re: Deadlock in serial driver 2.6.x
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: rmk+lkml@arm.linux.org.uk, e9925248@student.tuwien.ac.at,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050131004857.07f5e2c4.akpm@osdl.org>
References: <20050126132047.GA2713@stud4.tuwien.ac.at>
	 <20050126231329.440fbcd8.akpm@osdl.org>
	 <1106844084.14782.45.camel@localhost.localdomain>
	 <20050130164840.D25000@flint.arm.linux.org.uk>
	 <1107157019.14847.64.camel@localhost.localdomain>
	 <20050131004857.07f5e2c4.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1107332396.14847.112.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 03 Feb 2005 10:02:54 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-01-31 at 08:48, Andrew Morton wrote:
> >  The tty layer cannot fix this for now, and I don't intend to fix it. Fix
> >  the serial driver: the fix is quite simple since you can keep a field in
> >  the driver for now to detect recursive calling into the echo case and
> >  don't relock.
> 
> Are we sure that the serial driver is the only one which will hit this
> deadlock?

Yes fairly sure. The feature has been a well known but non-documented
property of the tty layer since about 1.0. There are two ways I see to
clean it up - we
can have the serial driver behave like other drivers and if need be
known about
recursive entries or we could extend the driver interface with an "echo"
method used by line disciplines when calling back to the tty driver from
a data
receive event.

Alan

