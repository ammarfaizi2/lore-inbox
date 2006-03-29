Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750734AbWC2Nx1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbWC2Nx1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 08:53:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbWC2Nx1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 08:53:27 -0500
Received: from zcars04e.nortel.com ([47.129.242.56]:1928 "EHLO
	zcars04e.nortel.com") by vger.kernel.org with ESMTP
	id S1750734AbWC2Nx0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 08:53:26 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17450.35947.966666.328091@lemming.engeast.baynetworks.com>
Date: Wed, 29 Mar 2006 08:32:27 -0500
To: apgo@patchbomb.org (Arthur Othieno)
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
       stable@kernel.org, kernel@kolivas.org
Subject: Re: [PATCH] change kbuild to not rely on incorrect GNU make behavior
In-Reply-To: <20060329131501.GA8537@krypton>
References: <E1FG1UQ-00045B-5P@fencepost.gnu.org>
	<20060305231312.GA25673@mars.ravnborg.org>
	<20060329131501.GA8537@krypton>
X-Mailer: VM 7.19 under Emacs 21.4.1
From: "Paul D. Smith" <psmith@gnu.org>
Reply-To: "Paul D. Smith" <psmith@gnu.org>
Organization: GNU's Not Unix!
X-OriginalArrivalTime: 29 Mar 2006 13:53:11.0230 (UTC) FILETIME=[1DF1D5E0:01C65338]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

%% apgo@patchbomb.org (Arthur Othieno) writes:

  >> The patch will be included in 2.6.17 and will see exposure in -mm when
  >> Andrew does next -mm.
 
  ao> Sam, this was merged into Linus' tree post v2.6.16 (like you
  ao> intended), but, won't the window between now and 2.6.17 be a
  ao> little too big for such a fix? Debian etch (and sid) already ships
  ao> with the affected make version:

  ao>   $ make -v | head -1
  ao>   GNU Make 3.81rc1

I reverted this fix in GNU make 3.81rc2 (available for a bit over a week
now).  3.81 final will ship with the old, buggy behavior instead of the
fixed behavior.

Immediately post-3.81 I'll re-introduce the GNU make fix.


Note that this only impacts people who build the kernel multiple times
without cleaning the tree.  While this is very common with newer
versions of the kernel (for developers) it's probably less common with
older versions, and many of those (distro-based) can apply this kbuild
patch with the rest of their distro-specific patches.


On the gripping hand, it's quite possible to provide a significantly
smaller, targeted patch that fixes just the most egregious problem with
only two lines changed, if the -stable team was interested in that
instead.

-- 
-------------------------------------------------------------------------------
 Paul D. Smith <psmith@gnu.org>          Find some GNU make tips at:
 http://www.gnu.org                      http://make.paulandlesley.org
 "Please remain calm...I may be mad, but I am a professional." --Mad Scientist
