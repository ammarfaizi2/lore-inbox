Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317686AbSHDTwx>; Sun, 4 Aug 2002 15:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318173AbSHDTwx>; Sun, 4 Aug 2002 15:52:53 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:65038 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S317686AbSHDTwx>;
	Sun, 4 Aug 2002 15:52:53 -0400
Date: Sun, 4 Aug 2002 22:04:17 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Sam Ravnborg <sam@ravnborg.org>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>,
       martin@dalecki.de
Subject: Re: [PATCH] automatic module_init ordering
Message-ID: <20020804220417.A8175@mars.ravnborg.org>
Mail-Followup-To: Roman Zippel <zippel@linux-m68k.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
	linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>,
	martin@dalecki.de
References: <20020802232232.A25583@mars.ravnborg.org> <Pine.LNX.4.44.0208022011490.24984-100000@chaos.physics.uiowa.edu> <20020804001147.A9226@mars.ravnborg.org> <3D4D48A7.6BA919D2@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D4D48A7.6BA919D2@linux-m68k.org>; from zippel@linux-m68k.org on Sun, Aug 04, 2002 at 05:30:47PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 04, 2002 at 05:30:47PM +0200, Roman Zippel wrote:
>
> Could you try the attached patch? It should fix all the mentioned
> problems. Files are now regenerated only if something really changed.
> if_changed needed a fix to correctly save the command line and
> dependencies should be correct now.

Looks good, a few comments remains. We are down to matter of personal taste.

> +builtin_mods := $(addsuffix .builtin_mods,$(sort $(dir $(CORE_FILES) $(LIBS)
$(DRIVERS) $(NETWORKS))))
A verbose comment above this line descibing the whole concept about initcalls
would be nice. Keep it short and informative.

> +     @echo 'cmd_$(@F) := $(cmd_gen_initcalls)' > .$(@F).cmd
I would like to see $(notdir and the counterpart $(dir used instead of
$(@F) and $(@D). The latter two are deprecated by make.
See make.info.
This is general for all of kbuild, but since this is new stuff I bring it up.

        Sam

