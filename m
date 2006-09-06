Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751449AbWIFSKj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbWIFSKj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 14:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751470AbWIFSKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 14:10:38 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:51877 "EHLO pasmtpA.tele.dk")
	by vger.kernel.org with ESMTP id S1751449AbWIFSKh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 14:10:37 -0400
Date: Wed, 6 Sep 2006 20:15:41 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Kirill Korotaev <dev@sw.ru>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrey Mirkin <amirkin@sw.ru>
Subject: Re: [RFC][PATCH] fail kernel compilation in case of unresolved symbols
Message-ID: <20060906181541.GA24422@uranus.ravnborg.org>
References: <44FD7FED.7000603@sw.ru> <20060905153159.GA13082@uranus.ravnborg.org> <44FEE3A6.1080009@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44FEE3A6.1080009@sw.ru>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2006 at 07:05:10PM +0400, Kirill Korotaev wrote:
> Sam Ravnborg wrote:
> >On Tue, Sep 05, 2006 at 05:47:25PM +0400, Kirill Korotaev wrote:
> >
> >>At stage 2 modpost utility is used to check modules.
> >>In case of unresolved symbols modpost only prints warning.
> >>
> >>IMHO it is a good idea to fail compilation process in case of
> >>unresolved symbols, since usually such errors are left unnoticed,
> >>but kernel modules are broken.
> >
> >
> >The primary reason why we do not fail in this case is that building
> >external modules often result in unresolved symbols at modpost time.
> >
> >And there is many legitime uses of external modules that we shall support.
> ok. is it ok for you to introduce new Make target 'modules_check'?
In top-level Makefile we already distingush between external modules and
internal modules. See the different calls to Makefile.modpost

Could you try updating your patch so in the normal case we exit with
a fail in case of unresolved symbols but if a specific flag is specified
we only warn on unresolved symbols.

And then introduce the nw flag only for external modules in the
top-level Makefile.

	Sam
