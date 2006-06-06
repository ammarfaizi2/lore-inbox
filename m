Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750825AbWFFSfv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbWFFSfv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 14:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750936AbWFFSfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 14:35:51 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:404 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S1750825AbWFFSfv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 14:35:51 -0400
Date: Tue, 6 Jun 2006 20:35:49 +0200
From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: kbuild patch (20a468b51325b3636785a8ca0047ae514b39cbd5) breaks parallels-config
Message-ID: <20060606183549.GB11300@cip.informatik.uni-erlangen.de>
Mail-Followup-To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	Sam Ravnborg <sam@ravnborg.org>,
	LKML <linux-kernel@vger.kernel.org>
References: <20060605164950.GB4552@cip.informatik.uni-erlangen.de> <20060605213111.GA15346@mars.ravnborg.org> <20060605222735.GG4552@cip.informatik.uni-erlangen.de> <20060606181437.GA17977@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060606181437.GA17977@mars.ravnborg.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> First off - the below does not even remotely resemble a Kbuild file.
> There are a shitload of deinitions not used by kbuild etc etc.
> Parallels should ship a Kbuild file instead with the kernel specific
> things included and be done with it.  This works for others and they
> do not need to generate their Makefile using autotools.

agreed.

> What your patch did was to remove a fundamental part of the build system
> - and I'm suprised that you actually managed to build something.

my patch does not removes anything it just moves one line a few lines
down (as it was before your commit 20a468b51325b...:

        --- a/scripts/Makefile.build
        +++ b/scripts/Makefile.build
        @@ -10,12 +10,11 @@ __build:
         # Read .config if it exist, otherwise ignore
         -include .config
         
      | -include scripts/Kbuild.include
      | -
     /    # The filename Kbuild has precedence over Makefile
    /    kbuild-dir := $(if $(filter /%,$(src)),$(src),$(srctree)/$(src))
   |     include $(if $(wildcard $(kbuild-dir)/Kbuild), $(kbuild-dir)/Kbuild, $(kbuild-dir)/Makefile)
   \     
    `-> +include scripts/Kbuild.include
         include scripts/Makefile.lib
         
         ifdef host-progs

> I suggest that you ask the Parallels people to create a clean solution
> for the 2.6 kernel - seeking inspiration in Documentation/kbuild/*
> and when this works tweak it minimally to support the 2.4 kernel.

I will.

        Thomas
