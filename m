Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263423AbVBCWSj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263423AbVBCWSj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 17:18:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261911AbVBCWPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 17:15:53 -0500
Received: from av9-2-sn4.m-sp.skanova.net ([81.228.10.107]:44165 "EHLO
	av9-2-sn4.m-sp.skanova.net") by vger.kernel.org with ESMTP
	id S262754AbVBCWGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 17:06:31 -0500
To: Giuseppe Bilotta <bilotta78@hotpop.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] Fix "pointer jumps to corner of screen" problem on ALPS Glidepoint touchpads.
References: <m34qgz9pj5.fsf@telia.com> <m3zmyr8avm.fsf@telia.com>
	<m3vf9f8asf.fsf_-_@telia.com>
	<MPG.1c6c19f1476bb4a98970e@news.gmane.org>
From: Peter Osterlund <petero2@telia.com>
Date: 03 Feb 2005 23:06:28 +0100
In-Reply-To: <MPG.1c6c19f1476bb4a98970e@news.gmane.org>
Message-ID: <m3vf99wb6j.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giuseppe Bilotta <bilotta78@hotpop.com> writes:

> Peter Osterlund wrote:
> > Only parse a "z == 127" packet as a relative Dualpoint stick packet if
> > the touchpad actually is a Dualpoint device.  The Glidepoint models
> > don't have a stick, and can report z == 127 for a very wide finger. If
> > such a packet is parsed as a stick packet, the mouse pointer will
> > typically jump to one corner of the screen.
> 
> I remember reading specs of a touchpad (can't remember if it 
> was ALPS or Synaptics) (driver) which could do "palm 
> detection" (basically ignoring events when a large part of the 
> hand accidentally touched/pressed the pad, FWICS).

Some synaptics touchpads can do palm detection in firmware, but the
software driver has to decide if the corresponding events shall be
ignored or not.

Anyway, this is unrelated to the patch. Without this patch, the packet
from the touchpad will be parsed incorrectly as a very big stick
motion, so a higher level driver (such as the X driver) can't really
see that there might be a palm touching the pad.

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
