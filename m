Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbTIYSNl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 14:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbTIYSM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 14:12:57 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:46610 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S261376AbTIYSLb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 14:11:31 -0400
Date: Thu, 25 Sep 2003 20:11:27 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: Re: [2.6 patch] add a config option for -Os compilation
Message-ID: <20030925181127.GB2089@mars.ravnborg.org>
Mail-Followup-To: Adrian Bunk <bunk@fs.tum.de>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Yoshinori Sato <ysato@users.sourceforge.jp>
References: <20030914121655.GS27368@fs.tum.de> <20030914133349.A27870@flint.arm.linux.org.uk> <20030914132143.GT27368@fs.tum.de> <20030914155245.A675@flint.arm.linux.org.uk> <20030925143844.GY15696@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030925143844.GY15696@fs.tum.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 25, 2003 at 04:38:45PM +0200, Adrian Bunk wrote:
> --- linux-2.6.0-test5-mm4/init/Kconfig.old	2003-09-25 14:38:18.000000000 +0200
> +++ linux-2.6.0-test5-mm4/init/Kconfig	2003-09-25 14:47:12.000000000 +0200
> @@ -65,6 +65,16 @@
>  
>  menu "General setup"
>  
> +config OPTIMIZE_FOR_SIZE
> +	bool "Optimize for size" if EXPERIMENTAL
> +	default y if ARM || H8300
> +	default n
> +	help
> +	  Enabling this option will pass "-Os" instead of "-O2" to gcc
> +	  resulting in a smaller kernel.
> +
> +	  If unsure, say N.
> +

This is a general file, and it is wrong to include architecture specific
knowledge here.
I recall that Roman Zippel introduced "enable" for exactly this purpose.

I looked into Documentation/kbuild/kconfig-language.txt but did not
see it documented - Roman?

Another comment about the naming of the config symbol.
We keep getting more config symbols controlling options to GCC.
A naming scheme like: CONFIG_CC_OPTIMIZE_FOR_SIZE, CONFIG_CC_DEBUG_INFO
is preferable since it give better context information.
Let's start with this option, and rename the others later.

	Sam
