Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262125AbVANUG3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262125AbVANUG3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 15:06:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262126AbVANUG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 15:06:28 -0500
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:22172 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262125AbVANUGB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 15:06:01 -0500
From: Blaisorblade <blaisorblade@yahoo.it>
To: Jeff Dike <jdike@addtoit.com>
Subject: Re: [patch 04/11] uml: refuse to run without skas if no tt mode in
Date: Fri, 14 Jan 2005 21:08:25 +0100
User-Agent: KMail/1.7.1
Cc: blaisorblade_spam@yahoo.it, akpm@osdl.org, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
References: <20050113210056.465BEBAB5@zion> <200501141924.j0EJONnV003234@ccure.user-mode-linux.org>
In-Reply-To: <200501141924.j0EJONnV003234@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501142108.25724.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 14 January 2005 20:24, Jeff Dike wrote:
> Is it my imagination, or did you put the definition of can_do_skas under
> #ifdef UML_CONFIG_MODE_SKAS and failed to do the same for the call?

Look at the end:

 #else
+int can_do_skas(void)
+{
        return(0);
-#endif
 }
+#endif

This dummy call could be inlined / moved, anyway this is not performance 
critical - it's anyway nicer to have such null defines in headers. I'll clean 
it up.

While checking your statement, I also discovered that here:

int mode_tt = DEFAULT_TT;
(where DEFAULT_TT is a macro depending on CONFIG options, which is always 0 
except if SKAS mode is disabled)

is ignored, because of the subsequent:

        mode_tt = force_tt ? 1 : !can_do_skas();

So we can probably get rid of DEFAULT_TT. I'll do this in the future.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade
