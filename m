Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266798AbUBMOIN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 09:08:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266787AbUBMOIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 09:08:13 -0500
Received: from mx1.redhat.com ([66.187.233.31]:23700 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267002AbUBMOIJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 09:08:09 -0500
Date: Thu, 12 Feb 2004 20:13:40 +0000
From: Joe Thornber <thornber@redhat.com>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: Joe Thornber <thornber@redhat.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: dm core patches
Message-ID: <20040212201340.GB1898@reti>
References: <20040210163548.GC27507@reti> <20040211101659.GF3427@marowsky-bree.de> <20040211103541.GW27507@reti> <20040212185145.GY21298@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040212185145.GY21298@marowsky-bree.de>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 12, 2004 at 07:51:45PM +0100, Lars Marowsky-Bree wrote:
> I checked the archives, but I couldn't find anything really 'in flux'.
> Your priority based approach seems just fine to me.
> 
> What is still missing? This is really a killer feature for 2.6. Any help
> I can offer?

I think the main concern now is over the testing of paths.  Sending an
io down an inactive path can be very expensive for some hardware
configurations.  So I'm considering changing a couple of things:

- Only ever send io to 1 priority group at a time (even test ios).
  To test the lower priority groups we'd have to periodically switch to
  them and use them for a bit for both test io and proper io.

- For some hardware there are better ways of testing the path than
  sending the test io.  Should the drivers expose a test function ?
  In the absence of this we'd fallback to the test io method.

The other thing we need is to try and get the drivers to deferentiate
between a media error and a path error, so that media errors get
reported up quickly and don't cause false path failures.  This is
possibly an area that you could help with ?

- Joe
