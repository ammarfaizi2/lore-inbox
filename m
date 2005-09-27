Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965032AbVI0Rza@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965032AbVI0Rza (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 13:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965033AbVI0Rza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 13:55:30 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:2204 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965032AbVI0Rz3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 13:55:29 -0400
Date: Tue, 27 Sep 2005 18:55:26 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Hirokazu Takata <takata@linux-m32r.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, sam@ravnborg.org
Subject: Re: [PATCH] m32r: set CHECKFLAGS properly
Message-ID: <20050927175526.GU7992@ftp.linux.org.uk>
References: <E1EJlNM-00059K-R8@ZenIV.linux.org.uk> <20050927.151301.189720995.takata.hirokazu@renesas.com> <20050927071025.GS7992@ftp.linux.org.uk> <CFD86C0A-0BE4-4D39-BAAE-F985D997AFD2@mac.com> <20050927163455.GT7992@ftp.linux.org.uk> <44F9E519-C94E-422B-9CA7-B24C2F76B78D@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44F9E519-C94E-422B-9CA7-B24C2F76B78D@mac.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2005 at 01:31:25PM -0400, Kyle Moffett wrote:
> >    3) way, way, *WAY* too much spew.  gcc pre-defines shitloads of  
> >stuff and some of that stuff very definitely should not be there  
> >for sparse.
> 
> Why not?  Some of that stuff may get used in kernel headers, which  
> sparse should definitely have defined.  Besides, sparse is designed  
> to check C source code, which will be compiled with said GCC using  
> those preprocessing defines.  Why should it use a different set of  
> defines?

First of all, some of that stuff should not be used in kernel headers
and getting a warning about such uses is a Good Thing(tm).  What's
more, some are actively *wrong* for kernel - __STDC_HOSTED__, for one,
is simply a lie.  And no, sparse (or any other C compiler) is not
required to have the same pile as gcc does.

There's another reason why limited subset is good - it documents the
subset we are using.  And having to reach gcc source just to figure
out which architectures might have given symbol...  No, thanks.
