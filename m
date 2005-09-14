Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030281AbVINQxc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030281AbVINQxc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 12:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030280AbVINQxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 12:53:31 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:18186 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1030279AbVINQxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 12:53:31 -0400
Date: Wed, 14 Sep 2005 17:53:26 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kbuild-permanently-fix-kernel-configuration-include-mess.patch added to -mm tree
Message-ID: <20050914175326.C30746@flint.arm.linux.org.uk>
Mail-Followup-To: Sam Ravnborg <sam@ravnborg.org>,
	linux-kernel@vger.kernel.org
References: <200509140841.j8E8fG1w022954@shell0.pdx.osdl.net> <20050914164953.GA7480@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050914164953.GA7480@mars.ravnborg.org>; from sam@ravnborg.org on Wed, Sep 14, 2005 at 06:49:53PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2005 at 06:49:53PM +0200, Sam Ravnborg wrote:
> >  # Use LINUXINCLUDE when you must reference the include/ directory.
> >  # Needed to be compatible with the O= option
> >  LINUXINCLUDE    := -Iinclude \
> > -                   $(if $(KBUILD_SRC),-Iinclude2 -I$(srctree)/include)
> > +                   $(if $(KBUILD_SRC),-Iinclude2 -I$(srctree)/include) \
> > +		   -imacros include/linux/autoconf.h
> >  
> What is the purpose of using -imacros instead of -iinclude
> 
> o -iinclude is much more commonly used for this purpose.
> o sparse has limited support(*) for -iinclude today
> o -imacros will silently ignore any output caused by the file

autoconf.h should only be macro definitions and should not contain
any code, so -imacros seemed to be the correct tool for the job.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
