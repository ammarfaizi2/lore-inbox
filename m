Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285051AbRLLGcf>; Wed, 12 Dec 2001 01:32:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285077AbRLLGc0>; Wed, 12 Dec 2001 01:32:26 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:15117 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S285051AbRLLGcT>;
	Wed, 12 Dec 2001 01:32:19 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: esr@thyrsus.com
Cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: CML2 1.9.6 is available 
In-Reply-To: Your message of "Wed, 12 Dec 2001 00:05:06 CDT."
             <20011212000506.A5099@thyrsus.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 12 Dec 2001 17:32:05 +1100
Message-ID: <15846.1008138725@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Dec 2001 00:05:06 -0500, 
"Eric S. Raymond" <esr@thyrsus.com> wrote:
>Keith Owens <kaos@ocs.com.au>:
>> One niggle, some strings for kuild 2.5 are longer than 30 characters,
>> cml2 restricts the string length in make menuconfig.  Only menuconfig
>> has this restriction, not oldconfig nor xconfig.  Can the limit be
>> removed, or at least changed to $ROWS-n which would adjust to screen
>> size?
>
>The only place I see a limit of 30 is in the query_popup function used
>for querying for things like search strings, symbol names in the go-to
>command, etc. in menuconfig.
>
>The answer is: maybe.  The underlying problem here is that the prompt
>string and the string editing area both eat screen width.  30 is about
>the largest limit that doesn't blow up the configurator when combined
>with the longest prompt strings.

This works for me.

--- cml2-1.9.6/cmlconfigure.py	Sun Dec  9 19:27:31 2001
+++ 2.4.16-kbuild-2.5/scripts/cmlconfigure.py	Wed Dec 12 17:23:01 2001
@@ -1009,7 +1009,7 @@
 
     def query_popup(self, prompt, initval=None):
         "Pop up a window to accept a string."
-        maxsymwidth = 30	# Constant
+        maxsymwidth = self.columns - len(prompt) - 2
         if initval and len(initval) > maxsymwidth:
             self.help_popup("PRESSANY", (lang["TOOLONG"],), beep=1) 
             return initval

Warning, that is my first bit of Python code (Oh no, now I'm
contaminated too :-).

