Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265060AbSJRIbS>; Fri, 18 Oct 2002 04:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265063AbSJRIbS>; Fri, 18 Oct 2002 04:31:18 -0400
Received: from pizda.ninka.net ([216.101.162.242]:50884 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265060AbSJRIbR>;
	Fri, 18 Oct 2002 04:31:17 -0400
Date: Fri, 18 Oct 2002 01:29:38 -0700 (PDT)
Message-Id: <20021018.012938.52887285.davem@redhat.com>
To: crispin@wirex.com
Cc: hch@infradead.org, greg@kroah.com, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [PATCH] remove sys_security
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3DAFC6E7.9000302@wirex.com>
References: <3DAFB260.5000206@wirex.com>
	<20021018.000738.05626464.davem@redhat.com>
	<3DAFC6E7.9000302@wirex.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Crispin Cowan <crispin@wirex.com>
   Date: Fri, 18 Oct 2002 01:31:35 -0700

   Could you elaborate on why this is a sign of trouble, design wise?
   
Bacause if you can't even specify the data types, something
is severely wrong.  It's entirely a black box.

That doesn't give it system call status.

Compare:

	read(fd, buf, size)

	This reads, from file descriptor FD, into BUF of
	size SIZE.

with:

	security(id, call, args)

	???

How would you describe this in a manpage, for example?

   >There is simply no way we can enfore proper portable typing by
   >all these security module authors such that we can do any kind
   >of proper 32-bit/64-bit syscall translation on the ports that
   >need to do this.

   THAT I would love to hear about. If all we have to do to save 
   sys_security is change its signature, that'd be great.

Well for one thing a pointer to opaque stuff can't be translated
properly.  You MUST KNOW THE DATA TYPES that are being passed 
into the system call to translate it properly.

Your system call, BY DESIGN, makes the data types opaque and
indeterminable.

You can only fix this by contradicting yourself. :-)
   
   Yes, that will be wonderful. And the LSM team will be pleased to re-work 
   the desing when stackable file systems appear and we can take advantage 
   of them.
   
So we should just stick your crap in now right?  No, that is not how
things work.
