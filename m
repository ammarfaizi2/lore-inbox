Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262337AbSJGB4E>; Sun, 6 Oct 2002 21:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262342AbSJGB4E>; Sun, 6 Oct 2002 21:56:04 -0400
Received: from blowme.phunnypharm.org ([65.207.35.140]:63494 "EHLO
	blowme.phunnypharm.org") by vger.kernel.org with ESMTP
	id <S262337AbSJGB4E>; Sun, 6 Oct 2002 21:56:04 -0400
Date: Sun, 6 Oct 2002 22:01:39 -0400
From: Ben Collins <bcollins@debian.org>
To: Nicolas Pitre <nico@cam.org>, Ulrich Drepper <drepper@redhat.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: New BK License Problem?
Message-ID: <20021007020139.GY566@phunnypharm.org>
References: <3D9F3C5C.1050708@redhat.com> <Pine.LNX.4.44.0210051533310.5197-100000@xanadu.home> <20021005125412.E11375@work.bitmover.com> <20021005125624.F11375@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021005125624.F11375@work.bitmover.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Whoops, forgot one thing.  Take the GNU CSSC sources, they look for
> 
> 	^Ah%05u\n

Here's a patch for those interested

diff -urN CSSC-0.14alpha.pl0.orig/sccsfile.cc CSSC-0.14alpha.pl0/sccsfile.cc
--- CSSC-0.14alpha.pl0.orig/sccsfile.cc	2002-03-24 19:07:09.000000000 -0500
+++ CSSC-0.14alpha.pl0/sccsfile.cc	2002-10-06 21:52:12.000000000 -0400
@@ -73,13 +73,17 @@
       return NULL;
     }
   
-  if (getc(f_local) != '\001' || getc(f_local) != 'h')
+  if (getc(f_local) != '\001')
     {
-      (void)fclose(f_local);
-      s_corrupt_quit("%s: No SCCS-file magic number.  "
-		     "Did you specify the right file?", name);
-      /*NOTEACHED*/
-      return NULL;
+      int tmp_c = getc(f_local);
+      if (tmp_c != 'h' && tmp_c != 'H')
+        {
+	  (void)fclose(f_local);
+	  s_corrupt_quit("%s: No SCCS-file magic number.  "
+			 "Did you specify the right file?", name);
+	  /*NOTEACHED*/
+	  return NULL;
+	}
     }
   
   
@@ -532,7 +536,7 @@
     }
   
   int c = read_line();
-  ASSERT(c == 'h');
+  ASSERT(c == 'h' || c == 'H');
 
   /* the checksum is represented in the file as decimal.
    */
