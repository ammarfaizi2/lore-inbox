Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261907AbTAaTcM>; Fri, 31 Jan 2003 14:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261908AbTAaTcM>; Fri, 31 Jan 2003 14:32:12 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:10983 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S261907AbTAaTcK>; Fri, 31 Jan 2003 14:32:10 -0500
Date: Fri, 31 Jan 2003 13:41:26 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Pete Zaitcev <zaitcev@redhat.com>
cc: linux-kernel@vger.kernel.org, Konrad Eisele <eiselekd@web.de>
Subject: Re: Perl in the toolchain
In-Reply-To: <20030131133929.A8992@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.44.0301311327480.16486-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Jan 2003, Pete Zaitcev wrote:

> Kai, what's your opinion? I suspect you missed my posing to l-k

> Date: Thu, 30 Jan 2003 14:53:59 +0100
> From: Konrad Eisele <eiselekd@web.de>
> To: "PeteZaitcev" <zaitcev@redhat.com>
> Subject: Adding sparc-leon linux to sourcetree
> 
> .....
> There is also one change I have made on the buildsystem. Because I'm using some 
> perl inline scripts in the $cmd_xxx the >'<  and >$< signs in the inline perl scripts 
> cause trouble (perl -e '...$x=....'), the >'< because of the echo command, the >$< when
> rereading from the xxx..cmd files. Could this be applied to the original file?

Unfortunately, I cannot find the original posting quoted above, since 
that would probably reveal where the actual usage of perl is.

Generally, we've been trying to not make perl a prequisite for the kernel 
build, and I'd like to keep it that way. Except for some arch specific 
stuff I don't really care about, the uses of perl are for the optional 
"make checkconfig" etc. (which btw look mostly obsolete and should 
probably be killed), and for generating some firmware, though by default a 
shipped version of the generated files is used.

That said, I'm not necessarily opposed to allowing for use of ',$ in the 
command variables as the change above does (getting that as a patch would 
be nice, though).

--Kai

> scripts/Makefile.lib:
> +-------------------------------+
> 
> # ===========================================================================
> # Generic stuff
> # ===========================================================================
> 
> # function to only execute the passed command if necessary
> # the ' -> '\'' and $ to $$ substitution are done if $(cmd_$(1)) includes a inline perlscript
> 
> if_changed = $(if $(strip $? \
> 		          $(filter-out $(cmd_$(1)),$(cmd_$@))\
> 			  $(filter-out $(cmd_$@),$(cmd_$(1)))),\
> 	@set -e; \
> 	$(if $($(quiet)cmd_$(1)),echo '  $(subst ','\'',$($(quiet)cmd_$(1)))';) \
> 	$(cmd_$(1)); \
> 	echo 'cmd_$@ := $(subst $$,$$$$,$(subst ','\'',$(cmd_$(1))))' > $(@D)/.$(@F).cmd)


