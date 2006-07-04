Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932376AbWGDUxb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbWGDUxb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 16:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932398AbWGDUxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 16:53:31 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:2355 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932376AbWGDUxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 16:53:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=F0CBpdV5yLsy8I1gXp5Hvcack6xwtgvaZvyhRRNToo92Ojb0172Cifn0fgOPE6hXpUG9hu6QHsc0L8q0aKc/oyq1n0SZUmvRxJ/9t3XA/f02EveE00K5znCBPxfoxxSuntLCWK3+V/YhvuU1LDMnjxcTy0NWDxe+tbKHrCiUjLA=
Date: Wed, 5 Jul 2006 00:53:28 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Petr Vandrovec <petr@vandrovec.name>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add note that lockdep is not allowed with non-GPL modules
Message-ID: <20060704205328.GA7598@martell.zuzino.mipt.ru>
References: <20060704202904.GA24150@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060704202904.GA24150@vana.vc.cvut.cz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2006 at 10:29:04PM +0200, Petr Vandrovec wrote:
> Hi Ingo,
>   can you add this small notice to the lockdep option ?
>
> Lock dependency infrastructure forces all legacy code which uses lock to now
> depend on lockdep_init_map symbol, which is GPL-only.  It means that almost
> no modules can work on kernel with CONFIG_LOCKDEP set.  Let's warn user about
> that.

IANIngo, but the warning is already there:
* Proprietary module user probably already knows that major deviations from .config
  and kernel its module is released is no-no.
* Unknown symbol name contains "lockdep" which attentive proprietary
  module user will notice and correlate with enabling lockdep 5 minutes ago.
* Tomorrow Ingo will change it's name, add a couple of new lockdep only
  exports so should he update help text every time _he_ changes _his_
  code?
* Would you add similar notice to inotify help text? It also exports
  GPL-only symbols doncha know. Would you add such notices to everything
  exporting GPL-only symbols?

> vmmon: module license 'unspecified' taints kernel.
> vmmon: Unknown symbol lockdep_init_map

> +	 Do not enable this option if you are using non-GPL modules, or
> +	 they will fail to load due to missing symbol lockdep_init_map.

Lock validor found a bug in NVidia driver, film at 11.

