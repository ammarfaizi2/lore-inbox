Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262464AbSKMVPa>; Wed, 13 Nov 2002 16:15:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262790AbSKMVPa>; Wed, 13 Nov 2002 16:15:30 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:49578 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262464AbSKMVOm>; Wed, 13 Nov 2002 16:14:42 -0500
Subject: Re: FW: i386 Linux kernel DoS (clarification)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Leif Sawyer <lsawyer@gci.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021113211318.GA1962@vana>
References: <76C6E114FA8@vcnet.vc.cvut.cz>
	<1037221814.12445.126.camel@irongate.swansea.linux.org.uk> 
	<20021113211318.GA1962@vana>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 13 Nov 2002 21:47:07 +0000
Message-Id: <1037224027.12445.154.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-11-13 at 21:13, Petr Vandrovec wrote:
> This fixes it for me. I'll have to look at ia32 manual at home, why I
> must do pushl %eax & popfl, as NT should be already cleared by
> do_debug(). I probably miss something obvious, but I do not think that
> adding these three instructions into lcall7/27 fastpath is acceptable.

I dont think you can avoid it without ceasing to be clever. The problem
is Linus or someone pulled a nifty track so that we do an lcall in and
an iret.

lcall doesnt clear NT
iret when it sees NT is set performs a task switch to the link field in
the current TSS. 


