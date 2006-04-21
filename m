Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751302AbWDULzf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbWDULzf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 07:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbWDULze
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 07:55:34 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:50366 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1751302AbWDULze
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 07:55:34 -0400
Subject: Re: Removing .tmp_versions considered harmful
From: Pavel Roskin <proski@gnu.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20060421073216.GA17492@mars.ravnborg.org>
References: <1145593342.2904.30.camel@dv>
	 <20060421073216.GA17492@mars.ravnborg.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 21 Apr 2006 07:55:29 -0400
Message-Id: <1145620529.20099.18.camel@dv>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Sam!

On Fri, 2006-04-21 at 09:32 +0200, Sam Ravnborg wrote:
> On Fri, Apr 21, 2006 at 12:22:22AM -0400, Pavel Roskin wrote:
> > Hello!
> > 
> > A patch applied shortly after Linux 2.6.16
> > (fb3cbd2e575f9ac0700bfa1e7cb9f4119fbd0abd in git) causes
> > the .tmp_versions directory to be removed every time make is run to
> > build external modules.
> > 
> > 
> > 2) The projects where modules are build in more than one directory (such
> > as MadWifi) are now compiled with spurious warnings about unresolved
> > symbols.  This happens because every module is compiled individually,
> > and the *.mod files for one module are removed before the other is
> > compiled.
> 
> Then fix madwifi so it builds modules as documented in
> Documentation/kbuild/modules.txt
> See: --- 5.3 External modules using several directories

Thanks for showing me this section!  I wish I saw it before I submitted
patches to MadWifi, HostAP and linux-wlan-ng makefiles.  Now I know how
to fix all that mess.

> As with many other external modules madwifi contains a lot of ugly
> makefile hackery - and if done as documentated it gets so much simpler.
> I'm aware that 2-4 support complicates things a little but if people
> made it be slimm and nice for 2.6 and _then_ added 2.4 supporrrrrrrrrrit
> woulllllld be much simpler.
> It seems that people keep all the hackery for 2.4 and does a bad job
> adapting to 2.6.

I agree with your sentiment, and I'm trying to fix it.

However, the problem with "make install" creating .tmp_versions owned by
root still exists.  Can we settle on removing only *.mod files
under .tmp_versions without removing the directory?
Removing .tmp_versions does nothing if the goal is to remove stale *.mod
files.

-- 
Regards,
Pavel Roskin

