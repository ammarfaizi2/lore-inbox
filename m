Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263087AbTEMBWM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 21:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263091AbTEMBWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 21:22:12 -0400
Received: from [218.19.173.37] ([218.19.173.37]:260 "EHLO zhangtao.treble.net")
	by vger.kernel.org with ESMTP id S263087AbTEMBWK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 21:22:10 -0400
Date: Tue, 13 May 2003 09:35:06 +0800
From: zhangtao <zhangtao@zhangtao.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Matti Aarnio <matti.aarnio@zmailer.org>
Cc: LinuxKernel MailList <linux-kernel@vger.kernel.org>
Subject: Re: Which one should I contact about linux-kernel's NLS support
 such as codepage 936?
Message-Id: <20030513093506.03104c9e.zhangtao@zhangtao.org>
In-Reply-To: <1052737621.31246.7.camel@dhcp22.swansea.linux.org.uk>
References: <20030512100534.1ba6ecd6.zhangtao@zhangtao.org>
	<1052737621.31246.7.camel@dhcp22.swansea.linux.org.uk>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 May 2003 12:07:02 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Llu, 2003-05-12 at 03:05, zhangtao wrote:
> > Hi, Everyone,
> > 
> >   I have some patch about kernel's NLS, such as Codepage 936, 932, 949, 950. 
> > 
> >   How can I contact the owner or public my patch ?
> 
> I saw then and while they look ok I've been trying to find someone
> familiar with these code pages to review them
> 
> 
Linux Kernel 2.4.x NLS Patch, This Patch is used to correct problems of translation tables of CP932, CP936, CP949 and CP950.

There are 2 problems:

1. Translation Tables
In the "linux/fs/nls_cp936.c (ncl_cp932.c, nls_cp949.c and nls_cp950.c)", the translation tables were downloaded from
    http://www.microsoft.com/typography/unicode/unicodecp.htm,
but the page was not found. The new Codepage is located at:
    http://www.microsoft.com/globaldev/reference/cphome.mspx.

After examination the old one and new one, can find much more different,
e.g., 0x8179 in the CP936 should be corresponding with 0x4E82 in Unicode,
NOT 0xF91B. So, need rebuid the C program.

2. Area between 0x80 and 0xFF in the Unicode 
The area between 0x80 and 0xFF in the Unicode, is not be corresponding with CP932, CP936, CP949 and CP950: part of this can have corresponding letters,
others not have. The old uni2char() function is not correct for dealing with this area, because it let 0x80-0xFF keep the same, but it's not true.

e.g., the Unicode letter 0x00A4 should be corresponding with 0xA1E8 of the Codepage 936, not keep itself.



