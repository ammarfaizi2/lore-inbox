Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318487AbSHLAOi>; Sun, 11 Aug 2002 20:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318488AbSHLAOi>; Sun, 11 Aug 2002 20:14:38 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:61959 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S318487AbSHLAOi>;
	Sun, 11 Aug 2002 20:14:38 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200208120018.g7C0IFN185157@saturn.cs.uml.edu>
Subject: Re: [patch 6/12] hold atomic kmaps across generic_file_read
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Sun, 11 Aug 2002 20:18:14 -0400 (EDT)
Cc: torvalds@transmeta.com (Linus Torvalds),
       lk@tantalophile.demon.co.uk (Jamie Lokier),
       akpm@zip.com.au (Andrew Morton), linux-kernel@vger.kernel.org (lkml)
In-Reply-To: <3D556101.8080006@mandrakesoft.com> from "Jeff Garzik" at Aug 10, 2002 02:52:49 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik writes:
> Linus Torvalds wrote:

> The overhead of the extra stat and mmap/munmap syscalls seemed to be the 
> thing that slowed things down.  sendfile was pretty fast, but still an 
> extra syscall, with an annoyingly large error handling case [only 
> certain files can be sendfile'd]

That error handling case sure does discourage sendfile use.

> I sure would like an O_STREAMING flag, though...  let a user app hint to 
> the system that the pages it is reading or writing are perhaps less 
> likely to be reused, or access randomly....  A copy-file syscall would 
> be nice, too, but that's just laziness talking....

You have a laptop computer with a USB-connected Ethernet.
You mount a NetApp or similar box via the SMB/CIFS protocol.
You see a multi-gigabyte file. You make a copy... ouch!!!
For each gigabyte, you hog the network for an hour.

Now let's say this file is for a MacOS app. You have to
preserve the creator, file type, resource fork, etc.
