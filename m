Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291551AbSBAFMX>; Fri, 1 Feb 2002 00:12:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291548AbSBAFMM>; Fri, 1 Feb 2002 00:12:12 -0500
Received: from rj.sgi.com ([204.94.215.100]:13471 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S291546AbSBAFK3>;
	Fri, 1 Feb 2002 00:10:29 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "David S. Miller" <davem@redhat.com>
Cc: garzik@havoc.gtf.org, alan@lxorguk.ukuu.org.uk, vandrove@vc.cvut.cz,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org, paulus@samba.org,
        davidm@hpl.hp.com, ralf@gnu.org
Subject: Re: [PATCH] Re: crc32 and lib.a (was Re: [PATCH] nbd in 2.5.3 does 
In-Reply-To: Your message of "Thu, 31 Jan 2002 20:25:09 -0800."
             <20020131.202509.78710127.davem@redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 01 Feb 2002 16:10:13 +1100
Message-ID: <26189.1012540213@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jan 2002 20:25:09 -0800 (PST), 
"David S. Miller" <davem@redhat.com> wrote:
>It would be really great if, some day, you just add your source
>file(s) to drivers/net and that is the only thing you ever touch.  You
>DO NOT touch Makefiles, you DO NOT touch Config.in files, you DO NOT
>add Config.help entries.
>...
>I have this feeling Keith Owens is going to scream "the new build
>system DOES EXACTLY THAT!"  If so, that's fscking great. :-)

Close but not quite.  I would love to do exactly that and remove all
the monolithic files like Configure.*, Config.in and Makefile.  But I
can't.

The only thing stopping me writing a simple "install this source and
the kernel detects it" model is initialization order, module_init ->
.text.init.  The initialization order is controlled by the order of
entries in Makefiles and subdirs entries between Makefiles.  That
sucks, as the recent problems with crc32.o have shown.

Two years ago I suggested breaking the implicit nexus between Makefile
order and initialization order, by adding new directives to explicitly
define initialization order - where required.  For example, group
memory must initialize before group network, within group network
driver ne2000 must initialize before driver eepro100.

As long as Makefiles control initialization order, you need monolithic
Makefiles.  Adding another layer to say which order the make entries
for each source are to be combined just compounds the problem.  Let me
separate the initialization order from Makefiles and I will happily
give you "add a source and kbuild autobuilds it" model.

Why can't I do it?  Linus wants the current method, where monolithic
Makefiles control initialization order.
http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg10645.html

