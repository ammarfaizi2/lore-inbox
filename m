Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263712AbTDITmm (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 15:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263724AbTDITmm (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 15:42:42 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:31249 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id S263712AbTDITmh (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 15:42:37 -0400
Date: Wed, 9 Apr 2003 21:54:12 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: "Robert P. J. Day" <rpjday@mindspring.com>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: what means duplicate "config" entries in Kconfig file?
In-Reply-To: <Pine.LNX.4.44.0304091237490.28112-100000@dell>
Message-ID: <Pine.LNX.4.44.0304092115160.5042-100000@serv>
References: <Pine.LNX.4.44.0304091237490.28112-100000@dell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 9 Apr 2003, Robert P. J. Day wrote:

>   the two options X86_VISWS and X86_VOYAGER are simple "bool"s
> representing the (radio-box) subarchitecture type.
> 
>   the first seems to represent a dependency of *neither* of those
> two listed options, while the second config *depends* on one of 
> them.  
> 
>   how exactly do you reconcile what looks like contradictory
> dependencies for the same config entry?

With config entries you mainly define menu prompts and defaults. 
Dependencies are now properties of these prompts and defaults. With "if" 
you can define dependencies which are only attached to these prompts or 
defaults. Dependencies defined with "depends on" are attached to all of 
them defined within this menu entry.
Internally this becomes a simple list:

config MCA
  +- prompt "MCA support"
  |    +- depends on !(X86_VISWS || X86_VOYAGER)
  +- default y
       +- depends on X86_VOYAGER

If you enable the debug option of xconfig, this list is displayed with the 
help text.

bye, Roman

