Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314613AbSEUOTM>; Tue, 21 May 2002 10:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314634AbSEUOTL>; Tue, 21 May 2002 10:19:11 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:7340 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S314613AbSEUOTK>; Tue, 21 May 2002 10:19:10 -0400
Date: Tue, 21 May 2002 09:19:08 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Jan Harkes <jaharkes@cs.cmu.edu>
cc: torvalds@transmeta.com, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.17 build hides errors
In-Reply-To: <20020521074532.GA27185@ravel.coda.cs.cmu.edu>
Message-ID: <Pine.LNX.4.44.0205210913310.10815-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 May 2002, Jan Harkes wrote:

> The following patch allows the kernel compile to abort on errors again.
> It also fixes some missing includes in filesystems that were broken by
> the removal of locks.h.

Yup, just fixed the same problem - should better have gone through my 
lkml mail before. My patch is slightly different (does '|| exit $?' 
instead), but achieves the same thing.

Actually, I think I like yours better.

At least this proves that it's obviously possible for other people to
grasp what's going in Rules.make - which is good ;-)

--Kai



> diff -urN linux-2.5.17/Rules.make linux-trivial/Rules.make
> --- linux-2.5.17/Rules.make	Tue May 21 01:46:03 2002
> +++ linux-trivial/Rules.make	Tue May 21 03:35:35 2002
> @@ -380,5 +380,5 @@
>  if_changed = $(if $(strip $? \
>  		          $(filter-out $($(1)),$(cmd_$@))\
>  			  $(filter-out $(cmd_$@),$($(1)))),\
> -	       @echo $($(1)); $($(1)); echo 'cmd_$@ := $($(1))' > .$@.cmd)
> +	       @echo $($(1)) && $($(1)) && echo 'cmd_$@ := $($(1))' > .$@.cmd)
>  


