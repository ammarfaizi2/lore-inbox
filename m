Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964877AbWGEOG2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964877AbWGEOG2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 10:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964878AbWGEOG1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 10:06:27 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:19386 "EHLO
	out3.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S964877AbWGEOG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 10:06:27 -0400
X-Sasl-enc: m59Ctm/iqxRLBlhcUy7F1foCOwQ7KL8tGyg6FFakmJax 1152108386
Date: Wed, 5 Jul 2006 11:06:19 -0300
From: Henrique de Moraes Holschuh <hmh@debian.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>, Stelian Pop <stelian@popies.net>,
       Michael Hanselmann <linux-kernel@hansmi.ch>,
       hdaps-devel@lists.sourceforge.net, lm-sensors@lm-sensors.org
Subject: Re: [Hdaps-devel] Generic interface for accelerometers (AMS, HDAPS, ...)
Message-ID: <20060705140619.GB8452@khazad-dum.debian.net>
References: <41840b750607040326y7bfe92dy21c6845ab034ce30@mail.gmail.com> <20060703124823.GA18821@khazad-dum.debian.net> <20060704075950.GA13073@elf.ucw.cz> <1152086415.4995.0.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152086415.4995.0.camel@localhost>
X-GPG-Fingerprint: 1024D/1CDB0FE3 5422 5C61 F6B7 06FB 7E04  3738 EE25 DE3F 1CDB 0FE3
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Jul 2006, Johannes Berg wrote:
> > Also, there's a small issue with polling frequency. hdapsd needs a
> > fairly high frequency (say, 50Hz) to gather statistics and keep
> > response latency low, whereas the hdaps driver's internal polling
> > (routing to the input infrastructure) is currently done at only 20Hz.
> > We'll need to increase the latter, thereby slightly increasing system
> > load when hdaps isn't running.
> 
> Note that with AMS we're better off -- it has two interrupts telling us
> when something is wrong.
> 
> Hence, most of the discussion about loads of input values only applies
> to hdaps, the actual head-park functionality can be implemented with AMS
> without ever reading any sensor values.
> 
> Hence we also need much less complexity in userland -- once an interrupt
> comes in we trigger the hd park...

Looks nice.  For AMS, then, the userspace daemon can choose between deciding
for itself when to park heads using accel data, or to trust the firmware and
do it when told, or even to do both.

IBM *could* have done the same, since they already have an H8
microcontroller looking at that accelerometer :(  Anyway, IMHO it would be
good to have AMS-like behaviour where the kernel driver exposes head-park
events to userspace in the generic interface.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
