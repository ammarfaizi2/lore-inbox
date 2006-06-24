Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750777AbWFXBhZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbWFXBhZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 21:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbWFXBhZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 21:37:25 -0400
Received: from nz-out-0102.google.com ([64.233.162.203]:28549 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750777AbWFXBhZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 21:37:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=XTW+jnBWBZSvLq2rh2oOrRMEZEt3FnEGUrcUOmt5G30OKbZSH5OprT4LBeUOjYfI8GdDu8hmYAsz+reugxbTZhoSDrQLidwmUEwRdNFqePxaUaG3cNBe91vmOqH2V9+cYILEWWKutYN/ES7N042QAhfrGaugIFDyiFXofuhGYo8=
Message-ID: <787b0d920606231837k5d57da8ct5c511def6c035176@mail.gmail.com>
Date: Fri, 23 Jun 2006 21:37:24 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: linux-kernel@vger.kernel.org, "Linus Torvalds" <torvalds@osdl.org>,
       76306.1226@compuserve.com, ak@muc.de, akpm@osdl.org
Subject: i386 ABI and the stack
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just saw git commit 21528454f6dd18231ae20102f98aa8f51b6ec1b9
go in with this:

+ * Accessing the stack below %esp is always a bug.
+ * The large cushion allows instructions like enter
+ * and pusha to work. ("enter $65535,$31" pushes
+ * 32 pointers and then decrements %esp by 65535.)

Exactly how is an access below %esp a bug if we just added support?
It looks like we now have a 65664-byte red zone on i386, and probably
on x86-64 once the matching patch goes in. (the space reserved by
signal handlers may differ, though perhaps it should not)

This is water under the bridge anyway, because of gcc 2.xx.x bugs.

It seems that we're throwing away performance if we discourage
the compiler from taking advantage of this area to optimize
leaf functions and perhaps improve instruction scheduling.
