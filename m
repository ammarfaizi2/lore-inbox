Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281448AbRKUGrs>; Wed, 21 Nov 2001 01:47:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281467AbRKUGri>; Wed, 21 Nov 2001 01:47:38 -0500
Received: from pizda.ninka.net ([216.101.162.242]:5008 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S281448AbRKUGr0>;
	Wed, 21 Nov 2001 01:47:26 -0500
Date: Tue, 20 Nov 2001 22:47:23 -0800 (PST)
Message-Id: <20011120.224723.35806752.davem@redhat.com>
To: jmerkey@vger.timpanogas.org
Cc: linux-kernel@vger.kernel.org, jmerkey@timpanogas.org
Subject: Re: [VM/MEMORY-SICKNESS] 2.4.15-pre7 kmem_cache_create invalid
 opcode
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011121003304.A683@vger.timpanogas.org>
In-Reply-To: <20011121001639.A813@vger.timpanogas.org>
	<20011120.222203.58448986.davem@redhat.com>
	<20011121003304.A683@vger.timpanogas.org>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
   Date: Wed, 21 Nov 2001 00:33:04 -0700
   
   No. I think the build in linux is broken.  The Linux tree should 
   not generate garbase opcodes from the includes is make dep 
   has not been run and someone is simply building a module against
   the include files.

It executes a bogus opcode because that is how we signal
an assertion failure, see the BUG() macro define in
include/asm-i386/page.h

If it only fails as a module, then most likely (as I stated in my
original mail, which you decided not to read) you are trying to create
a SLAB cache of the same name twice and it is giving you an OOPS to
let you know about it.

On module unload you have to kmem_cache_destroy or else you'll
hit this assertion failure the next time you load the module.

If you aren't going to look at the things I've asked you to look at to
try and determine the problem, and will merely complain about the
"garbage opcodes" without looking at what put those opcodes there in
the kernel image, then your problem is one that I cannot solve.

I said: "A BUG() assertion is being triggered in slab.c"
You retort: "Nothing should make garbage opcodes execute."

I am now saying: "Go look at the BUG() definition, it is a garbage
opcode and it is on purpose".

Are you now going to say: "Linux is still broken, nothing should make
garbage opcodes, the build in Linux is broken"

???

You are really a fucking pain in the ass to help Jeff.
