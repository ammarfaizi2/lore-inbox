Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317068AbSHYID7>; Sun, 25 Aug 2002 04:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317072AbSHYID7>; Sun, 25 Aug 2002 04:03:59 -0400
Received: from faui02.informatik.uni-erlangen.de ([131.188.30.102]:44422 "EHLO
	faui02.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S317068AbSHYID6>; Sun, 25 Aug 2002 04:03:58 -0400
Date: Sat, 24 Aug 2002 21:21:44 +0200
From: Richard Zidlicky <rz@linux-m68k.org>
To: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk,
       mec@shout.net
Subject: Re: Of hanging menuconfig [cause found]
Message-ID: <20020824212144.B746@linux-m68k.org>
References: <20020824151329.GB735@gallifrey>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020824151329.GB735@gallifrey>; from gilbertd@treblig.org on Sat, Aug 24, 2002 at 04:13:29PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 24, 2002 at 04:13:29PM +0100, Dr. David Alan Gilbert wrote:
> Hi,
>   make menuconfig   will hang just after the parsing in the
> activate_menu loop in the case where the file scripts/lxdialog/lxdialog
> won't execute.  Some error codes in this case are caught; but the case
> where the file scripts/lxdialog/lxdialog is a binary for the wrong
> architecture (case 126) is not caught.  This is quite easy to trip if
> you are swapping between native and cross building - you get a couple of
> errors when you try and build make menuconfig for the first time about
> wrong binaries; in my case I just deleted those binaries and did the
> make again; however this failure is silent - it just hangs.
> 
> A make mrproper   is probably the best thing to do when switching - but
> the error case needs catching, and I'm sure there are other similar
> cases.

look at dmesg and add an
	alias binfmt-xxxx off
to /etc/modules.conf so similar problems get caught properly - unless 
you want to actually use an emulator for this architecture of course :)

This is one of the cases where I wish kmod would do something more 
intelligent by default than endless loop. Would it be a good idea 
to attempt loading of emulator modules only for formats that are 
previously somehow registered + a few well known like aout,misc,elf?

Looking at exec.c, why isn't the result of request_module() tested?

Richard


