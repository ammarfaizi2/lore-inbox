Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261218AbUKNEnr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261218AbUKNEnr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 23:43:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbUKNEnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 23:43:47 -0500
Received: from fw.osdl.org ([65.172.181.6]:45508 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261218AbUKNEnp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 23:43:45 -0500
Date: Sat, 13 Nov 2004 20:43:34 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Matt Domsch <Matt_Domsch@dell.com>
cc: Christian Kujau <evil@g-house.de>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Oops in 2.6.10-rc1 (almost solved)
In-Reply-To: <20041114025814.GA20342@lists.us.dell.com>
Message-ID: <Pine.LNX.4.58.0411132040330.12386@ppc970.osdl.org>
References: <200411122248_MC3-1-8E97-BFE5@compuserve.com>
 <20041113142835.GA9109@lists.us.dell.com> <20041114025814.GA20342@lists.us.dell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 13 Nov 2004, Matt Domsch wrote:
> 
> Not ready for Linus yet

Indeed. Please don't use pushfl/popfl to save the carry flag. There are 
tons of better ways.

For example, use "lea" instead of "add" to not write the flags (and add a 
comment). Or save the carry flag in a register with

	sbb %bx,%bx

ant test %bx later. Or any of a million other _standard_ ways to handle
this problem.

		Linus
