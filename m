Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161829AbWKJPWo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161829AbWKJPWo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 10:22:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161863AbWKJPWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 10:22:44 -0500
Received: from mcr-smtp-002.bulldogdsl.com ([212.158.248.8]:28172 "EHLO
	mcr-smtp-002.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S1161829AbWKJPWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 10:22:43 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Ludovic Drolez <ludovic.drolez@linbox.com>
Subject: Re: 2.6.18.2: cannot compile with gcc 3.0.4
Date: Fri, 10 Nov 2006 15:22:39 +0000
User-Agent: KMail/1.9.5
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       trivial@kernel.org
References: <45545C1B.4040204@linbox.com> <9a8748490611100328w75ccf2e8uc1121a80e68242d8@mail.gmail.com> <455468D8.7080609@linbox.com>
In-Reply-To: <455468D8.7080609@linbox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611101522.39821.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 November 2006 11:56, Ludovic Drolez wrote:
> Jesper Juhl wrote:
> > If you had bothered to read Documentation/Changes then you would have
> > seen that the current minimal required gcc version is 3.2 :
>
> Ok sorry, I didn't see the change between 2.6.15 and 2.6.16.
> Maybe a test should be added in linux/compiler-gcc3.h, to have the same
> warning as with gcc 2.xx ?

Untested, but something like this should do it.

The kernel doesn't compile with GCC <3.2, do not allow it to succeed if GCC 
3.0.x or 3.1.x are used.

Signed-off-by: Alistair John Strachan <s0348365@sms.ed.ac.uk>

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 538423d..aca6698 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -40,7 +40,7 @@ #if __GNUC__ > 4
 #error no compiler-gcc.h file for this gcc version
 #elif __GNUC__ == 4
 # include <linux/compiler-gcc4.h>
-#elif __GNUC__ == 3
+#elif __GNUC__ == 3 && __GNUC_MINOR__ >= 2
 # include <linux/compiler-gcc3.h>
 #else
 # error Sorry, your compiler is too old/not recognized.

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
