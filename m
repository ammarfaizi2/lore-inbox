Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265494AbUF2GYG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265494AbUF2GYG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 02:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265495AbUF2GYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 02:24:06 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:53571 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S265494AbUF2GYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 02:24:03 -0400
Date: Tue, 29 Jun 2004 07:23:54 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: jlm_devel <jlm_devel@laposte.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [system crash] [swaps] make the filesystem inaccessible and all
    applications that try to access it hangs
In-Reply-To: <40E08096.2040204@laposte.net>
Message-ID: <Pine.LNX.4.44.0406290720001.15041-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jun 2004, jlm_devel wrote:
> I work on swapd and I found a way to "crash" a filesystem entry with 
> operations on swaps :
> kernel version 2.6.7
> 
> step to reproduce :
> make a swap file into one directory
> activate it
> rm it
> 
> now all application trying to access the containing directory will 
> hangs..... including the swapd I write.....

You'll find that fixed, I believe, in latest 2.6.7-bk or 2.6.7-mm3:
we used to hold i_sem while the swapfile was in use, but are now
protecting it differently (S_SWAPFILE): to end reports like yours!

Thanks,
Hugh

