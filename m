Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262781AbVD2Ot7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262781AbVD2Ot7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 10:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262756AbVD2OtB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 10:49:01 -0400
Received: from cantor2.suse.de ([195.135.220.15]:13021 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262771AbVD2Oqf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 10:46:35 -0400
Date: Fri, 29 Apr 2005 16:46:32 +0200
From: Andi Kleen <ak@suse.de>
To: Alexander Nyberg <alexn@telia.com>
Cc: Andi Kleen <ak@suse.de>, Ruben Puettmann <ruben@puettmann.net>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, rddunlap@osdl.org
Subject: Re: 2.6.11.7 kernel panic on boot on AMD64
Message-ID: <20050429144632.GI21080@wotan.suse.de>
References: <20050427140342.GG10685@puettmann.net> <1114769162.874.4.camel@localhost.localdomain> <20050429143215.GE21080@wotan.suse.de> <1114785867.497.29.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1114785867.497.29.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2005 at 04:44:27PM +0200, Alexander Nyberg wrote:
> > Hmm? saved_command_Line should have enough space to add a simple string.
> > It is a 1024bytes. Unless you already have a 1k command line it should
> > be quite ok.
> 
> init/main.c:
> char saved_command_line[COMMAND_LINE_SIZE];
> 
> inclide/asm-x86-64/setup.h:
> #define COMMAND_LINE_SIZE	256
> 
> Rubens command line is a total of 251 chars, adding "console=tty0" will
> exceed it.

Ok that makes sense. I missed the fact that the original report
had such a overlong command line.

> 
> > Why do you think it is bogus?
> > 
> 
> I thought that saved_command_line on x64 was like the other archs, an
> untouched copy and it wouldn't have made sense to apply another string
> to it then, but I was wrong as it is the working line.
> 
> I still don't understand why console=tty0 is to be appended however.

It was needed in some 2.5 kernel when the console subsystem was 
very broken and I got tired of debugging it and just added this
easy workaround. Probably should have taken it out later, but
then these things tend to stick around.

-Andi
