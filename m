Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750817AbWC3UWR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbWC3UWR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 15:22:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbWC3UWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 15:22:17 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:30214 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750817AbWC3UWQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 15:22:16 -0500
Date: Thu, 30 Mar 2006 22:22:08 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Spurious rebuilds of raid6 and drivers/media/video in 2.6.16
Message-ID: <20060330202208.GA14016@mars.ravnborg.org>
References: <442BC74B.7060305@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <442BC74B.7060305@gmx.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2006 at 01:55:55PM +0200, Carl-Daniel Hailfinger wrote:
> Hi,
> 
> if I copy a compiled kernel tree to another location and run
> make again in the new directory, a few files always get rebuilt.
> These files only are rebuilt if the tree is a copy of another
> tree and they are rebuilt only once.
> Any ideas why this is the case?
The reason why the predictive rebuild happens is that in some parts
of the kbuild files it has been necessary to use absolute paths.
One example is the oiu2c shell script where we use the full path
to locate the shell script.
The reason why a full path is used is that this shall also work when
compiling the kernel using make O=...
What happens is that kbuild detects that the command used to build the
target has changed and therefore force a rebuild. It is the same
mechanishm that is used to detect when arguments to the compiler
changes.

So the rebuild will happen. It would be possible to minimize the places
where a rebuild is triggered when moving the source tree, but I have not
seen any benefit doing so lately.

	Sam
