Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264818AbTBAMvr>; Sat, 1 Feb 2003 07:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264822AbTBAMvr>; Sat, 1 Feb 2003 07:51:47 -0500
Received: from mailgate5.cinetic.de ([217.72.192.165]:27555 "EHLO
	mailgate5.cinetic.de") by vger.kernel.org with ESMTP
	id <S264818AbTBAMvq>; Sat, 1 Feb 2003 07:51:46 -0500
Date: Sat, 1 Feb 2003 14:00:55 +0100
Message-Id: <200302011300.h11D0tO26666@mailgate5.cinetic.de>
MIME-Version: 1.0
Organization: http://freemail.web.de/
From: Konrad Eisele <eiselekd@web.de>
To: "KaiGermaschewski" <kai@tp1.ruhr-uni-bochum.de>,
       "PeteZaitcev" <zaitcev@redhat.com>
Cc: "KonradEisele" <eiselekd@web.de>, linux-kernel@vger.kernel.org
Subject: Re: Re: Perl in the toolchain
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de> schrieb am 31.01.03 20:41:39:
> 
> On Fri, 31 Jan 2003, Pete Zaitcev wrote:
> 
> > Kai, what's your opinion? I suspect you missed my posing to l-k
> 
> > Date: Thu, 30 Jan 2003 14:53:59 +0100
> > From: Konrad Eisele <eiselekd@web.de>
> > To: "PeteZaitcev" <zaitcev@redhat.com>
> > Subject: Adding sparc-leon linux to sourcetree
> > 
> > .....
> > There is also one change I have made on the buildsystem. Because I'm using some 
> > perl inline scripts in the $cmd_xxx the >'<  and >$< signs in the inline perl scripts 
> > cause trouble (perl -e '...$x=....'), the >'< because of the echo command, the >$< when
> > rereading from the xxx..cmd files. Could this be applied to the original file?
> 
> Unfortunately, I cannot find the original posting quoted above, since 
> that would probably reveal where the actual usage of perl is.
> 

I wanted to use perl inline script in a post build command to check weather the kernel 
fits in rom for a port of Linux to the sparc Leon Processor. Which requires nested 
if then clauses.
First, I could also call an external script but that would require a new file, so inline script 
is nicer. Second, I could do the checking with shell if then clauses and expressions 
without $ or ', but perl is much nicer to read. Especially if you have hex conversion 
and large calculations. 

> Generally, we've been trying to not make perl a prequisite for the kernel 
> build, and I'd like to keep it that way. Except for some arch specific 
> stuff I don't really care about, the uses of perl are for the optional 
> "make checkconfig" etc. (which btw look mostly obsolete and should 
> probably be killed), and for generating some firmware, though by default a 
> shipped version of the generated files is used.
> 
> That said, I'm not necessarily opposed to allowing for use of ',$ in the 
> command variables as the change above does (getting that as a patch would 
> be nice, though).
> 
> --Kai
> 
> > scripts/Makefile.lib:
> > +-------------------------------+
> > 
> > # ===========================================================================
> > # Generic stuff
> > # ===========================================================================
> > 
> > # function to only execute the passed command if necessary
> > # the ' -> '\'' and $ to $$ substitution are done if $(cmd_$(1)) includes a inline perlscript
> > 
> > if_changed = $(if $(strip $? \
> > 		          $(filter-out $(cmd_$(1)),$(cmd_$@))\
> > 			  $(filter-out $(cmd_$@),$(cmd_$(1)))),\
> > 	@set -e; \
> > 	$(if $($(quiet)cmd_$(1)),echo '  $(subst ','\'',$($(quiet)cmd_$(1)))';) \
> > 	$(cmd_$(1)); \
> > 	echo 'cmd_$@ := $(subst $$,$$$$,$(subst ','\'',$(cmd_$(1))))' > $(@D)/.$(@F).cmd)
> 
> 


______________________________________________________________________________
Die SMS direkt auf's Handy. - Die Blitz-SMS bei WEB.DE FreeMail
http://freemail.web.de/features/?mc=021165

