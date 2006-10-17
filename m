Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751350AbWJQRko@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbWJQRko (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 13:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbWJQRko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 13:40:44 -0400
Received: from solarneutrino.net ([66.199.224.43]:7438 "EHLO
	tau.solarneutrino.net") by vger.kernel.org with ESMTP
	id S1751350AbWJQRkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 13:40:43 -0400
Date: Tue, 17 Oct 2006 13:40:20 -0400
To: Keith Packard <keithp@keithp.com>
Cc: dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Intel 965G: i915_dispatch_cmdbuffer failed (2.6.19-rc2)
Message-ID: <20061017174020.GA24789@tau.solarneutrino.net>
References: <20061013194516.GB19283@tau.solarneutrino.net> <1160849723.3943.41.camel@neko.keithp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1160849723.3943.41.camel@neko.keithp.com>
User-Agent: Mutt/1.5.9i
From: Ryan Richter <ryan@tau.solarneutrino.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 14, 2006 at 11:15:23AM -0700, Keith Packard wrote:
> On Fri, 2006-10-13 at 15:45 -0400, Ryan Richter wrote:
> > I have a new Intel 965G board, and I'm trying to get DRI working.
> > Direct rendering is enabled, but all GL programs crash immediately.
> > The message 'DRM_I830_CMDBUFFER: -22' is printed on the tty, and the
> > kernel says:
> > 
> > [drm:i915_cmdbuffer] *ERROR* i915_dispatch_cmdbuffer failed
> 
> The 915 DRM validates commands sent to the card from the application to
> ensure they aren't directing the card to access memory outside of the
> graphics area. At present the module validates only 915/945 commands
> correctly and the 965 uses slightly different commands. I haven't walked
> over the entire GL library, but it seems possible that this error is
> being caused by the mis-validation of the command stream. We need to
> update the DRM driver to reflect the new commands, but in the meanwhile,
> you might try disabling the validation in the kernel (which will expose
> your system to a local root compromise) and seeing if that doesn't
> eliminate this message.

So do I want something like


static int do_validate_cmd(int cmd)
{
	return 1;
}

in i915_dma.c?

Thanks,
-ryan
