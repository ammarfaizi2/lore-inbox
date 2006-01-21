Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750907AbWAUWND@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750907AbWAUWND (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 17:13:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750838AbWAUWND
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 17:13:03 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:27922 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750907AbWAUWNB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 17:13:01 -0500
Date: Sat, 21 Jan 2006 23:12:49 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Olaf Hering <olh@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cc-version not available to change EXTRA_CFLAGS
Message-ID: <20060121221249.GB7711@mars.ravnborg.org>
References: <20060121180805.GA15761@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060121180805.GA15761@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 21, 2006 at 07:08:05PM +0100, Olaf Hering wrote:
> 
> I want to add a gcc version check for reiserfs, on akpms request.
> This one doesnt work with 2.6.16rc1, havent checked if it ever worked.
...
> Index: linux-2.6.16-rc1-olh/fs/reiserfs/Makefile
> ===================================================================
> --- linux-2.6.16-rc1-olh.orig/fs/reiserfs/Makefile
> +++ linux-2.6.16-rc1-olh/fs/reiserfs/Makefile
> @@ -28,7 +28,7 @@ endif
>  # will work around it. If any other architecture displays this behavior,
>  # add it here.
>  ifeq ($(CONFIG_PPC32),y)
> -EXTRA_CFLAGS := -O1
> +EXTRA_CFLAGS := $(shell set -x ; if [ $(call cc-version) -lt 0402 ] ; then echo $(call cc-option,-O1); fi ;)
>  endif

cc-option is only available from main Makefile as of today.
I can try to move them to Kbuild.include - that should fix this usecase.

	Sam
