Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315245AbSGQPwl>; Wed, 17 Jul 2002 11:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315265AbSGQPwl>; Wed, 17 Jul 2002 11:52:41 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44558 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315245AbSGQPwk>;
	Wed, 17 Jul 2002 11:52:40 -0400
Date: Wed, 17 Jul 2002 16:55:38 +0100
From: Matthew Wilcox <willy@debian.org>
To: linux-kernel@vger.kernel.org
Subject: 2.5.26 broken on headless boxes
Message-ID: <20020717165538.D13352@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On a headless box with both CONFIG_VT_CONSOLE and CONFIG_SERIAL_CONSOLE
defined, I get:

Freeing unused kernel memory: 452k freed
visual_init: sw = 00000000, conswitchp = 00000000, currcons = 0, init = 1
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c01b775f
*pde = 37868001
*pte = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01b775f>]    Not tainted
EFLAGS: 00010286
eax: 00000000   ebx: c03dc9a0   ecx: 00000001   edx: c02f2cb0
esi: 00000000   edi: 00000000   ebp: 00000000   esp: c3d45e9c
ds: 0018   es: 0018   ss: 0018
Process init (pid: 1, threadinfo=c3d44000 task=c3d4f300)
Stack: 00000000 f784a000 00000000 f78518f0 f7907600 c01baa05 00000000 00000000 
       00000001 c01ac03c f784a000 f7871da0 c3d44000 f7871da0 00000000 f78518f0 
       f786da20 01021e80 f784a000 f7910160 c0145a93 f786da20 c3d45f80 f7a06000 
Call Trace: [<c01baa05>] [<c01ac03c>] [<c0145a93>] [<c0144ee7>] [<c0146383>] 
   [<c013c34a>] [<c013b011>] [<c013af26>] [<c013b317>] [<c0108893>] 

Code: 83 38 00 75 09 57 e8 36 ed ff ff 83 c4 04 8b 86 00 cc 3d c0 
 <0>Kernel panic: Attempted to kill init!

I put an `if (!sw) return;' in visual_init and the panic persists, so
it's not entirely obvious to me what's going on.  Someone more intimate
with the console system want to comment?

-- 
Revolutions do not require corporate support.
