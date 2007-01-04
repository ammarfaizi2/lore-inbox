Return-Path: <linux-kernel-owner+w=401wt.eu-S932305AbXADH7L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305AbXADH7L (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 02:59:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbXADH7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 02:59:11 -0500
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:40183 "EHLO
	smtp.drzeus.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932305AbXADH7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 02:59:09 -0500
Message-ID: <459CB3D2.4010707@drzeus.cx>
Date: Thu, 04 Jan 2007 08:59:14 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.9 (X11/20061223)
MIME-Version: 1.0
To: LAK <linux-arm-kernel@lists.arm.linux.org.uk>,
       LKML <linux-kernel@vger.kernel.org>
CC: Russell King <rmk+lkml@arm.linux.org.uk>,
       David Singleton <dsingleton@mvista.com>,
       Philip Langdale <philipl@overt.org>,
       "Brandt, Todd E" <todd.e.brandt@intel.com>,
       Stanley Cai <stanley.w.cai@gmail.com>
Subject: [RFC][PATCH] MMC: Major restructuring and cleanup
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(This mail is cross-posted in order to reach the people most affected, so make sure you edit your receiver list when replying)

Hi everyone,

As I've mentioned to some of you, I've been working on restructuring the MMC layer in order to make it more easily maintained and to allow extensions like SDIO support. A first draft of this is now
ready for public review. I've cc:d those who have been waiting for this patch set (and Russell since he always gives blunt, but valuable feedback ;)).

Because of the size of the thing I decided to not attach it, but instead publish it in my public git tree:

http://www.kernel.org/git/?p=linux/kernel/git/drzeus/mmc.git;a=log;h=mmc-ng

One major mess right now is that the MMC layer handles two tasks: arbitrating who gets access to buses and cards, and initialising new cards as they are discovered. These two are currently intertwined
and it is difficult to get a decent overview of the system.

This first draft tries to solve this by moving all protocol stuff to their own files. The new core simply identifies what type of card that is present, then delegates the rest of the initialisation.

The commits themselves are a bit rough and will be more fine grained in a final version, but the end result should be the same. So I'd like to get as much input as possible from anyone who has the
time to review it. There are lots of changes, so I'm bound to have made mistakes in a few places.

Rgds
-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org
