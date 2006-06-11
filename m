Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750711AbWFKNAN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbWFKNAN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 09:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751251AbWFKNAM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 09:00:12 -0400
Received: from thunk.org ([69.25.196.29]:33938 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1750711AbWFKNAK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 09:00:10 -0400
Date: Sun, 11 Jun 2006 08:59:29 -0400
From: Theodore Tso <tytso@mit.edu>
To: Bruce Allen <ballen@gravity.phys.uwm.edu>
Cc: Justin Piszcz <jpiszcz@lucidpixels.com>,
       Jan-Benedict Glaw <jbglaw@lug-owl.de>, apiszcz@solarrain.com,
       smartmontools-support@lists.sourceforge.net,
       Remy Card <Remy.Card@linux.org>, linux-kernel@vger.kernel.org,
       "Theodore Ts'o" <tytso@alum.mit.edu>,
       David Beattie <dbeattie@softhome.net>
Subject: Re: [smartmontools-support] The Death and Diagnosis of a Dying Hard Drive - Is S.M.A.R.T. useful?
Message-ID: <20060611125929.GA8438@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Bruce Allen <ballen@gravity.phys.uwm.edu>,
	Justin Piszcz <jpiszcz@lucidpixels.com>,
	Jan-Benedict Glaw <jbglaw@lug-owl.de>, apiszcz@solarrain.com,
	smartmontools-support@lists.sourceforge.net,
	Remy Card <Remy.Card@linux.org>, linux-kernel@vger.kernel.org,
	Theodore Ts'o <tytso@alum.mit.edu>,
	David Beattie <dbeattie@softhome.net>
References: <Pine.LNX.4.64.0606100615500.15475@p34.internal.lan> <20060610105141.GE30775@lug-owl.de> <Pine.LNX.4.64.0606100658130.26702@p34.internal.lan> <Pine.LNX.4.62.0606102212060.17718@trinity.phys.uwm.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0606102212060.17718@trinity.phys.uwm.edu>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 10, 2006 at 10:15:59PM -0500, Bruce Allen wrote:
> I am surprised that the extended self-test does not detect the bad sectors 
> on your disk.  Our experience is that the typical SYSLOG 'seek failure' 
> error messages do correlate very well with the failing LBAs found via 
> SMART self-tests.

My guess is that it didn't detect the errors for the same reason that
a read-only scan using badblocks didn't detect the problems, while a
read/write scan did.

What *did* surprise me a little is that after the bad block had been
detected by badblocks -w and was remapped by the disk drive, but
before it had been forcibly rewritten (so that now reads of the block
would return errors to the OS) that the extended self-test didn't
return an error.  I guess as far as the disk was concerned, the block
had been remapped, so everything was OK.

The real question though is whether the disk continues to work OK from
this point forward, or whether it is a prelude to an ever-increasing
number of bad blocks.  If it is the latter, and S.M.A.R.T. still
didn't give any warning, then it would certainly be an indictment of
that particular manufacturer's S.M.A.R.T. implementation.  

						- Ted
