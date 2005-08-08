Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932074AbVHHOSF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbVHHOSF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 10:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932076AbVHHOSF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 10:18:05 -0400
Received: from thunk.org ([69.25.196.29]:13002 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S932074AbVHHOSE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 10:18:04 -0400
Date: Mon, 8 Aug 2005 10:17:48 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Dumitru Ciobarcianu <Dumitru.Ciobarcianu@iNES.RO>
Cc: luming.yu@intel.com, Linus Torvalds <torvalds@osdl.org>,
       Len Brown <len.brown@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.6.13-rc6: aic7xxx testers please..
Message-ID: <20050808141748.GB5885@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Dumitru Ciobarcianu <Dumitru.Ciobarcianu@iNES.RO>,
	luming.yu@intel.com, Linus Torvalds <torvalds@osdl.org>,
	Len Brown <len.brown@intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0508071136020.3258@g5.osdl.org> <1123449283.2549.12.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1123449283.2549.12.camel@localhost>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2005 at 12:14:43AM +0300, Dumitru Ciobarcianu wrote:
> ??n data de Du, 07-08-2005 la 11:47 -0700, Linus Torvalds a scris:
> > Luming Yu:
> >   [ACPI] revert Embedded Controller to polling-mode by default (ala 2.6.12)
> >   [ACPI] CONFIG_ACPI_HOTKEY is now "n" by default
> 
> IMHO you really need then to make acpi_specific_hotkey the default or at
> least mention it in the release notes or you'll have tons of people
> screaming that the specific module does not work anymore.
> I found out about it after my toshiba_acpi module stopped working and I
> noticed a small change in the development acpi tree documentation
> mentioning acpi_specific_hotkey ...

What was the reasoning behind this UI design decision anyway?  If you
don't enable the generic hotkey code, it seems _stupid_ to require a
magic boot-time config option in order to enable the specific hotkey
code.  Yes, at the very least we should do is mention this
brain-damaged UI in the release notes, since otherwise users will get
the warning, recompile without the generic hotkey support, and then be
confused when the IBM driver still complains that it can't start
because we're using generic hotkey support --- which is not enabled!

The developer/user will at this point either (a) start diving into the
kernel sources and marvelling at the user-hostile UI design decisions
involved, or (b) start screaming and pounding their head against a
brick wall.

At least in the case of the IBM driver, it provides _far_ more
functionality than the generic hotkey option (ultrabay control,
docking control, bluetooth enable/disable, fan control, etc.) so if it
is compiled it, it should by default take precedence over the hotkey
code.  I'm not convinced there should be any need for a mysterious
command-line option at all, but if it is present, it should only
provide an override in case both the generic and the hotkey-specific
drivers are compiled in.  If they are modules, the first module to
load should take precedence, and if they are both compiled in, the
laptop-specific should take precendence unless there is a boot-time
option to the contrary.

Len, am I missing something, or will you accept a patch.... ?

						- Ted
