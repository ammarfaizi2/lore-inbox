Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269646AbRHaWpw>; Fri, 31 Aug 2001 18:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269673AbRHaWpn>; Fri, 31 Aug 2001 18:45:43 -0400
Received: from pizda.ninka.net ([216.101.162.242]:45190 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S269651AbRHaWph>;
	Fri, 31 Aug 2001 18:45:37 -0400
Date: Fri, 31 Aug 2001 15:45:50 -0700 (PDT)
Message-Id: <20010831.154550.70219421.davem@redhat.com>
To: paulus@samba.org
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, davidm@hpl.hp.com
Subject: Re: [PATCH] avoid unnecessary cache flushes
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <15247.29338.3671.548678@cargo.ozlabs.ibm.com>
In-Reply-To: <15247.29338.3671.548678@cargo.ozlabs.ibm.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Paul Mackerras <paulus@samba.org>
   Date: Fri, 31 Aug 2001 21:18:50 +1000 (EST)
   
   Any comments from the architecture maintainers?  Linus, does this look
   OK to apply to your tree?

No comments other than it will silently break sparc64 as you've
updated the declarations in the asm-sparc64 headers but failed to
fixup the assembler routine itself to expect the page * arg.

I would suggest instead to change the name of the assembler
routine to __copy_user_page et al. and make copy_user_page just
an inline or define which plucks out page->address and passes
that onto __copy_user_page.  This way you require no knowledge
of Sparc assembly whatsoever.

Later,
David S. Miller
davem@redhat.com
