Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316684AbSHXUpZ>; Sat, 24 Aug 2002 16:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316695AbSHXUpZ>; Sat, 24 Aug 2002 16:45:25 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:50701 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S316684AbSHXUpY>;
	Sat, 24 Aug 2002 16:45:24 -0400
Date: Sat, 24 Aug 2002 22:58:58 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk,
       mec@shout.net
Subject: Re: Of hanging menuconfig [cause found]
Message-ID: <20020824225858.A1487@mars.ravnborg.org>
Mail-Followup-To: "Dr. David Alan Gilbert" <gilbertd@treblig.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.arm.linux.org.uk, mec@shout.net
References: <20020824151329.GB735@gallifrey>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
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
This does not make sense...
lxdialog are compiled utilising HOSTCC, and HOSTCC always points to gcc.
So unless you fail to keep gcc for native in PATH and use:
$> make CROSS_COMPILE=arm all
to do cross-compile the above scenario should not be possible.
In other words
$> which gcc
shall always point to the gcc used for native architecture. Cross
compiling are done by specifying another gcc using the above syntax.
[I've only looked in 2.5 sources by the way, 2.4 may differ here].

Another point is that the current kbuild is too weak when architecture
is changed. Changing architecture should require a make mrproper.

	Sam

