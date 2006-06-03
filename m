Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932566AbWFCGbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932566AbWFCGbN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 02:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932573AbWFCGbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 02:31:13 -0400
Received: from nz-out-0102.google.com ([64.233.162.193]:2350 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932566AbWFCGbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 02:31:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Rhv8gWcRrny5RpPWZ7GeCgYhK8ptG34aCUQQ0eLoWASi1QPcNFK7ChomWhkCD3ohymdOkCw2GTROtGTw8qN7pQgKO0ydkFRoGOFFfFK/5JwRcCluK9MW2HNiHANakebM/6NKcdgGqrwgPDHQnzX/J95+YolmeeCZvhl/eNpalcY=
Message-ID: <9e4733910606022331u40f1fd5dq6428e37f30ccf702@mail.gmail.com>
Date: Sat, 3 Jun 2006 02:31:02 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "D. Hazelton" <dhazelton@enter.net>
Subject: Re: OpenGL-based framebuffer concepts
Cc: "Kyle Moffett" <mrmacman_g4@mac.com>, "Dave Airlie" <airlied@gmail.com>,
       "Ondrej Zajicek" <santiago@mail.cz>, "Pavel Machek" <pavel@ucw.cz>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org, adaplas@gmail.com
In-Reply-To: <200606030209.34928.dhazelton@enter.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
	 <200606030125.20907.dhazelton@enter.net>
	 <9e4733910606022255r7fa7346bw661fb35f81668788@mail.gmail.com>
	 <200606030209.34928.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/2/06, D. Hazelton <dhazelton@enter.net> wrote:
> Actually, Jon, Dave is thinking like I am in that the DRI drivers needs to be
> loaded for use. Rather than forcing applications to include all that code the
> userspace daemon can be configured to load the DRI driver and provides the
> userspace interface to the system. Using a daemon for a simple task, like
> modesetting, is idiotic - but using the daemon to provide userspace with full
> access to acceleration (the Kernel drivers only provide the backend for the
> acceleration. The userspace side actually provides the code that manages it
> all) without needing to have to worry about loading and initializing the dri
> drivers provides a method for anything from a scripting language to a full
> compiled application easy access to the acceleration.

You are confused about this. Nobody wants to change the way DRI and
DRM work, it would take years of effort to change it. These are shared
libraries, it doesn't matter how many people have them open, there is
only one copy in memory.

Applications don't 'include' all of the DRI/DRM code they dynamically
link to the OpenGL shared object library which in turns loads the
correct DRI shared library. The correct DRM module should be loaded by
the kernel at boot. You can write a 10 line OpenGL program that will
make use of all of this, it is not hard to do. User space has always
had access to hardware acceleration from these libraries.

We have not been discussing DIrect Rendering vs indirect (AIGLX). It
will be up to the windowing system to chose which (or both) of those
model to use. The lower layers are designed not to force that choice
one way ot the other.

Dave wants to load the existing X drivers into the daemon, not the DRI
libraries. Other than using them for mode setting there isn't much use
for them. I have asked him where he wants things like blanking, cmap,
cursor and he hasn't said yet. Those functions are tiny, ~100 lines of
code.

-- 
Jon Smirl
jonsmirl@gmail.com
