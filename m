Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262502AbVAUUsp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262502AbVAUUsp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 15:48:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262499AbVAUUso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 15:48:44 -0500
Received: from web53808.mail.yahoo.com ([206.190.36.203]:16982 "HELO
	web53808.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262509AbVAUUo3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 15:44:29 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=eYpjtf2C4PooujPaiutD3fog89DV6X0dbxZEm9iS/jfs0zNtMWs63pfBdS3qtP8TRE4cleEMAOjarODLrEfEannoSnuFs1LzwKTP2cQ6C7cJci/uF+5n3irt3vaZrn9sfaYleYgx1qHvyMqmQAU4t6pAgAQ/ZMC/vS5JvlrzdIg=  ;
Message-ID: <20050121204422.85137.qmail@web53808.mail.yahoo.com>
Date: Fri, 21 Jan 2005 12:44:22 -0800 (PST)
From: Carl Spalletta <cspalletta@yahoo.com>
Subject: Linux-tracecalls, a clarification
To: linux-kernel@vger.kernel.org
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>
In-Reply-To: <200501192037.j0JKbpuA008501@laptop11.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://www.linuxrd.com/~carl/cgi-bin/lnxtc.pl?help

--- Horst von Brand <vonbrand@inf.utfsm.cl> wrote:
> Re: [ANNOUNCE] Linux-tracecalls, a new tool for Kernel development, released 
> 
> If it can't find out where a function could be called through a pointer
> (very common due to the OOP-in-C style in the kernel) it has no chance.

Dear Doctor von Brand,

  I believe the following should clear up your misunderstanding, perhaps due
to my poor original choice of words.

Carl Spalletta

PATCH #2
--- lnxtc-2.6.10.pl-    2005-01-21 00:16:33.000000000 -0500
+++ lnxtc-2.6.10.pl     2005-01-21 00:50:11.000000000 -0500
@@ -517,10 +517,22 @@
     $leaf_node = 0;
     $debug and print STDERR "\ncscope line is $full_caller_cscope";

-    #Target is a callback
+    #TARGET IS A PSEUDO-CALLBACK, AN ARTIFACT OF CSCOPE:
+    #
+    #The name of an operations structure member, wrongly interpreted by
+    #cscope as the name of an actual function - it should be ignored,
+    #since it has been confused by cscope with the name of some actual
+    #caller. HOWEVER the callbacks are found anyway, under their actual names.
+    #and if any function pointed to by a callback is part of a chain to
+    #our initial target it _will_ be found, the same as any other caller.
+    #
     if($full_caller_cscope =~ /\w+\s*->\s*${target_filefunc}\s*\(/)
     {
-      $debug and print STDERR "callback $target_filefunc ignored.\n";
+      $debug and
+        print STDERR "pseudo-callback $target_filefunc ignored.\n";
       next;
     }




