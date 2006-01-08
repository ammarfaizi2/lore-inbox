Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030496AbWAHHrp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030496AbWAHHrp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 02:47:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030523AbWAHHrn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 02:47:43 -0500
Received: from liaag1aa.mx.compuserve.com ([149.174.40.27]:11393 "EHLO
	liaag1aa.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1030496AbWAHHrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 02:47:41 -0500
Date: Sun, 8 Jan 2006 02:43:15 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Badness in __mutex_unlock_slowpath
To: Andrew James Wade <andrew.j.wade@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200601080246_MC3-1-B57D-BAA5@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <200601071551.20344.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>

On Sat, 7 Jan 2006 at 15:51:19 -0500 Andrew James Wade wrote:


> I got this when "amaroK" started playing:
>
> Badness in __mutex_unlock_slowpath at kernel/mutex.c:214
>  [<c03538e8>] __mutex_unlock_slowpath+0x56/0x1a2
>  [<c0302f08>] snd_pcm_oss_write+0x0/0x1e0
>  [<c0302f3c>] snd_pcm_oss_write+0x34/0x1e0
>  [<c0302f08>] snd_pcm_oss_write+0x0/0x1e0
>  [<c0148221>] vfs_write+0x83/0x122
>  [<c0148a36>] sys_write+0x3c/0x63
>  [<c0102ba3>] sysenter_past_esp+0x54/0x75


 The thread doing the unlock does not own the mutex.

 Same exact check is made a few lines later in debug_mutex_unlock().

And debugging gets turned off after the first debug message prints,
so there could be other problems that are not reported.

 -- 
Chuck
Currently reading: _Thud!_ by Terry Pratchett
