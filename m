Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264660AbSJOTvo>; Tue, 15 Oct 2002 15:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264664AbSJOTvo>; Tue, 15 Oct 2002 15:51:44 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:6131 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S264660AbSJOTvn>; Tue, 15 Oct 2002 15:51:43 -0400
Date: Tue, 15 Oct 2002 15:57:38 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: John Myers <jgmyers@netscape.com>
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] aio updates
Message-ID: <20021015155738.B16156@redhat.com>
References: <200210150117.g9F1HXm26163@msglinux1.mcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200210150117.g9F1HXm26163@msglinux1.mcom.com>; from jgmyers@netscape.com on Mon, Oct 14, 2002 at 06:17:33PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2002 at 06:17:33PM -0700, John Myers wrote:
> Please apply. 
> #     fix uninitialized variable causing incorrect timeout
> #     add support for IO_CMD_NOOP
> #     make sys_io_cancel(), not cancel method, initialize most of returned result
> #     minor aio_cancel_all() optimization
> #     fix a debug printk

I've applied most of this to my tree, except for the NOOP bits.  My 
concern is that the way you've implemented NOOP does not allow for all 
possible return codes to be passed in due to the error checking the 
iocb submit code performs on the inputs.  It can also spuriously fail 
if the filedescriptor field points to an fd that doesn't exist, which 
could be somewhat unexpected (especially if it is initialized to 0 by 
default, and therefore would not fail during normal operation where a 
program is run with stdin).  Got any idea for cleaning those problems 
up?

		-ben

