Return-Path: <linux-kernel-owner+w=401wt.eu-S1751013AbXANF2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751013AbXANF2f (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 00:28:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbXANF2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 00:28:35 -0500
Received: from usul.saidi.cx ([204.11.33.34]:42580 "EHLO usul.overt.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751013AbXANF2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 00:28:34 -0500
Message-ID: <45A9BF57.7050408@overt.org>
Date: Sat, 13 Jan 2007 21:27:51 -0800
From: Philip Langdale <philipl@overt.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Pierre Ossman <drzeus-list@drzeus.cx>
CC: LAK <linux-arm-kernel@lists.arm.linux.org.uk>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] MMC: Major restructuring and cleanup
References: <459CB3D2.4010707@drzeus.cx>
In-Reply-To: <459CB3D2.4010707@drzeus.cx>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Ossman wrote:
> Hi everyone,
> 
> As I've mentioned to some of you, I've been working on restructuring the MMC
> layer in order to make it more easily maintained and to allow extensions
> like SDIO support. A first draft of this is now ready for public review.
> I've cc:d those who have been waiting for this patch set (and Russell since
> he always gives blunt, but valuable feedback ;)).

So, I think I'm a bit too much of a kernel newbie to be able to provide a
definitive review, but I've looked over the changes and they look good to me.

I fully agree with the rearchitecturing - it makes it a lot easier to see
what's going on and it'll scale for SDIO (as you mention) and CE-ATA as well,
if we ever get a hold of any of those :-)

One concrete observation I'd make is that we should probably try and detect
MMC first instead of SD. Up until today, I'd have said it didn't really
matter, but I've been doing some reading and discovered that Protec make
some very strange cards they call "SuperSD" which can talk mmc4 and sd 1.1.
These will happily go along with either initialisation sequence - and as mmc4
is either the same or better than sd 1.1 from a performance point of view,
we should prefer it. This is independent of your restructuring, but as you're
fiddling with this code... :-)

http://www.hjreggel.net/cardspeed/special-sd.html#supersd

http://www.jactron.co.uk/pretec/ssd/consumer/super-sd.htm

--phil
