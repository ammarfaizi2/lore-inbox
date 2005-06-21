Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262494AbVFUV22@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262494AbVFUV22 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 17:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262547AbVFUVZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 17:25:35 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:22246 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262530AbVFUVXo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 17:23:44 -0400
To: Andrew Morton <akpm@osdl.org>
cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: -mm -> 2.6.13 merge status 
In-reply-to: Your message of Tue, 21 Jun 2005 14:04:41 PDT.
             <20050621140441.53513a7a.akpm@osdl.org> 
Date: Tue, 21 Jun 2005 14:23:11 -0700
Message-Id: <E1DkqD9-00079l-00@w-gerrit.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 21 Jun 2005 14:04:41 PDT, Andrew Morton wrote:
> Gerrit Huizenga <gh@us.ibm.com> wrote:
> >
> > Kexec/kdump has a chance of working reliably.
> 
> IOW: Kexec/kdump has a chance of not working reliably.
> 
> Worried.

No worries.  Machine locks up hard, hardware failures, etc., there
is a possibility that nothing but a hard reset can unlock a machine.
But that is rare and outside the scope of the simple locking problems
that today prevent crash dumps.  There are still some rough edges in
PCI shutdown code, reinitialization, etc. that will need to be shaken
out over time with more experience, but those at least can be addressed
in the fundamental architecture of kexec/kdump.

About the only possible solution that *might* be fail proof (and even
that case I doubt) would be an external dump program under control
of the firmware (assuming the firmware can still run) which does a
copy of memory off to some device without any assistance from the
kernel.

Kexec/kdump needs much wider exposure at this point and there will
a few bumps along the way.  They should be isolated to cases where
the machine is already crashing and the only thing that doesn't work
is the crash dump/restart.  And those we will fix like any other bugs.

gerrit
