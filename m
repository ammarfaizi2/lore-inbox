Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965766AbWKECEh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965766AbWKECEh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 21:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965788AbWKECEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 21:04:37 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:12478 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S965786AbWKECEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 21:04:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=oz7Mz6xtK9kOm8mZiKZPs7ABWrF3uWDuRpJuUYTdxbyk+KmpfShcyXDSSWxIktBsJ1lh79P5/rnLjFjB5ggoCDmkvSIb01Axich4sRyQ7+zmoPr/1oXbmsM+5bPOYrMU5d3UzX/46dM4N+ZaUyyHmrSFJG/I08mjoE/ito/E00c=
Date: Sun, 5 Nov 2006 05:04:31 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: William D Waddington <william.waddington@beezmo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IRQ: ease out-of-tree migration to new irq_handler prototype
Message-ID: <20061105020431.GA20243@martell.zuzino.mipt.ru>
References: <454CDC11.5030708@beezmo.com> <20061104190357.GA4971@martell.zuzino.mipt.ru> <454CF2DD.40803@beezmo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <454CF2DD.40803@beezmo.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 04, 2006 at 12:06:53PM -0800, William D Waddington wrote:
> Alexey Dobriyan wrote:
> >On Sat, Nov 04, 2006 at 10:29:37AM -0800, William D Waddington wrote:
> >
> >>Ease out-of-tree driver migration to new irq_handler prototype.
> >>Define empty 3rd argument macro for use in multi kernel version
> >>out-of-tree drivers going forward.  Backportable drives can do:
> >>
> >>(in a header)
> >>#ifndef __PT_REGS
> >># define __PT_REGS , struct pt_regs *regs
> >>#endif
> >
> >
> >Backportable drivers should check kernel version themselves and define
> >__PT_REGS themselves.
>
> I think I provided too much information :(  It would be sufficiently
> helpful to just #define __PT_REGS <nothing> in  interrupt.h to make
> things easier for low-life out-of-tree maintainers.  There isn't any
> need to actualy detect version.  Just detect __PT_REGS already defined.

Out-of-tree maintainer will have to change his code ANYWAY. And while he
is doing that, he can spend 10 seconds to add 5-line version check.

More, if you've followed pt_regs removal patches, you'd noticed that
some of them were not trivial. In this case version check is least of
his worries.

> The "in a header" above referred to the driver's header - #ifdefs in
> executable code really looks nasty IMHO.
>
> The "#define __PT_REGS , ..." comment below was intended to be a
> "helpful" note to driver writers.  Like I said, TMI.
>
> >>(in code body)
> >>static irqreturn_t irq_handler(int irq, void *dev_id __PT_REGS)
> >
> >
> >>+/*
> >>+ * Irq handler migration helper - empty 3rd argument
> >>+ * #define __PT_REGS , struct pt_regs *regs
> >>+ * for older kernel versions
> >>+ */
> >>+
> >>+#define __PT_REGS
>
> How should I tidy this up - if it is acceptable at all?

No, this is not acceptable.

