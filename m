Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263892AbTJEW24 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 18:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263893AbTJEW24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 18:28:56 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:64004 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S263892AbTJEW2x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 18:28:53 -0400
Date: Mon, 6 Oct 2003 00:28:17 +0200
From: Willy TARREAU <willy@w.ods.org>
To: Jay Vosburgh <fubar@us.ibm.com>, shmulik.hen@intel.com,
       "Chad N. Tindel" <chad@tindel.net>, bonding-devel@lists.sourceforge.net,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
       "Noam, Amir" <amir.noam@intel.com>,
       "Mendelson, Tsippy" <tsippy.mendelson@intel.com>,
       "Noam, Marom" <noam.marom@intel.com>
Subject: Re: [Bonding-announce] [PATCH SET][bonding] cleanup
Message-ID: <20031005222817.GA2527@pcw.home.local>
References: <shmulik.hen@intel.com> <200309252011.53960.shmulik.hen@intel.com> <200309251733.h8PHXWpV013559@death.ibm.com> <20030925211259.GA59653@calma.pair.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030925211259.GA59653@calma.pair.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

On Thu, Sep 25, 2003 at 05:13:00PM -0400, Chad N. Tindel wrote:
 
> I was specifically told by David Miller that we are not to break binary
> compatibility within a 2.4 release.  Such things had to wait until 2.5 
> or later.  We can not require a user to upgrade their ifenslave within a 2.4
> series kernel just to keep using the same functionality they were using in 
> 2.4.1.

I strongly agree. I have been facing this problem and it was really a pain. I
used the last bonding version which didn't define the ABI version, together
with the associated ifenslave, but when the need to upgrade to plain 2.4.22
came in, I had the surprize of getting a non-working bonding because this
intermediate ifenslave. Well, I upgraded it to latest version, which prevents
me from downgrading to the previous kernel because it has ABIv2 with no version,
so the newer ifenslave thinks it's an ABIv1. So the result is a symlink with
two versions of ifenslave on the disk, just in case I have to downgrade.

Although I agree it's clearly my fault and I should have been more careful, I
prefer to warn everyone about the consequences this might have on production
systems. Schmulik has done quite a great job here, and I believe most of it
should be integrated, but we have to carefully test each combination of old/new
ifenslave with old/new driver if we don't want to break some setups or prevent
admins from downgrading if something goes wrong.

Cheers,
Willy

