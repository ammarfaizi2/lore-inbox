Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030309AbWHHWGF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030309AbWHHWGF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 18:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030312AbWHHWGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 18:06:05 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:20372 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1030309AbWHHWGE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 18:06:04 -0400
Date: Wed, 9 Aug 2006 00:05:09 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Magnus Damm <magnus@valinux.co.jp>, linux-kernel@vger.kernel.org,
       fastboot@lists.osdl.org
Subject: Re: [PATCH] CONFIG_RELOCATABLE modpost fix
Message-ID: <20060808220509.GA8378@mars.ravnborg.org>
References: <20060808083307.391.45887.sendpatchset@cherry.local> <20060808183954.GA8300@mars.ravnborg.org> <m17j1j6ltk.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m17j1j6ltk.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2006 at 01:59:03PM -0600, Eric W. Biederman wrote:
 
> Sam, Magnus: 
> 
> I'm dense.  Why do we want to run modpost if we are building a kernel
> that doesn't support modules?
> 
> I haven't mucked with modpost at all so I don't have a good feel for
> what it does, or why we want to run it.
> 
> My quick skimming says modpost is all about generating the module
> version symbol scrambling.  Which if that is all it does means it is
> senseless to run this without modules.

Recently modpost has been enhanced to do section reference checks.
So modpost is used to check that there is no references from .text to
.init.text - the latter will be freed by the kernel so we better avoid
it.

The consistency checks does a bit more than just that simple check but
this was enough reason to run it twice in the build process.

	Sam
