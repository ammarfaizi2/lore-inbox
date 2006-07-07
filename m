Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932357AbWGGWhH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932357AbWGGWhH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 18:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932365AbWGGWhH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 18:37:07 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:36485 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932357AbWGGWhG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 18:37:06 -0400
Date: Sat, 8 Jul 2006 00:36:50 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Bob Tracy <rct@gherkin.frus.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc1 build error (YACC): followup
Message-ID: <20060707223650.GB28811@mars.ravnborg.org>
References: <20060707202442.DA2AFDBA1@gherkin.frus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060707202442.DA2AFDBA1@gherkin.frus.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2006 at 03:24:42PM -0500, Bob Tracy wrote:
> I wrote:
> >$YACC now seems to be undefined when I do a "make bzImage" and the
> >build process gets to drivers/scsi/aic7xxx/aicasm (with the aic7xxx
> >driver configured as a built-in).  As a workaround, it's possible to
> >"cd" into the indicated directory and run "make" directly.  Once the
> >default build completes, restarting "make bzImage" from the kernel
> >source root continues as expected.
> 
> Found it.  The main "Makefile" has "MAKEFLAGS += -rR" uncommented as
> of 2.6.18-rc1.  The deleted comment about "possibly random breakage"
> that used to be just above that line pretty much says it all :-).
I have now applied a patch where YACC= bison is dined in
aicasm/Makefile.
There are no other $(YACC) users in the kernel - the others specify bison
direct.

	Sam
