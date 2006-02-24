Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932564AbWBXVgt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932564AbWBXVgt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 16:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932573AbWBXVgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 16:36:49 -0500
Received: from smtp.osdl.org ([65.172.181.4]:60127 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932564AbWBXVgs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 16:36:48 -0500
Date: Fri, 24 Feb 2006 13:36:05 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Collins <paul@briny.ondioline.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kjournald keeps reference to namespace
Message-Id: <20060224133605.7a8e86ca.akpm@osdl.org>
In-Reply-To: <873bi88n0s.fsf@briny.internal.ondioline.org>
References: <20060218013547.GA32706@MAIL.13thfloor.at>
	<20060217175428.7ce7b26f.akpm@osdl.org>
	<20060218033031.GB32706@MAIL.13thfloor.at>
	<873bi88n0s.fsf@briny.internal.ondioline.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Collins <paul@briny.ondioline.org> wrote:
>
>  Herbert Poetzl <herbert@13thfloor.at> writes:
> 
>  > On Fri, Feb 17, 2006 at 05:54:28PM -0800, Andrew Morton wrote:
>  >> I think it'd be better to convert ext3 to use the kthread API which
>  >> appears to accidentally not have this problem, because such threads
>  >> are parented by keventd, which were parented by init.
>  >
>  > sounds like a plan!
> 
>  Here's my attempt at such a conversion.  Since jbd doesn't seem to
>  want to collect an exit status, I didn't bother with kthread_stop().

Ah.  I already did something similar. 
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc4/2.6.16-rc4-mm2/broken-out/jbd-convert-kjournald-to-kthread-api.patch

>  I got overexcited and also embedded the journal device in the process
>  name, but that's probably useless churn.  Looks nice in pstree though:
> 
>       |-kthread-+-kblockd/0
>       |         |-khubd
>       |         |-2*[pdflush]
>       |         |-aio/0
>       |         |-v9fs/0
>       |         |-cqueue/0
>       |         |-kfand
>       |         |-kcryptd/0
>       |         |-kjournald/3:3
>       |         |-kjournald/3:8
>       |         |-kjournald/3:4
>       |         |-kjournald/3:5
>       |         `-kjournald/254:1

We only have 15 chars for that string - the final one you have there is on
the raggedy edge.
