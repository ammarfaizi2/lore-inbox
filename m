Return-Path: <linux-kernel-owner+w=401wt.eu-S1030325AbWLTTcd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030325AbWLTTcd (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 14:32:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030328AbWLTTcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 14:32:33 -0500
Received: from web32911.mail.mud.yahoo.com ([209.191.69.111]:25121 "HELO
	web32911.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1030325AbWLTTcc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 14:32:32 -0500
Message-ID: <20061220193231.39261.qmail@web32911.mail.mud.yahoo.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=Em+rLavLD0kQEz6BtYDy9pqN6G5ZJVN9mOXtKNfcFC3YW86mH5C+mVpFZQUzrKrd84B/ycGdy3nO0R4zabPAsm5U//F/UXlxdE+tf1bvE2H+T9xuenak2ioOVh2fZoF0BI12bW78JMed5wGXfAhh8wfF03C/zu4rfGIjhDEPS58=;
X-YMail-OSG: 1RmayXAVM1ljoPBULkQJBmNTBpd8XQcEwNWUGt2m4adqQC1CCHt5PpAFpZ7b3lDn0zbmhIyi5H7jaU2bjZpNyPnK2s.E26Eg2yzYi97jpOeI.m66EsX0Dk6TlX.YGMNuhco2ra8KUuHmDpvefPdVmof9O_3tkvWG4BDgPGNkuXoEVzmpkREGN_eHZKSZ
Date: Wed, 20 Dec 2006 11:32:31 -0800 (PST)
From: J <jhnlmn@yahoo.com>
Subject: Re: Possible race condition in usb-serial.c
To: linux-kernel@vger.kernel.org
In-Reply-To: <200612201047.20842.oliver@neukum.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for the explanation.

> serial_close is safe because serial_disconnect
> lowers the refcount

Sorry, I meant serial_open, as in my original example.

I am currently trying to fix a legacy 2.4 based USB
driver and I am having various races, 
serial_open/usb_serial_disconnect is the most lively.
I am not asking your help in fixing this old 2.4 junk
(in fact I already fixed it using a global semaphore
to protect serial_table).

But I still want to understand how the latest and
greatest 2.6 driver is supposed to work so I can
adopt some of the changes. At first I thought that
the ref-counting will help, but then found that 
it does not fix much! The race is as lively 
as ever.

Also I found that BKL/lock_kernel is compiled out in
my configuration because it is not an SMP build.

I see that in 2.6 BKL/lock_kernel are also optional
for non-SMP builds. Is it true?
If yes, then again, how this is supposed to work
and avoid races?


Thank you
John


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
