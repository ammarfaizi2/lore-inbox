Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264314AbUAHKrj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 05:47:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264326AbUAHKrj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 05:47:39 -0500
Received: from FLA1Aak172.kng.mesh.ad.jp ([218.42.70.172]:58563 "EHLO
	yamt.dyndns.org") by vger.kernel.org with ESMTP id S264314AbUAHKrh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 05:47:37 -0500
To: phil@fifi.org
Cc: trond.myklebust@fys.uio.no, theonetruekenny@yahoo.com,
       linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: Re: [NFS client] NFS locks not released on abnormal process
 termination
In-Reply-To: Your message of "09 Dec 2003 00:15:24 -0800"
	<87llpms8yr.fsf@ceramic.fifi.org>
References: <87llpms8yr.fsf@ceramic.fifi.org>
X-Mailer: Cue version 0.6 (030717-1703/takashi)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Date: Thu, 08 Jan 2004 19:47:24 +0900
Message-Id: <1073558844.242410.4086.nullmailer@yamt.dyndns.org>
From: YAMAMOTO Takashi <yamamoto@valinux.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

> +	status = nlmclnt_proc(inode, cmd, fl);
> +	/* If we were signalled we still need to ensure that
> +	 * we clean up any state on the server. We therefore
> +	 * record the lock call as having succeeded in order to
> +	 * ensure that locks_remove_posix() cleans it out when
> +	 * the process exits.
> +	 */
> +	if (status == -EINTR || status == -ERESTARTSYS)
> +		posix_lock_file(filp, fl, 0);
> +	unlock_kernel();
> +	if (status < 0)
> +		return status;

i think it's problematic because you can't assume the lock was
granted on the server and the signaled process might not exit immediately.

YAMAMOTO Takashi

