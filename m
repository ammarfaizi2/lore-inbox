Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261588AbUKHMAn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261588AbUKHMAn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 07:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbUKHMAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 07:00:43 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:15327 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261588AbUKHMAh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 07:00:37 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 8 Nov 2004 12:40:08 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: video4linux-list@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: RFC: [2.6 patch] drivers/media/video/ cleanups
Message-ID: <20041108114008.GB20607@bytesex>
References: <20041107175017.GP14308@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041107175017.GP14308@stusta.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 07, 2004 at 06:50:17PM +0100, Adrian Bunk wrote:
> the patch below contains several cleanups for drivers/media/video/, most 
> of them are:
> - needlessly global code made static
> - currenly unused code removed

No, not this way in one big blob please.  It would be very nice if you
can split that into smaller pieces:

  (1) The ObviouslyCorrect stuff, i.e. make stuff static which isn't
      declared in any header file.
  (2) The stuff which needs some more careful review (drop functions,
      drop stuff from header files, ...).

Especially the later please splitted by driver, so the driver
maintainers can have a look (which is kida problematic for some v4l
drivers as there is no active maintainer currently, but I'd prefeare
to have that separately in my inbox neverless).

I don't like your attitude to just drop stuff as "cleanup".  If
functions are declared in a header file they are usually for a reason,
thus that kind of stuff needs some careful checking whenever these
reasons still exist or not.  Not every function which isn't used at the
moment automatically is useless.  cx88_risc_disasm() for example is
useful for debugging the driver.  And that there is no in-kernel user
for exported functions doesn't mean that nobody uses it.  The stuff
exported by bttv-if is used by lirc for example.

  Gerd

