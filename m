Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316663AbSGBH1j>; Tue, 2 Jul 2002 03:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316666AbSGBH1j>; Tue, 2 Jul 2002 03:27:39 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:21520 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S316663AbSGBH1i>; Tue, 2 Jul 2002 03:27:38 -0400
Message-Id: <200207020704.g62743T21511@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: willy tarreau <wtarreau@yahoo.fr>, Bill Davidsen <davidsen@tmr.com>
Subject: Re: [ANNOUNCE] CMOV emulation for 2.4.19-rc1
Date: Tue, 2 Jul 2002 10:03:46 -0200
X-Mailer: KMail [version 1.3.2]
Cc: Willy TARREAU <willy@w.ods.org>, willy@meta-x.org,
       linux-kernel@vger.kernel.org, Ronald.Wahl@informatik.tu-chemnitz.de
References: <20020702063133.20857.qmail@web20502.mail.yahoo.com>
In-Reply-To: <20020702063133.20857.qmail@web20502.mail.yahoo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2 July 2002 04:31, willy tarreau wrote:
> > 1.big red letters 'CMOV EMULATION' across the screen? :-)
> > 2.Scroll lock LED inverted each time CMOV is triggered?
> > 3.Printk at kernel init time:
> > "Emergency rescue kernel with CMOV emulation: can
> > be very slow, not for production use!" ?
>
> perhaps not, but we could send an alert message on
> the system console the first time an instruction is
> emulated, with the program's name. But nothing more,
> else we'll have to modify the task struct to include
> counters, and I really don't want that.
>
> > Of course (1) is a joke.
>
> so (2) isn't ? and you talk about overhead of 3 IFs

(2) is a half-joke, so to say. It woulda be funny to see
on lkml:

From: JRLuser@host.com
Subj: mailer crawls like on 286 and scroll LED blinks!!!

Everyone will immediately realize what's going on.
This will save us chasing non-existent performance 
problems. But it will cost _many_ cycles each fault.

Seriously, I think (3) is best. Why?

> an alert message on the system console
> the first time an instruction is emulated

is a printk(KERN_EMERG...), it can go unnoticed
too (all logs go to file only or user in X)
_and_ it incurs penalty on each fault.
 
> > 3.Printk at kernel init time:
> > "Emergency rescue kernel with CMOV emulation: can
> > be very slow, not for production use!" ?

is non-suppressable (unless user is stupid enough
to suppress ALL kernel boot messages) and have no penalty.
--
vda
