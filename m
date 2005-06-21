Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261315AbVFUNsn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261315AbVFUNsn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 09:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261448AbVFUNsm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 09:48:42 -0400
Received: from imf16aec.mail.bellsouth.net ([205.152.59.64]:29929 "EHLO
	imf16aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S261420AbVFUNpi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 09:45:38 -0400
Message-ID: <01ff01c5766e$de750be0$2800000a@pc365dualp2>
From: <cutaway@bellsouth.net>
To: "Denis Vlasenko" <vda@ilport.com.ua>, "Jesper Juhl" <juhl-lkml@dif.dk>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Cc: "Andrew Morton" <akpm@osdl.org>, "Jeff Garzik" <jgarzik@pobox.com>,
       "Domen Puncer" <domen@coderock.org>
References: <Pine.LNX.4.62.0506200052320.2415@dragon.hyggekrogen.localhost> <200506211402.48554.vda@ilport.com.ua> <004c01c57662$5eacc260$2800000a@pc365dualp2> <200506211606.59233.vda@ilport.com.ua>
Subject: Re: [RFC] cleanup patches for strings
Date: Tue, 21 Jun 2005 10:38:12 -0400
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

Congratulations, you proved that a register push is faster than a 3 byte
memory push.  I believe this is exactly what I said would happen if the
autovar pointer wound up being enregistered.

However, it is NOT what GCC will generate for pushing params to static
strings.

For that you're going to get a 5 byte PUSH imm32.


----- Original Message ----- 
From: "Denis Vlasenko" <vda@ilport.com.ua>
To: <cutaway@bellsouth.net>; "Jesper Juhl" <juhl-lkml@dif.dk>;
"linux-kernel" <linux-kernel@vger.kernel.org>
Cc: "Andrew Morton" <akpm@osdl.org>; "Jeff Garzik" <jgarzik@pobox.com>;
"Domen Puncer" <domen@coderock.org>
Sent: Tuesday, June 21, 2005 09:06
Subject: Re: [RFC] cleanup patches for strings

Took 9574 CPU cycles Took 8068 CPU cycles


>   40:   ff 75 f8                pushl  0xfffffff8(%ebp)
>   43:   58                      pop    %eax


>   80:   53                      push   %ebx
>   81:   58                      pop    %eax

