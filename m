Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750987AbWABTuM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750987AbWABTuM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 14:50:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750989AbWABTuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 14:50:12 -0500
Received: from nproxy.gmail.com ([64.233.182.197]:24713 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750988AbWABTuK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 14:50:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=n3luEZDUAq+cAV1bGZC/Q1j1OMaDyU+nBUdhzkCR8VIO+0sXAEe6hX48SAWjv1lSviIq9sYX9UU/xItMdGkf3D/4S7Org5KVjaKf3z5/VPCBft7ZjoivgepYHPTltWK/UraUnOantUXNrvfwwJXaK5ogFOiIZY1ls7+TwMRg7L4=
Message-ID: <9cfa10eb0601021150y646fe728s@mail.gmail.com>
Date: Mon, 2 Jan 2006 21:50:08 +0200
From: Marko Kohtala <marko.kohtala@gmail.com>
To: Jason Dravet <dravet@hotmail.com>
Subject: Re: [Linux-parport] [RFC]: add sysfs support to parport_pc, v3
Cc: linux-kernel@vger.kernel.org, linux-parport@lists.infradead.org
In-Reply-To: <BAY103-F835CFFD193D6F76C5527FDF2D0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <BAY103-F835CFFD193D6F76C5527FDF2D0@phx.gbl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2006/1/2, Jason Dravet <dravet@hotmail.com>:
> Here is a new patch to parport_pc that adds sysfs and thus udev support to
> parport_pc.  I fixed my earilier problem of the kernel oops (I forgot the
> class_destory) and I can insmod and rmmod this module all day long with no
> side effects.  I do have one question why do both lp and parport nodes have
> to be created?
>
> What do you think of this patch?  What would be the next step to get this
> into the kernel?

If your problem is that you do not get /dev/lp0 created automatically,
I think a better way to get that solved is to find out a way that the
module lp is loaded automatically when a printer is found on the
parport.

Maybe you should look into drivers/parport/probe.c and have it do
request_module("lp") when it finds a printer attached to the parport.

Some paride (or SCSI) devices could also be probed for using a
pre-IEEE1284 daisy chain command that gives a 16 bit device ID, and
proper drivers loaded with some module aliases including the device
ID. If something unidentifiable is found on the parport then maybe the
ppdev could be loaded so that userspace drivers will have an interface
to work with.

I fear that some people would find this too smart to be useful. I'd
expect them to request at least a module option to parport to disable
it.

Most people are happy with just "lp" in /etc/modules.
