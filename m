Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270275AbUJTBNu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270275AbUJTBNu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 21:13:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270274AbUJTBJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 21:09:14 -0400
Received: from fw.osdl.org ([65.172.181.6]:49794 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266465AbUJTBGd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 21:06:33 -0400
Date: Tue, 19 Oct 2004 18:04:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: Werner Almesberger <werner@almesberger.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] boot parameters: quoting of environment variables
 revisited
Message-Id: <20041019180440.1ff780c5.akpm@osdl.org>
In-Reply-To: <20041019192336.K18873@almesberger.net>
References: <20041019192336.K18873@almesberger.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Werner Almesberger <werner@almesberger.net> wrote:
>
> When passing boot parameters, they can be quoted as follows:
>  param="value"
> 
>  Unfortunately, when passing environment variables this way, the
>  quoting causes confusion: in 2.6.7 (etc.), only the variable name
>  was placed in the environment, which caused it to be ignored.

Bummer.

>  I've sent a patch that adjusted the name, but this patch was
>  dropped. Instead, apparently a different fix was attempted in
>  2.6.9, but this now yields param="value in the environment (note
>  the embeded double quote), which isn't much better.

Yes, Len's patch purported to fix the same thing.  I should have got you to
review&test that change.  Didn't think of it, sorry.

>  I've attached a patch for 2.6.9 that fixes this. This time, I'm
>  shifting the value. Maybe you like it better this way :-)

hm.  The environment string handling and the "command line" string handling
appear to be identical in there.  How come only one of them has the
problem?  That function makes my eyes bleed.

