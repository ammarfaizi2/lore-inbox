Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030181AbVINQrV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030181AbVINQrV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 12:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030265AbVINQrV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 12:47:21 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:60465 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S1030181AbVINQrU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 12:47:20 -0400
Date: Wed, 14 Sep 2005 18:49:53 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: rmk+lkml@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: kbuild-permanently-fix-kernel-configuration-include-mess.patch added to -mm tree
Message-ID: <20050914164953.GA7480@mars.ravnborg.org>
References: <200509140841.j8E8fG1w022954@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509140841.j8E8fG1w022954@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  # Use LINUXINCLUDE when you must reference the include/ directory.
>  # Needed to be compatible with the O= option
>  LINUXINCLUDE    := -Iinclude \
> -                   $(if $(KBUILD_SRC),-Iinclude2 -I$(srctree)/include)
> +                   $(if $(KBUILD_SRC),-Iinclude2 -I$(srctree)/include) \
> +		   -imacros include/linux/autoconf.h
>  
What is the purpose of using -imacros instead of -iinclude

o -iinclude is much more commonly used for this purpose.
o sparse has limited support(*) for -iinclude today
o -imacros will silently ignore any output caused by the file

	Sam
