Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317034AbSF1CQ6>; Thu, 27 Jun 2002 22:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317035AbSF1CQ6>; Thu, 27 Jun 2002 22:16:58 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:55822 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S317034AbSF1CQ5>;
	Thu, 27 Jun 2002 22:16:57 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>, mec@shout.net,
       kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kconfig: menuconfig and config uses $objtree 
In-reply-to: Your message of "Fri, 28 Jun 2002 00:14:52 +0200."
             <20020628001452.A14485@mars.ravnborg.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 28 Jun 2002 12:19:00 +1000
Message-ID: <31443.1025230740@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jun 2002 00:14:52 +0200, 
Sam Ravnborg <sam@ravnborg.org> wrote:
>In order to prepare for separate obj and src trees make use of $objtree
>within scripts/Menuconfig and scripts/Configure.
>All temporary and all result files are located in directory pointed at
>by $objtree.
>
>This functionality is foreseen useful for both current kbuild and kbuild-2.5

Wrong approach.  This messes up kbuild 2.5.  The config tools should
not know where the files are being read from or written to, you have
hard coded knowledge about the tree structure into the config system.

kbuild 2.5 handles this by constructing a set of symlinks then invoking
the configure system under those symlinks, followed by copying any
results to their destination.  The symlink tree completely isolates
the config system from any knowledge of where its inpuuts and outputs
really are, everything looks local.

You have a 750+ line patch to imbed tree knowledge into configure, that
knowledge will have to be duplicated for any new CML tools.  kbuild 2.5
does it in a few lines of scripts/Makefile-2.5 which automatically
works for any new CML code.

