Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261414AbVFUGK7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261414AbVFUGK7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 02:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261502AbVFUGIB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 02:08:01 -0400
Received: from imf18aec.mail.bellsouth.net ([205.152.59.66]:46217 "EHLO
	imf18aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S261414AbVFUGHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 02:07:18 -0400
Message-ID: <004001c5762e$d67ff390$2800000a@pc365dualp2>
From: <cutaway@bellsouth.net>
To: "Jesper Juhl" <juhl-lkml@dif.dk>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Cc: "Andrew Morton" <akpm@osdl.org>, "Jeff Garzik" <jgarzik@pobox.com>,
       "Domen Puncer" <domen@coderock.org>
References: <Pine.LNX.4.62.0506200052320.2415@dragon.hyggekrogen.localhost>
Subject: Re: [RFC] cleanup patches for strings
Date: Tue, 21 Jun 2005 02:58:13 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1478
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1478
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Examine each case individually...

Any code that did a "sizeof(foo)" is [very] likely to give different
results.

Also, if there are several instances of "foo" being passed around as
parameter, you may find the generated code gets somewhat worse if "foo" used
to be a stack based autovar.  On x86, the const[] implementation will always
cause a 5 byte PUSH for a parameter, whereas the autovar pointer
implementation often will be a shorter 3 byte EBP relative push.  With many
instances of 'foo' usage (or used in a loop), you may be better off paying
the price of an autovar init during prolog to get the cheaper parm pushes
later.

----- Original Message ----- 
From: "Jesper Juhl" <juhl-lkml@dif.dk>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Cc: "Andrew Morton" <akpm@osdl.org>; "Jeff Garzik" <jgarzik@pobox.com>;
"Domen Puncer" <domen@coderock.org>
Sent: Monday, June 20, 2005 18:46
Subject: [RFC] cleanup patches for strings
> from the form
> [const] char *foo = "blah";
> to
> [const] char foo[] = "blah";

