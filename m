Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312983AbSEULlE>; Tue, 21 May 2002 07:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312998AbSEULlD>; Tue, 21 May 2002 07:41:03 -0400
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:2572 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S312983AbSEULlC>; Tue, 21 May 2002 07:41:02 -0400
Date: Tue, 21 May 2002 12:40:57 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Subject: 1GB piggys
Message-ID: <20020521124057.A2286@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm getting reports of some people ending up with 1GB piggy objects for
gzip to compress on ARM.  While investigating this, I found the following:

00003dd4 ? __module_kernel_version
00003df4 ? __module_parm_minor
00003e04 ? __module_parm_flash_base
00003e18 ? __module_parm_flash_size
40004000 A swapper_pg_dir
40008000 ? __init_begin
40008000 ? _stext
40008000 ? stext

The __module_* stuff is from the .modinfo section of some kernel object.

Since .modinfo isn't actually used or indeed placed in the linker
script, shouldn't we be explicitly discarding it like the
.exitcall.exit, .text.exit and .data.exit sections, rather than
letting the linker apparantly pick some random memory location to
dump this section?

(Yes, its probably buggy for the linker not to moan about unrecognised
input sections...)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

