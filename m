Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753467AbWKCTBA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753467AbWKCTBA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 14:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753462AbWKCTBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 14:01:00 -0500
Received: from twinlark.arctic.org ([207.7.145.18]:43908 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP
	id S1753469AbWKCTA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 14:00:59 -0500
Date: Fri, 3 Nov 2006 11:00:58 -0800 (PST)
From: dean gaudet <dean@arctic.org>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
cc: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       linux-kernel@vger.kernel.org
Subject: Re: New filesystem for Linux
In-Reply-To: <Pine.LNX.4.64.0611030217570.7781@artax.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.64.0611031057410.26057@twinlark.arctic.org>
References: <Pine.LNX.4.64.0611022221330.4104@artax.karlin.mff.cuni.cz>
 <20061102235920.GA886@wohnheim.fh-wedel.de> <Pine.LNX.4.64.0611030217570.7781@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="131011217-763046379-1162580458=:26057"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--131011217-763046379-1162580458=:26057
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

On Fri, 3 Nov 2006, Mikulas Patocka wrote:

> > On Thu, 2 November 2006 22:52:47 +0100, Mikulas Patocka wrote:
> > > 
> > > new method to keep data consistent in case of crashes (instead of
> > > journaling),
> > 
> > Your 32-bit transaction counter will overflow in the real world.  It
> > will take a setup with millions of transactions per second and even
> > then not trigger for a few years, but when it hits your filesystem,
> > the administrator of such a beast won't be happy at all. :)
> > 
> > Jörn
> 
> If it overflows, it increases crash count instead. So really you have 2^47
> transactions or 65536 crashes and 2^31 transactions between each crash.

it seems to me that you only need to be able to represent a range of the 
most recent 65536 crashes... and could have an online process which goes 
about "refreshing" old objects to move them forward to the most recent 
crash state.  as long as you know the minimm on-disk crash count you can 
use it as an offset.

-dean

p.s. i could see a network device with spotty connectivity causing a large 
bump in crash count in a short period of time.

--131011217-763046379-1162580458=:26057--
