Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270667AbTHJUsn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 16:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270677AbTHJUsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 16:48:43 -0400
Received: from waste.org ([209.173.204.2]:43438 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S270667AbTHJUsj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 16:48:39 -0400
Date: Sun, 10 Aug 2003 15:48:28 -0500
From: Matt Mackall <mpm@selenic.com>
To: Stig Brautaset <stig@brautaset.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test3: Debug: sleeping function called from invalid context at include/asm/uaccess.h:473
Message-ID: <20030810204828.GA31810@waste.org>
References: <20030810161951.GA1009@brautaset.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030810161951.GA1009@brautaset.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 10, 2003 at 05:19:51PM +0100, Stig Brautaset wrote:
> Hi, I just got this message on a 2.6.0-test3 kernel:
> 
> Debug: sleeping function called from invalid context at include/asm/uaccess.h:473
> Call Trace:
>  [<c0117c01>] __might_sleep+0x61/0x80
>  [<c010ba18>] save_v86_state+0x68/0x210
>  [<c01362f5>] generic_file_aio_write+0x85/0xb0
>  [<c010c547>] handle_vm86_fault+0xb7/0xa10
>  [<c0181a2f>] ext3_file_write+0x3f/0xd0
>  [<c010a330>] do_general_protection+0x0/0xa0
>  [<c0109625>] error_code+0x2d/0x38
>  [<c010947b>] syscall_call+0x7/0xb
> 
> I'm unsure what other information is needed, if any. 
> I'm not on list, so CC me on replies please.

This looks like the vm86 fault I described earlier. For some reason
vm86 mode writes part of its state out to userspace in its fault
handler and I can't find anything that guarantees that won't double
fault. Anyone?

It might be useful to know what video driver you're using and whether
or not you use Wine, Dosemu, or anything similar. Being able to
reproduce it easily would be handy too.

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
