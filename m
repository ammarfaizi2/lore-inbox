Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262773AbVD2Osi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262773AbVD2Osi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 10:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262774AbVD2OqW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 10:46:22 -0400
Received: from mail.suse.de ([195.135.220.2]:34528 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262771AbVD2OpD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 10:45:03 -0400
Date: Fri, 29 Apr 2005 16:45:01 +0200
From: Andi Kleen <ak@suse.de>
To: Ruben Puettmann <ruben@puettmann.net>
Cc: Andi Kleen <ak@suse.de>, Alexander Nyberg <alexn@telia.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, rddunlap@osdl.org
Subject: Re: 2.6.11.7 kernel panic on boot on AMD64
Message-ID: <20050429144501.GH21080@wotan.suse.de>
References: <20050427140342.GG10685@puettmann.net> <1114769162.874.4.camel@localhost.localdomain> <20050429143215.GE21080@wotan.suse.de> <20050429144103.GK18972@puettmann.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050429144103.GK18972@puettmann.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2005 at 04:41:04PM +0200, Ruben Puettmann wrote:
> On Fri, Apr 29, 2005 at 04:32:15PM +0200, Andi Kleen wrote:
> > 
> > Hmm? saved_command_Line should have enough space to add a simple string.
> > It is a 1024bytes. Unless you already have a 1k command line it should
> > be quite ok.
> 
> Here it seems that it is 256 bytes :
> 
> init/main.c:char saved_command_line[COMMAND_LINE_SIZE];
> 
> include/asm-x86_64/setup.h:#define COMMAND_LINE_SIZE    256

Yes, only the early buffer is 1K.

> 
>  
> > Why do you think it is bogus?
> > 
> > > This is bogus appending stuff to the saved_command_line and at the same
> > > time in Rubens case it touches the late_time_init() which breakes havoc.
> > 
> > I dont agree with this patch.
> > 
> 
> The patch workes here fine. After apply the Server boots without any
> problem.

Ok. If you really had such a overlong command line it is ok.

We should probably check this condition better too and error out.


-Andi
> 
> 
>                         Ruben
> 
> -- 
> Ruben Puettmann
> ruben@puettmann.net
> http://www.puettmann.net
