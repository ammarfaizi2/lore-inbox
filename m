Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751068AbVIMVzN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751068AbVIMVzN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 17:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751073AbVIMVzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 17:55:13 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:56255 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751068AbVIMVzL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 17:55:11 -0400
Date: Tue, 13 Sep 2005 22:55:06 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
       LKML <linux-kernel@vger.kernel.org>, jdike@addtoit.com
Subject: Re: asm-offsets.h is generated in the source tree
Message-ID: <20050913215506.GU25261@ZenIV.linux.org.uk>
References: <20050910161917.GA22113@mars.ravnborg.org> <20050911023203.GH25261@ZenIV.linux.org.uk> <20050911083153.GA24176@mars.ravnborg.org> <20050911154550.GJ25261@ZenIV.linux.org.uk> <20050911170425.GA8049@mars.ravnborg.org> <20050911212942.GK25261@ZenIV.linux.org.uk> <20050911220328.GE2177@mars.ravnborg.org> <20050911231601.GL25261@ZenIV.linux.org.uk> <20050912191525.GA13435@mars.ravnborg.org> <20050913063028.GQ25261@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050913063028.GQ25261@ZenIV.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2005 at 07:30:28AM +0100, Al Viro wrote:
> * Provide a function that would
> 	take target of form <directory>/.<link>
> 	create a symlink at <directory>/<link> to argument of function,
> doing obvious changes for O=
> 	touch the target

ifneq ($(KBUILD_SRC),)
define symlink
        $(Q)mkdir -p $(dir $@)
        $(Q)ln -sn $(srctree)/$(dir $@)/$1 $(dir $@)$(patsubst .%,%,$(notdir $@))
        $(Q)touch $@
endef
else
define symlink
        $(Q)ln -sn $1 $(dir $@)$(patsubst .%,%,$(notdir $@))
        $(Q)touch $@
endef
endif

would do it, AFAICS.  Objections?
