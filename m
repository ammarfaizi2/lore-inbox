Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317589AbSFRUE6>; Tue, 18 Jun 2002 16:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317590AbSFRUE5>; Tue, 18 Jun 2002 16:04:57 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:27656 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S317589AbSFRUE4>;
	Tue, 18 Jun 2002 16:04:56 -0400
Date: Tue, 18 Jun 2002 22:09:10 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Sam Ravnborg <sam@ravnborg.org>, "Adam J. Richter" <adam@yggdrasil.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Various kbuild problems in 2.5.22
Message-ID: <20020618220910.A3001@mars.ravnborg.org>
References: <20020618211639.A2659@mars.ravnborg.org> <Pine.LNX.4.44.0206181417230.5695-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0206181417230.5695-100000@chaos.physics.uiowa.edu>; from kai@tp1.ruhr-uni-bochum.de on Tue, Jun 18, 2002 at 02:28:02PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2002 at 02:28:02PM -0500, Kai Germaschewski wrote:

> Nitpick: 
> [kai@chaos linux-2.5.make]$ make bzImage && ls bzImage
> [..]
> ls: bzImage: No such file or directory
> 
> So you that bzImage isn't a real target (arch/i386/boot/bzImage would be).
Which actually annoy me a lot!
Maybe that just me, but I cannot see why I have to go down deep
in the architecture specific directory to locate the kernel.
But I have no brilliant idea how to solve it right away.

> make,
> make all     -> compile vmlinux + modules as a general default,
>                 on i386 build bzImage + modules.
> 	        (other archs can change the behavior as they wish)
I would like an easy way to do a full build, including supporting stuff
such as documentation. Think about doing regression on new kernels?

Today you have to specify a lot of different targets to accomplish
this - something that many people simply do not do.
Make it easy, and people will do it - and see more errors fixed earlier.

allyes, allmodules, allno were introduced for regression purpose.
And make all gives me the association that ALL is build, not only
the core kernel. Therefore I object against the make all semantic
that you suggest.
Better reserve that to a full build.

Furthermore I would advocate for a new target [yes one more!].

"make help"
make help shall generate a short list of available targets, something like:

<<<<<<<<<<<<
>make help
Configuration related targets:
  oldconfig	- bla bla
  menuconfig	- bla bla
  config	- bla bla
  configallyes  - ....
  configallno	- ....
Other generic targets:
  vmlinux	- The generic binary kernel
* modules	- Build all modules
# pdfdocs	- documentation
  all		- Build all targets marked with * and #
Architecture specific targets for current architecture (I386)
* bzImage	- Default compressed kernel (arch/i386/boot/bzImage)
  zImage	- Another target (arch/i386/boot/zImage)

Executing "make" or "make kernel" builds targets marked with '*'
<<<<<<<<<<

The architecture specific stuff should obviously be located in the
corresponding architecture specific makefiles and triggered by archhelp.

Comments?
I would be happy to do a patch if people support this.

	Sam
