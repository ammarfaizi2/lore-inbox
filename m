Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268064AbUJSIlg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268064AbUJSIlg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 04:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268070AbUJSIlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 04:41:36 -0400
Received: from phoenix.infradead.org ([81.187.226.98]:14088 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S268064AbUJSIlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 04:41:35 -0400
Date: Tue, 19 Oct 2004 09:41:32 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: mingo@elte.hu, Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       Linus Torvalds <torvalds@osdl.org>, Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] generic irq subsystem: ppc64 port
Message-ID: <20041019084131.GA7100@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, mingo@elte.hu,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Paul Mackerras <paulus@samba.org>
References: <200410190714.i9J7Elnx027734@hera.kernel.org> <1098174500.11449.65.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098174500.11449.65.camel@gaston>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2004 at 06:28:20PM +1000, Benjamin Herrenschmidt wrote:
> Hi !
> 
> That patch will unfortunately break a load of ppc64 boxes.
> 
> If you look closely at the ppc64 code, you'll notice we don't
> use the irq_desc array directly but go through a get_irq_desc()
> accessor. This is because our interrupt numbers can be very
> large and scattered, and thus we have a remapping tree.
> 
> I still like the idea of the patch, so it would be useful if
> you added the possibility for us to just change that behaviour,
> that is replace all occursences of irq_descs + i with get_irq_desc()
> and provide a generic one that just does that, with a #ifndef so
> that the architecture can provide it's own. 
> 
> If you agree with the principle, though, I suppose I can do it
> and send a proposed patch tomorrow.

The PPC64 changes were actually my fault.  I think get_irq_desc() is okay.
