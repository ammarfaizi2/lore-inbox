Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261894AbTARCoI>; Fri, 17 Jan 2003 21:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261934AbTARCoH>; Fri, 17 Jan 2003 21:44:07 -0500
Received: from mta7.srv.hcvlny.cv.net ([167.206.5.22]:8548 "EHLO
	mta7.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id <S261894AbTARCoG>; Fri, 17 Jan 2003 21:44:06 -0500
Date: Fri, 17 Jan 2003 21:49:16 -0500
From: Rob Wilkens <robw@optonline.net>
Subject: [PATCH] Trivial Comment Change (Please Verify) (2.5.59)
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-to: robw@optonline.net
Message-id: <1042858155.3800.16.camel@RobsPC.RobertWilkens.com>
Organization: Robert Wilkens
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.1
Content-type: text/plain
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please remember that I'm a newbie.  As such, even though I'm only
changing a comment, an expert should review the change before it goes
through.

I was looking up the definition of kdev_t, and I saw it defined two
entirely different ways (only once for compilation purposes, so no
compile time problems).

In the same file, <include/linux/kdev_t.h>, patched below and I only
patched the comments and did not touch the code, it was defined as (in
the comments):

(1) typedef struct { unsigned short major, minor; } kdev_t;

Which would be a long (two shorts), then actually defined later in the
code as:

(2) typedef struct {
        unsigned short value;
    } kdev_t;


As you can guess, Redefining the comment to be two "chars" instead of
two shorts keeps the meaningful description in the comments (there is a
major # component and a minor # component), but redefining them to be
chars (bytes) rather than shorts reflects more accurately the storage
space allotted by the actual structure (one short, not two).

I figure it's best, when possible, to have the comments match up with
reality.  If someone (like myself just now) is referencing the comments
for guidance with respect to what the data structures look like, they
would have soon discoverred that the data structures looked nothing like
what the comment was describing.

I'd appreciate if someone could get this or a similar patch in, and no,
I don't need to be specially credited for making a comment change :-).

Patch follows.


--- kdev_t.h.orig       2003-01-17 21:25:18.000000000 -0500
+++ kdev_t.h    2003-01-17 21:33:57.000000000 -0500
@@ -31,7 +31,7 @@
  
 However, for the time being we let kdev_t be almost the same as dev_t:
  
-typedef struct { unsigned short major, minor; } kdev_t;
+typedef struct { unsigned char major, minor; } kdev_t;
  
 Admissible operations on an object of type kdev_t:
 - passing it along


