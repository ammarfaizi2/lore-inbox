Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268835AbRHXBmq>; Thu, 23 Aug 2001 21:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270822AbRHXBmh>; Thu, 23 Aug 2001 21:42:37 -0400
Received: from oe50.law9.hotmail.com ([64.4.8.22]:62733 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S268835AbRHXBma>;
	Thu, 23 Aug 2001 21:42:30 -0400
X-Originating-IP: [65.92.117.63]
From: "Camiel Vanderhoeven" <camiel_toronto@hotmail.com>
To: <raybry@timesn.com>, <linux-kernel@vger.kernel.org>
Subject: RE: macro conflict
Date: Thu, 23 Aug 2001 21:42:52 -0400
Message-ID: <000a01c12c3e$169c6fb0$0100a8c0@kiosks.hospitaladmission.com>
MIME-Version: 1.0
Content-Type: text/plain;	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
In-Reply-To: <3B85615A.58920036@timesn.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2526.0000
Importance: Normal
X-OriginalArrivalTime: 24 Aug 2001 01:42:41.0437 (UTC) FILETIME=[1031ACD0:01C12C3E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A small detail; you min(x,y) fails if x and y are pointers.

Example: min(char * a, char * b) would evaluate to
char * __x = (a), __y = (b); etc...

Here __x is a pointer and __y is a char. A better solution (at least the
one that has my vote so far) would besomething like this:

typeof(x) __x=(x); typeof(y) __y=(y); (__x < __y) ? __x : __y

Camiel.

> Without digging through the archives to see if this has already
> been suggested (if so, I apologize), why can't the following be done:
> 
> min(x,y) = ({typeof((x)) __x=(x), __y=(y); (__x < __y) ? __x : __y})
> 
> That gets you the correct "evaluate the args once" semantics and gives
> you control over typing (the comparison is done in the type of the
> first argument) and we don't have to change a zillion drivers.
> 
> (typeof() is a gcc extension.)
