Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266519AbUFUWho@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266519AbUFUWho (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 18:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266513AbUFUWfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 18:35:24 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:27961 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S266505AbUFUWes
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 18:34:48 -0400
Date: Tue, 22 Jun 2004 00:46:31 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Martin Schlemmer <azarah@nosferatu.za.org>
Cc: s0348365@sms.ed.ac.uk, Sam Ravnborg <sam@ravnborg.org>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] kbuild updates
Message-ID: <20040621224631.GE2903@mars.ravnborg.org>
Mail-Followup-To: Martin Schlemmer <azarah@nosferatu.za.org>,
	s0348365@sms.ed.ac.uk, Sam Ravnborg <sam@ravnborg.org>,
	Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
References: <20040620211905.GA10189@mars.ravnborg.org> <20040620220319.GA10407@mars.ravnborg.org> <1087769761.14794.69.camel@nosferatu.lan> <200406202326.54354.s0348365@sms.ed.ac.uk> <1087772041.14794.104.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1087772041.14794.104.camel@nosferatu.lan>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2004 at 12:54:01AM +0200, Martin Schlemmer wrote:
> > 
> > #
> > # where's the kernel source?
> > #
> > 
> > if [ -d /lib/modules/`uname -r`/source ]; then
> > 	# 2.6.8 and newer
> > 	KERNDIR="/lib/modules/`uname -r`/source"
> > else
> > 	# pre 2.6.8 kernels
> > 	KERNDIR="/lib/modules/`uname -r`/build"
> > fi
> > 
> > Yeah?
> 
> Yes, as said before, I can understand the name change.  The point is
> more that the 'build' symlink will change in behavior in certain
> circumstances, and because many projects already support 2.6, and
> make use of the 'build' symlink, they will break.

But they were already broken.
And the patch actually helps here.

See the following table:



                                          Current kbuild                With patch
simple module, no grepping
kernel source + output mixed                  OK                           OK

simple module, no grepping
kernel source separate from output            FAIL *1                      OK


module grepping in src
kernel source + output mixed                  OK                           OK

module grepping in src
kernel source separate from output            FAIL *2                      FAIL *3




FAIL *1	Module cannot build because it fails to locate the compiled files used for kbuild.
        Also the kernel configuration is missing.

FAIL *2 Same as FAIL *1. Module cannot build because kbuild compiled files are missing and
        it cannot access kernel configuration.
        Also it fails to locate files when grepping.

FAIL *3 Grep will fail because it try to grep in files located under build/



The above table clearly shows that this patch fix building external modules in the
case where no grepping were preformed.
And the error were simplified in the last case.
So improvements all over.

What one should realise is that the patch makes it less painfull when kernels
are build using the separate output directory option.
And when that feature is not used - no change in behaviour occur.

	Sam
 
