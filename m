Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263553AbTIBGOV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 02:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263509AbTIBGOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 02:14:21 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:5252 "EHLO
	grelber.thyrsus.com") by vger.kernel.org with ESMTP id S263553AbTIBGOU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 02:14:20 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: Make clean misses stuff in 2.6.0-test4.
Date: Tue, 2 Sep 2003 02:15:01 -0400
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200309011742.37021.rob@landley.net> <20030902041547.GB1016@mars.ravnborg.org>
In-Reply-To: <20030902041547.GB1016@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309020215.01953.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 02 September 2003 00:15, Sam Ravnborg wrote:
> On Mon, Sep 01, 2003 at 05:42:37PM -0400, Rob Landley wrote:
> > I did a build as root, did a make clean (still as root), and then kicked
> > off a build as my normal user account:
> >
> > It died:
> >
> > rm: cannot remove `.tmp_versions/cryptoloop.mod': Permission denied
>
> The directory .tmp_versions is not deleted by 'make clean'.
> For that you need 'make mrproper'.
>
> 	Sam

Which zaps the .config, last time I tried it.  (Just tried it again and yup, 
it zapped it.)

Interestingly, I forgot that make install doesn't install modules (for that 
you need make modules_install), but it DOES try to re-index them (resulting 
in some complaints about the modules for the smp kernel I'd accidentally 
compiled earlier having unresolved symbols in them).  I misinterpreted this 
as it complaining that the *.ko files in the build tree hadn't been updated, 
and did a "find . -name '*.ko' | xargs rm", and at that point the build 
process's dependencies got confused enough I just did a make clean and 
started over...

Don't mind me, I'm having fun...

Rob

