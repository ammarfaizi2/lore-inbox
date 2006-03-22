Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751174AbWCVJ4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbWCVJ4N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 04:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbWCVJ4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 04:56:13 -0500
Received: from mailgw3.ericsson.se ([193.180.251.60]:2497 "EHLO
	mailgw3.ericsson.se") by vger.kernel.org with ESMTP
	id S1751174AbWCVJ4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 04:56:12 -0500
Date: Wed, 22 Mar 2006 10:56:06 +0100 (CET)
From: Per Liden <per.liden@ericsson.com>
X-X-Sender: eperlid@ulinpc219.uab.ericsson.se
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cleanup for net/tipc/name_distr.c::tipc_named_node_up()
In-Reply-To: <200603190045.24176.jesper.juhl@gmail.com>
Message-ID: <Pine.LNX.4.64.0603221049140.6949@ulinpc219.uab.ericsson.se>
References: <200603190045.24176.jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 22 Mar 2006 09:56:08.0600 (UTC) FILETIME=[D7B47980:01C64D96]
X-Brightmail-Tracker: AAAAAA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Mar 2006, Jesper Juhl wrote:

> Small cleanup patch for net/tipc/name_distr.c::tipc_named_node_up()

Not sure if you followed the discussion on the tipc mailinglist, so here's 
a short summary.

> Patch does the following:
> 
>  - Change a few pointer assignments from 0 to NULL (makes sparse happy).

Ok.

>  - Move a few variable assignment outside the tipc_nametbl_lock lock.

Ok.

>  - Make sure to free the allocated buffer before returning so we don't leak.

The additional kfree_skb() looks incorrect. If a buffer if allocated it 
will later be released by tipc_link_send().

/Per
