Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130458AbQK0KeA>; Mon, 27 Nov 2000 05:34:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130657AbQK0Kdu>; Mon, 27 Nov 2000 05:33:50 -0500
Received: from moon.mt.lv ([159.148.147.194]:23824 "EHLO moon.mt.lv")
        by vger.kernel.org with ESMTP id <S130458AbQK0Kdd>;
        Mon, 27 Nov 2000 05:33:33 -0500
Message-ID: <0c9101c05859$4b4c0220$2000000a@dev.mt.lv>
From: "Raivis Bucis" <raivis@mt.lv>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <20001125003600.A28207@vger.timpanogas.org> <3A1F6EB6.A5E47686@pobox.com> <20001125121049.A29510@vger.timpanogas.org>
Subject: Re: setting up pppd dial-in on linux
Date: Mon, 27 Nov 2000 12:00:52 +0200
MIME-Version: 1.0
Content-Type: multipart/mixed;
        boundary="----=_NextPart_000_0C86_01C05869.B0D7D8C0"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0C86_01C05869.B0D7D8C0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Sent: Saturday, November 25, 2000 9:10 PM


: On Fri, Nov 24, 2000 at 11:48:06PM -0800, J Sloan wrote:
: > "Jeff V. Merkey" wrote:
: >
: > > Anyone out there a whiz at setting up a pppd dialin server?  I am
: > > trying to put together an RPM for pppd dialin configurations
: > > that will support default Windows NT and Linux dial in clients
: > > without requiring the poor user to learn bash scripting, chat
: > > scripting, mgetty and inittab configuration, etc.  The steps
: > > in setting this up are about as easy as going on a U.N. relief
: > > mission to equatorial Africa, and most customers who are
: > > "mere mortals" would give up about an hour into it.
: >
: > Red Hat's ppp client setup is about a 90 second job
:
: I am using theirs as a base.   Setup's not the issue.  It's the
: chap MD5 authentication for NT clients and the constant
: crashing that's troublesome.  I have it working, just not
: with NT clients.

Probably this little patch will help you. I had similar problems with
Windows 95 and encryption
enabled.

Raivis

------=_NextPart_000_0C86_01C05869.B0D7D8C0
Content-Type: application/octet-stream;
	name="ppp.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ppp.patch"

diff -uNr ppp-2.3.11.orig/pppd/lcp.c ppp-2.3.11/pppd/lcp.c
--- ppp-2.3.11.orig/pppd/lcp.c	Tue Jul 18 14:13:14 2000
+++ ppp-2.3.11/pppd/lcp.c	Mon Nov 27 11:55:34 2000
@@ -1074,6 +1074,7 @@
 	GETCHAR(cilen, p);
 	if (cilen < CILEN_VOID || (len -= cilen) < 0)
 	    goto bad;
+	if (cilen < 2) break;
 	next = p + cilen - 2;
 
 	switch (citype) {

------=_NextPart_000_0C86_01C05869.B0D7D8C0--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
