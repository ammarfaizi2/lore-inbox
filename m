Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266367AbTAPLTO>; Thu, 16 Jan 2003 06:19:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266406AbTAPLTO>; Thu, 16 Jan 2003 06:19:14 -0500
Received: from [66.70.28.20] ([66.70.28.20]:24845 "EHLO
	maggie.piensasolutions.com") by vger.kernel.org with ESMTP
	id <S266367AbTAPLTN>; Thu, 16 Jan 2003 06:19:13 -0500
Date: Thu, 16 Jan 2003 12:27:45 +0100
From: DervishD <raul@pleyades.net>
To: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Cc: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: argv0 revisited...
Message-ID: <20030116112745.GE87@DervishD>
References: <20030115184455.GB47@DervishD> <200301161104.h0GB4IOY011937@eeyore.valparaiso.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200301161104.h0GB4IOY011937@eeyore.valparaiso.cl>
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Horst :)

> >     I don't like it, because it should happen at the very beginning
> > of init. Remember, is not any program, is an init. Should be a more
> > clean way, I suppose :??
> If it is init, you do have enough control over the environment to just
> hardcode the executable's name?

    Yes, I can hardcode it, but I cannot avoid the admin moving
around or renaming the binary, so this is neither a solution :((

> In any case, I don't see what you want to acomplish here. Care to
> enligthen us a bit?

    I've written a virtual-console-only init. Why this name and why I
coded it is a long story, but the matter is that it is an init that
doesn't need configuration (no /etc/inittab) and that has builtin
klogd, syslogd, getty and login. All the builtins are just forks, so
if you see at the ps output in a system running this, it will show
some instances of a process called 'init'. The first is an init,
true, but the second is the klogd emulator, the third is the slogd
emulator and all other are the gettylogin emulator.

    That is, for clarity, those should be 'renamed'. I cannot rename
the binary, because all them are in the same binary. The only way is
mangling argv[0] in each fork, that's all. Currently, as I know for
the kernel sources that whatever the binary name argv[0] will contain
the string "init" (hope that it doesn't change in the future), I
overwrite it with 'klog', 'slog' and 'into', respectively for the
klogd emulator, the syslogd emulator and the gettylogin process. But
I would like to put more descriptive names. This is not an issue,
because I can go with those four letter names (that can reduced, more
or less meaningfully, to just one character) or even with all
processes called 'init'. The processes themselves doesn't rely on its
name for properly working. They do an openlog() in order to show
meaningful names in the system log.

    That's what I want to do, and changing the names under argv[0]
seems to me as the proper solution. Anyway, it will released in a
week or so under GPL and I think that the code and documentation will
show a better (clearer, at least) picture.

    Raúl
