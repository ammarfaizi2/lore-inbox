Return-Path: <linux-kernel-owner+w=401wt.eu-S933210AbWLaUTM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933210AbWLaUTM (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 15:19:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933211AbWLaUTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 15:19:11 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:38915 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933210AbWLaUTK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 15:19:10 -0500
X-Originating-Ip: 74.109.98.100
Date: Sun, 31 Dec 2006 15:13:59 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Muli Ben-Yehuda <muli@il.ibm.com>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Randy Dunlap <randy.dunlap@oracle.com>, trivial@kernel.org
Subject: Re: [PATCH] Documentation: Explain a second alternative for multi-line
 macros.
In-Reply-To: <20061231200903.GF3730@rhun.ibm.com>
Message-ID: <Pine.LNX.4.64.0612311513070.18796@localhost.localdomain>
References: <Pine.LNX.4.64.0612311430370.18269@localhost.localdomain>
 <20061231194501.GE3730@rhun.ibm.com> <Pine.LNX.4.64.0612311447030.18368@localhost.localdomain>
 <20061231200903.GF3730@rhun.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 Dec 2006, Muli Ben-Yehuda wrote:

> On Sun, Dec 31, 2006 at 02:49:48PM -0500, Robert P. J. Day wrote:
>
> > there would appear to be *lots* of cases where the ({ }) notation
> > is used when nothing is being returned.  i'm not sure you can be
> > that adamant about that distinction at this point.
>
> IMHO, the main point of CodingStyle is to clarify how new code
> should be written and old code should've been written.

ok, how about this as a patch:

diff --git a/Documentation/CodingStyle b/Documentation/CodingStyle
index 9069189..064a13e 100644
--- a/Documentation/CodingStyle
+++ b/Documentation/CodingStyle
@@ -549,13 +549,26 @@ may be named in lower case.

 Generally, inline functions are preferable to macros resembling functions.

-Macros with multiple statements should be enclosed in a do - while block:
-
-#define macrofun(a, b, c) 			\
-	do {					\
-		if (a == 5)			\
-			do_this(b, c);		\
-	} while (0)
+There are two techniques for defining macros that contain multiple
+statements, depending on whether you're returning a value or not:
+
+ (a) If there is no return value from the macro, you should enclose
+     the statements in a do - while block, as in:
+
+	#define macrofun(a, b, c) 		\
+		do {				\
+			if (a == 5)		\
+				do_this(b, c);	\
+		} while (0)
+
+ (b) If the macro is designed to return a value, you should use the
+     gcc extension that a compound statement enclosed in parentheses
+     represents an expression, as in:
+
+	#define maxint(a, b) ({			\
+		int _a = (a), _b = (b);		\
+		_a > _b ? _a : _b;		\
+	})

 Things to avoid when using macros:

