Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261643AbTCNKCv>; Fri, 14 Mar 2003 05:02:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261676AbTCNKCv>; Fri, 14 Mar 2003 05:02:51 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:13067 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S261643AbTCNKCu>; Fri, 14 Mar 2003 05:02:50 -0500
Message-ID: <3E71ABC7.90500@aitel.hist.no>
Date: Fri, 14 Mar 2003 11:15:35 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: Kendall Bennett <KendallB@scitechsoft.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: VESA FBconsole driver?
References: <3E70A68F.1935.AF1549@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kendall Bennett wrote:


 > Why is it ugly? IMHO it is very much needed, as it would provide a
 > mechanism for the kernel to be able to properly restore the screen
 > if a user land program goes astray.

First - the bios isn't always able to fix the screen - the program may
have programmed the video hardware in odd ways the bios don't know 
about.  Bioses aren't a magic fix.

Second, the proper way to do this is for the video driver to fix it up,
using more efficient code that runs under linux without special 
consideration because it was written for that case.

> More tricks like what? All we need is the ability to call the BIOS and 
> have it execute the necessary real mode code, just like we do on ia32 
> machines in user land.

Ability to call the bios in real mode is no simple feat. And the bios
may screw up.  That doesn't matter for a user program, it just crashes
and don't damage anything else.  You don't want the kernel to crash - 
ever.  A broken bios is _no_ excuse here.

Bioses are generally too limited.  They make a lot of stupid 
assumptions, thinking it is ok to use legacy vga registers and things 
like that. Consider a machine with two or more video cards.  Linux 
handles that fine, but a bios? Or really two bioses, one for each card?
Imagine a dual processor where one one processor executes one bios and 
the other processor another bios , each trying to set up one card. 
Somehow I think this won't work too well.

As for userspace tricks - userspace can do all sorts of nifty things 
like actually open a file and read it.  For example a file
with the latest list of bios oddities to work around.

Helge Hafting

