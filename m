Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269186AbUI2XZu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269186AbUI2XZu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 19:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269189AbUI2XZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 19:25:49 -0400
Received: from rproxy.gmail.com ([64.233.170.199]:30311 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269186AbUI2XZ3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 19:25:29 -0400
Message-ID: <9e4733910409291625281e278b@mail.gmail.com>
Date: Wed, 29 Sep 2004 19:25:26 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: =?ISO-8859-1?Q?Felix_K=FChling?= <fxkuehl@gmx.de>
Subject: Re: New DRM driver model - gets rid of DRM() macros!
Cc: dri-devel@lists.sourceforge.net, xorg@freedesktop.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040929235238.46c55c58.felix@trabant>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
References: <9e4733910409280854651581e2@mail.gmail.com>
	 <20040929235238.46c55c58.felix@trabant>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Sep 2004 23:52:38 +0200, Felix Kühling <fxkuehl@gmx.de> wrote:
> Is it normal that the savage module looks unused? I can actually rmmod
> the savage module while X is running. After that direct rending fails
> with some error message about permissions ... reloading savage didn't
> help (of course, because X wouldn't reinitialize it). A bit later the
> box locked up. Is this 0 usage count and the ability to rmmod the module
> while X is running specific to the savage driver or do other drivers
> show the same behaviour?

This is a bug, open is marking the wrong module in use.

> Some questions about future driver development: So the new linux-core
> and shared-core are the place to do new driver development? If this is
> correct then it will be for 2.6 kernels only, right? I suppose there
> would some back-porting effort involved in getting a future savage
> driver to work with 2.4 again (like adding back all the DRM() macros).

There is no real difference between the code in the linux directory
and linux-core except for the removal of the DRM macros and the
associated restructuring needed to make everything work. When we get
linux-core working without problems, it's not there yet, it could
become the future 2.6 platform if everyone agrees. The impact of the
linux-core changes are minimal on the board specific code.

For 2.4 there is a choice: continue using the linux directory or
backport linux-core to 2.4. I don't know how much effort everyone
wants to put into backporting new driver development to 2.4. There are
several possible choices:

1) leave 2.4 alone and stop working on it, 2.4 stays in the linux directory
2) declare the DRM version in the linux-2.4 the final version and only
submit bug patches via the kernel process.
3) backport linux-core to 2.4 and so that everything will build on
both OS's. Some 2.6 kernel changes are starting to make this a very
cluttered option.
4) Make parallel changes to the 2.4 and 2.6 versions.
5) other combinations of these

The removal of the DRM macros from files in the shared directory means
that things can't be shared again unless 2.4/BSD also move the the
core model. I have no strong opinions on what to do about 2.4. I'll go
along with whatever the crowd picks.

-- 
Jon Smirl
jonsmirl@gmail.com
