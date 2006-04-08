Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751124AbWDHFzI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbWDHFzI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 01:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbWDHFzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 01:55:08 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:30925 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751124AbWDHFzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 01:55:06 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <44374FC0.3070507@s5r6.in-berlin.de>
Date: Sat, 08 Apr 2006 07:53:04 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: scjody@modernduck.com, linux1394-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] the overdue removal of RAW1394_REQ_ISO_{LISTEN,SEND}
References: <20060406224706.GD7118@stusta.de>
In-Reply-To: <20060406224706.GD7118@stusta.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (0.841) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> This patch contains the overdue removal of the RAW1394_REQ_ISO_SEND and 
> RAW1394_REQ_ISO_LISTEN request types plus all support code for them.
[...]

I am not familiar with the isochronous part of Linux' 1394 software 
stack, so I can't comment whether there are high-profile applications 
which still did not migrate away from this interface, or did so only 
recently.

However I have a few remarks about this patch:

  1. You are not only removing the two ioctls but also two EXPORTs and
     their implementations, i.e. hpsb_listen_channel() and
     hpsb_make_isopacket().
     1.a  Nobody scheduled to remove these EXPORTs.
     1.b  So far we moved unused ieee1394 EXPORTs into #if/#endif blocks
          and let people reactivate them via kernel config.

  2. If it will be decided to remove or hide the EXPORTs and
     implementations, then the following should go as well:
     2.a  EXPORT and implementation of hpsb_unlisten_channel()
     2.b  struct member hpsb_host.iso_listen_count[]

  3. These should go regardless of the EXPORTs matter:
     struct members file_info.listen_channels, file_info.iso_buffer,
     file_info.iso_buffer_length.

Perhaps there is even *much* more code which becomes superfluous which I 
am unable to identify now.
-- 
Stefan Richter
-=====-=-==- -=-- -=---
http://arcgraph.de/sr/
