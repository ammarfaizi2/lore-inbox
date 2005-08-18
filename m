Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932461AbVHRVae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932461AbVHRVae (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 17:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932465AbVHRVae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 17:30:34 -0400
Received: from blackbird.sr71.net ([64.146.134.44]:38280 "EHLO
	blackbird.sr71.net") by vger.kernel.org with ESMTP id S932461AbVHRVae
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 17:30:34 -0400
Subject: Re: [Hdaps-devel] Re: HDAPS, Need to park the head for real
From: Dave Hansen <dave@sr71.net>
To: Adam Goode <adam@evdebs.org>
Cc: Pavel Machek <pavel@suse.cz>, Jens Axboe <axboe@suse.de>,
       Alejandro Bonilla Beeche <abonilla@linuxwireless.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       hdaps devel <hdaps-devel@lists.sourceforge.net>
In-Reply-To: <1124399756.28353.0.camel@lynx.auton.cs.cmu.edu>
References: <1124205914.4855.14.camel@localhost.localdomain>
	 <20050816200708.GE3425@suse.de>  <20050818204904.GE516@openzaurus.ucw.cz>
	 <1124399756.28353.0.camel@lynx.auton.cs.cmu.edu>
Content-Type: text/plain
Date: Thu, 18 Aug 2005 14:30:31 -0700
Message-Id: <1124400632.6546.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-18 at 17:15 -0400, Adam Goode wrote:
> On Thu, 2005-08-18 at 22:49 +0200, Pavel Machek wrote:
> > Please make it "echo 1 > frozen", then userspace can do "echo 0 > frozen"
> > after five seconds.
>
> What if the code to do "echo 0 > frozen" is swapped out to disk? ;)

In the real world, to be really sure that you're not doing a trip out to
the disk, you'll need a daemon which doesn't do any allocations between
when it's notified and when it does the write to the control file.

In reality, that probably means a statically compiled daemon that
mlock()s itself, and any structures that it will need.  It _might_ even
need to keep an open file descriptor on the "frozen" file.  Because, in
theory, that file could be written out to the sysfs backing store.

-- Dave

