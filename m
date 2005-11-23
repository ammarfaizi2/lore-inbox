Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932101AbVKWQ73@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbVKWQ73 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 11:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932103AbVKWQ73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 11:59:29 -0500
Received: from wproxy.gmail.com ([64.233.184.204]:64363 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932101AbVKWQ72 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 11:59:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MmskQLVTLQrMp5sgjuCtmGxM+sHVoAnz2NNc6FTf42sSHdSlxmURc0w+ONo7hcEKwJ1xIYG96GxEkRhIuKq1OlOctTD0YY0lW6CO6yWbOQgXT83C9hTck1fKc1GAn7E1RvbDJaXfngeElDXGxu7RFz394jgJ1KpMhstaNY52jPw=
Message-ID: <9e4733910511230859y3879e65fp927a7aa4d71d8fee@mail.gmail.com>
Date: Wed, 23 Nov 2005 11:59:27 -0500
From: Jon Smirl <jonsmirl@gmail.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: Christmas list for the kernel
Cc: Marc Koschewski <marc@osknowledge.org>, Greg KH <greg@kroah.com>,
       lkml <linux-kernel@vger.kernel.org>, rmk+lkml@arm.linux.org.uk
In-Reply-To: <20051123164907.GA2981@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9e4733910511221031o44dd90caq2b24fbac1a1bae7b@mail.gmail.com>
	 <9e4733910511221313t4a1e3c67wc7b08160937eb5c5@mail.gmail.com>
	 <20051123121726.GA7328@ucw.cz>
	 <9e4733910511230643j64922738p709fecd6c86b4a95@mail.gmail.com>
	 <20051123150349.GA15449@flint.arm.linux.org.uk>
	 <9e4733910511230712y2b394851rc17fa71c6f9c6ecf@mail.gmail.com>
	 <20051123155650.GB6970@stiffy.osknowledge.org>
	 <20051123160520.GH15449@flint.arm.linux.org.uk>
	 <9e4733910511230837v1519d3b3t28176b1fd6017ffc@mail.gmail.com>
	 <20051123164907.GA2981@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/05, Vojtech Pavlik <vojtech@suse.cz> wrote:
> On Wed, Nov 23, 2005 at 11:37:23AM -0500, Jon Smirl wrote:
>
> > Before everyone gets excited, I realize that all of this has
> > historical implications. But that doesn't mean we can't discuss
> > possible future alternative solutions.
> >
> > Thinking about this for a while it seems to me that the problem is
> > that the various apps (init, syslog) etc should not have a tty name as
> > part of their command line parameters. Instead these apps could use
> > ptys instead. Ptys would solve all of the race problems too.
> >
> > Is there any good reason (other than history) for using a device node
> > name (tty0, etc) instead of some other naming scheme if names are
> > needed at all?
> >
> > If init, syslog, etc can be converted to ptys, do we need ttys? Xterms
> > use ptys I don't notice that they aren't connect to a fix tty name.
> > The virtual consoles would still be 0,1,2 but do they have to be
> > hooked to tty0, 1, 2 instead of a pty?
>
> The basic difference between a pty and tty is that a pty connects to a
> program (that created it by opening the ptmx node, for example xterm or
> ssh) on the other end, while a tty connects to the kernel doing all the
> character drawing in the framebuffer.
>
> You can't easily use one instead of the other, they're very different
> beasts.
>
> Of course, a way to use a pty would be to have the console
> implementation in userspace.
>
> The fact that no program is on the other end of a tty is also the reason
> why they cannot be created dynamically like ptys, there is noone to open
> a "ttmx" to create the ttys.
>
> Hence, the device nodes are pre-created by the kernel, while the real
> devices are only created on open.

I forgot about the kernel vs user space termination issue.

One solution would be to not create the tty nodes and instead modify
init, syslog to mknod the node before using it.

Another would be to have a little user space daemon that listened to
the pty creation, and then mknod the tty nodes as need and pipe the
data through. That would be a first step to moving to a user space
console implementation.

I see now that the 64 tty devices really are there and are provided by
the kernel. It's just that hardly anyone uses all of them and they
clutter up /dev.

--
Jon Smirl
jonsmirl@gmail.com
