Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261207AbVDMXAR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261207AbVDMXAR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 19:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261213AbVDMXAR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 19:00:17 -0400
Received: from zproxy.gmail.com ([64.233.162.195]:56855 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261207AbVDMXAG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 19:00:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=V7h0/Sk78v1KrCJfiZHt7RPFQlXBe5ZxKnGs9sxuGZdTa+ro9zrNLKnmavryM6VZMJsnB4KEi5c7J1B4bVQ9dqBlDFgtYDE9hN9HJ13l/EMBxDnJ6IsE4ac59XgprT31olGyHMT8gYGbUbopmGj0mQRwWC/MeksXgRxkm6R22bc=
Message-ID: <8783be66050413160033e6283d@mail.gmail.com>
Date: Wed, 13 Apr 2005 19:00:06 -0400
From: Ross Biro <ross.biro@gmail.com>
Reply-To: Ross Biro <ross.biro@gmail.com>
To: Andi Kleen <ak@muc.de>
Subject: Re: [RFC/Patch 2.6.11] Take control of PCI Master Abort Mode
Cc: Ross Biro <rossb@google.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20050413183725.GG50241@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4252E827.4080807@google.com> <m14qee221l.fsf@muc.de>
	 <8783be66050412075218b2b0b0@mail.gmail.com>
	 <20050413183725.GG50241@muc.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 Apr 2005 20:37:25 +0200, Andi Kleen <ak@muc.de> wrote:
> \>
> > You're argument that no one can make sense of such options is totally off
> > base. Once you are having a problem, it's pretty easy to see if it's related
> 
> I dont think it is in any way help to put suche highly obscure
> things into Config. Near nobody can make any sense of it.
> 
> If you take a look at quirks.c and DMI options you will see we have quite a lot
> of workarounds for various hardware bug. Just imagine there were
> CONFIG options for all of this. It would be a big mess!

 The config option is for distro maintainers to use to set a policy
for their particular distribution.  The boot line option is for end
users to adjust it.  Last I heard, most distro makers compile their
own kernels and select options appropriately.  I really don't think
it's too much to ask an end user to adjust their grub.conf or
lilo.conf file to work around a bug in their hardware, especially
since their is *no way* to work around the bug in all cases with out
user intervention.

As I said before, the quirks routines cannot handle it since there is
no way to know what the correct setting is unless you know what
application is going to be run and what the users tolerance to
particular problems is.  In a perfect world, master abort mode would
always be set to on, but that is not practical in the real world.  If
you are suggesting that something in the quirks file stop the boot and
ask the user some questions about how they intend to use the system
and what their tolerance for certain types of errors is, then I think
you are suggesting an even bigger mess.

Someone creating a dstro for enterprise use would most likely compile
the kernel with master abort mode enabled to prevent silent data loss.
 Someone building the system for desktop use would choose either
default or disabled, to prevent spurious error messages, or hardware
lock ups.  If users report problems that look like they are caused by
the master abort mode setting, a tech support person could easily ask
the end user to add a boot time command line option to see if the
problem goes away.  The end user would then have the *option* of
adjusting the config file, or just using the boot time option.

I would aggree with you if it were not for the fact that the correct
setting of this bit is really a judgement call, so it must be simple
for anyone who needs to make the call to be able to.  The people
building distors will need to be able change the default setting
easily at compile time and the end user needs to be able to change the
setting at boot time or run time.

Someone on the PCI mailing list has suggested that it is enough to let
the distro maintainer edit the header file and adjust the setting
there.  To do so would mean that many distro maintainers would have to
maintain an additional patch for very little reason.  Perhaps the
correct solution is to keep it as a config option and add a
CONFIG_OBSCURE so that most people don't ever see option, but the few
that need to can.

    Ross
