Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262509AbUDEN5T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 09:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262542AbUDEN5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 09:57:19 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:36762 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S262509AbUDEN5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 09:57:17 -0400
Date: Mon, 5 Apr 2004 09:44:41 -0400
From: Ben Collins <bcollins@debian.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Marcel Lanz <marcel.lanz@ds9.ch>
Subject: Re: [PANIC] ohci1394 & copy large files
Message-ID: <20040405134440.GA13168@phunnypharm.org>
References: <20040404141600.GB10378@ds9.ch> <20040404141339.GW13168@phunnypharm.org> <200404050003.13758.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404050003.13758.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2004 at 12:03:10AM -0500, Dmitry Torokhov wrote:
> On Sunday 04 April 2004 09:13 am, Ben Collins wrote:
> > On Sun, Apr 04, 2004 at 04:16:00PM +0200, Marcel Lanz wrote:
> > > Since 2.6.4 and still in 2.6.5 I get regurarly a Kernel panic if I try
> > > to backup large files (10-35GB) to an external attached disc (200GB/JFS) via ieee1394/sbp2.
> > > 
> > > Has anyone similar problems ?
> > 
> > Known issue, fixed in our repo. I still need to sync with Linus once I
> > iron one more issue and merge some more patches.
> > 
> 
> I have some concerns that it is completely fixed in your tree - there is still
> a race - if hpsb_packet_received arrives before hosb_packet_sent then there is
> a chance that the code will try to put the same packet in the completion queue
> twice. With SVN tree it will cause kernel BUG in skb code, in BK tree kernel
> will just oops.
> 
> I wonder what was the reason to convert the code to abuse skbs aside for using
> skbs queues and their locking?
> 
> Anyway, below is a backport of my patch from SVN to BK tree, I would like to
> know if it works for others...

That's the other problem I was talking about. I'm reviewing your patch
today.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
