Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265700AbUA0Tjt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 14:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265661AbUA0ThG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 14:37:06 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:22763 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S265663AbUA0TgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 14:36:11 -0500
Subject: Re: [PATCH] kgdb-x86_64-support.patch for 2.6.2-rc1-mm3
From: Jim Houston <jim.houston@comcast.net>
Reply-To: jim.houston@comcast.net
To: Andi Kleen <ak@suse.de>
Cc: akpm@osdl.org, george@mvista.com, amitkale@emsyssoft.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040127190251.4edb873d.ak@suse.de>
References: <20040127030529.8F860C60FC@h00e098094f32.ne.client2.attbi.com>
	 <20040127155619.7efec284.ak@suse.de>
	 <1075225399.1020.239.camel@new.localdomain>
	 <20040127190251.4edb873d.ak@suse.de>
Content-Type: text/plain
Organization: 
Message-Id: <1075232116.1020.326.camel@new.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 27 Jan 2004 14:35:17 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-01-27 at 13:02, Andi Kleen wrote:
> On 27 Jan 2004 12:43:20 -0500
> Jim Houston <jim.houston@comcast.net> wrote:

> > arch/x86_64/Kconfig
> > arch/x86_64/Kconfig.kgdb
> > 	We used a different approach to selecting DEBUG_INFO.
> > 	I was not really happy with the way select DEBUG_INFO worked.
> 
> You reverted it back? 
> 
> What I did was to change all not really kgdb specific CONFIG_KGDB uses in
> the main kernel with CONFIG_DEBUG_INFO (mostly CFI support). I don't feel
> strongly about it, but this way there is no reference to an unknown
> config symbol in mainline. Also DEBUG_INFO including CFI makes sense I think.

Hi Andi,

I'm using CONFIG_DEBUG_INFO, but I used a different mechanism to
select it when KGDB is selected.  I'm still learning to speak Kconfig.

My patch:

   config KGDB
        bool "Include kgdb kernel debugger"
        depends on DEBUG_KERNEL
        select DEBUG_INFO
        help
          If you say Y here, the system will be compiled with the debug

Your patch:

  config DEBUG_INFO
        bool "Compile kernel with debug information" if !KGDB
        default y

Using "select DEBUG_INFO" selects the option and makes the input box
on xconfig disappear.  The line describing the option remains, perhaps
leaving a user wondering why this line doesn't have an input box.

With your version, the DEBUG_INFO option disappears when KGDB forces
it on.

I was looking for a way to get the old behavior where the 
the effect was controlled by an OR of the two options.

Jim Houston - Concurrent Computer Corp.

