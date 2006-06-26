Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030241AbWFZOhF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030241AbWFZOhF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 10:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030244AbWFZOhF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 10:37:05 -0400
Received: from sccrmhc15.comcast.net ([204.127.200.85]:56820 "EHLO
	sccrmhc15.comcast.net") by vger.kernel.org with ESMTP
	id S1030241AbWFZOhD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 10:37:03 -0400
Message-ID: <449FF130.3010601@acm.org>
Date: Mon, 26 Jun 2006 09:37:36 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060517)
MIME-Version: 1.0
To: "amatus@ocgnet.org" <amatus@ocgnet.org>
CC: openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IPMI: Support registering for a command per-channel
References: <20060623150705.GA14245@login.ocgnet.org>
In-Reply-To: <20060623150705.GA14245@login.ocgnet.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

amatus@ocgnet.org wrote:
> From: David Barksdale <amatus@ocgnet.org>
>
> This patch adds the ability to register for a command per-channel.
>
> If your BMC supports multiple channels, incoming messages can be
> differentiated by the channel on which they arrived. In this case it's
> useful to have the ability to register to receive commands on a
> specific channel instead the current behaviour of all channels.
>
>   
Sorry for the long delay on this.  I like the patch in general, there
are a few things I'd like to fix in it, though:

* Instead of naming the IOCTLs xxx_CMD2, could you name
  them xxx_CMD_CHANNEL, or something that conveys a
  little more meaning?

* The command unregister function needs to use a different
  matching function now that you have to allow non-exact
  matches for the channels.  You still need an exact match
  for unregistering.

* Someone mentioned using a bitmask for the channels
  you are registering.  I think that's a good idea.  IPMI
  only allows 16 channels max, so an unsigned int should
  be plenty.  Add a define for all channels and for setting
  a specific channel.

Thanks,

-Corey
