Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265532AbUABNI5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 08:08:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265533AbUABNI5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 08:08:57 -0500
Received: from mail.zmailer.org ([62.78.96.67]:4998 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id S265532AbUABNI4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 08:08:56 -0500
Date: Fri, 2 Jan 2004 15:08:47 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Libor Vanek <libor@conet.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Syscall table AKA hijacking syscalls
Message-ID: <20040102130847.GE2785@mea-ext.zmailer.org>
References: <3FF56B1C.1040308@conet.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FF56B1C.1040308@conet.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 02, 2004 at 01:59:08PM +0100, Libor Vanek wrote:
> Hi,
> I'm writing some project which needs to hijack some syscalls in VFS 
> layer. AFAIK in 2.6 is this "not-wanted" solution (even that there are 
...
> So what is proper (Linus recommanded) way to do such a things? Create 
> patches for specific syscalls like "if this_module_installed then 
> call_this_function;" or try to force things like syscalltrack to go into 
> vanilla kernel some time? Because what I've found out there are more 
> projects which suffer from this restriction.


Maybe:

  int (*funcvec_v1)(args);
  EXPORT_SYMBOL(funcvec_v1);

  ...

  retval =  (funcvec_v1) ? (funcvec_v1)(args..) : func_f1(args...);

or something of that kind.

There is, of course, whole slew of politically coloured
issues with this chainability.


> -- 
> Libor Vanek

/Matti Aarnio
