Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261849AbVC3MVh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261849AbVC3MVh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 07:21:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261877AbVC3MVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 07:21:34 -0500
Received: from general.keba.co.at ([193.154.24.243]:8085 "EHLO
	helga.keba.co.at") by vger.kernel.org with ESMTP id S261849AbVC3MVZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 07:21:25 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.11, IDE: Strange scheduling behaviour: high-pri RT process not scheduled?
Date: Wed, 30 Mar 2005 14:21:17 +0200
Message-ID: <AAD6DA242BC63C488511C611BD51F3673231C3@MAILIT.keba.co.at>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.11, IDE: Strange scheduling behaviour: high-pri RT process not scheduled?
Thread-Index: AcU1IPK07vDtlzz1ROObvAqATFUagwAABZ+Q
From: "kus Kusche Klaus" <kus@keba.com>
To: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-ide@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Bartlomiej Zolnierkiewicz [mailto:bzolnier@gmail.com] 
>
> On Wed, 30 Mar 2005 13:52:05 +0200, kus Kusche Klaus 
> <kus@keba.com> wrote:
> > However, things break seriously when exercising the CF card 
> in parallel
> > (e.g. with a dd if=/dev/hda of=/dev/null):
> > 
> > * The rtc *interrupt handler* is delayed for up to 250 
> *micro*seconds.
> > This is very bad for my purpose, but easy to explain: It is 
> roughly the
> > time needed to transfer 512 Bytes from a CF card which can 
> transfer 2
> > Mbyte/sec, and obviously, the CPU blocks all interrupts 
> while making pio
> > 
> > transfers. (Why? Is this really necessary?)
> >  
> > (I know because I instrumented the rtc irq handler with 
> rdtscl(), too)
> 
> hdparm -u1 /dev/hda
> 
> should help

Hmmm, thanks, that sounds very reasonable, and I didn't know that flag.

Unfortunately, it doesn't help. The bad timings stay the same (still
delays in the 30-300 ms range), the number of context switches stays the
same, ...

The only thing which changes is the CPU load shown by vmstat:
* With -u0, I have 1 % user, ~50 % sys, ~50 % wa
* With -u1, I have 1 % user, ~98 % sys, 1 % wa

P.S.: Apologies for my badly formatted mails. The company forces us to
use outlook, we may not even change the settings... 

Klaus Kusche
>Entwicklung Software - Steuerung
>Software Development - Control
>
>KEBA AG
>A-4041 Linz
>Gewerbepark Urfahr
>Tel +43 / 732 / 7090-3120
>Fax +43 / 732 / 7090-8919
>E-Mail: kus@keba.com
>www.keba.com
>
