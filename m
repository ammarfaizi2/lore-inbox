Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751710AbWADRKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751710AbWADRKr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 12:10:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751774AbWADRKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 12:10:47 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:23687 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751760AbWADRKq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 12:10:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MY3fJe9Fioexz22nIUINiU9ripgXcEopHwGeFhcmNmw2EKFRAyPVJ35N4aKMOcNNBPInU1+HIUO1HzOHTw4xeaXmTEBXqiACUwoBaoauhYLNgBK1VRoVAgLHIgoDXY4tQETWA0WVYmFSMxwVid/MNuH5NJ20Fmi317434zqu7Ck=
Message-ID: <9a8748490601040910q50655fc1sbdef48c8bd3d02d4@mail.gmail.com>
Date: Wed, 4 Jan 2006 18:10:45 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [-mm patch] i386: enable 4k stacks by default
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060104165835.GP3831@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060104145138.GN3831@stusta.de>
	 <9a8748490601040839s58a0a26en454f54459006077c@mail.gmail.com>
	 <20060104164445.GO3831@stusta.de>
	 <9a8748490601040849l5e144f18s381854dd7f5f6e6b@mail.gmail.com>
	 <20060104165835.GP3831@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/06, Adrian Bunk <bunk@stusta.de> wrote:
> On Wed, Jan 04, 2006 at 05:49:25PM +0100, Jesper Juhl wrote:
> > To get maximum testing making 4KSTACKS default Y and removing the "if
> > DEBUG_KERNEL" conditional just seems to me to be the obvious choice...
>
> With my version, we are getting the bigger testing coverage - and
> getting a big testing coverage in -mm is what we need if we want to know
> whether we have really already fixed all stack problems or whether
> there are any left.
>
Ok, I guess I didn't make myself as clear as I thought.
What I meant was that if 4K stacks are always enabled by default, then
you'll get more testing than if only people who enable DEBUG_KERNEL
are able to turn it on.

So I guess what I'm really aiming at is to either move the option up a
level - that is, remove its dependency on CONFIG_DEBUG_KERNEL, or turn
the option on its head and make it an option to enable 8K stacks
instead and make that option then default to N (I like the first
aproach better though).

Something like this :

--- linux-2.6.15-orig/arch/i386/Kconfig.debug   2006-01-03
04:21:10.000000000 +0100
+++ linux-2.6.15/arch/i386/Kconfig.debug        2006-01-04
19:08:43.000000000 +0100
@@ -44,7 +44,7 @@

 config 4KSTACKS
        bool "Use 4Kb for kernel stacks instead of 8Kb"
-       depends on DEBUG_KERNEL
+       default y
        help
          If you say Y here the kernel will use a 4Kb stacksize for the
          kernel stack attached to each process/thread. This facilitates

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
