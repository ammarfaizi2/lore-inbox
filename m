Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318162AbSIJVwG>; Tue, 10 Sep 2002 17:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318165AbSIJVwG>; Tue, 10 Sep 2002 17:52:06 -0400
Received: from mail.derbyworks.net ([208.16.191.4]:51728 "EHLO
	mail.derbyworks.net") by vger.kernel.org with ESMTP
	id <S318162AbSIJVwF>; Tue, 10 Sep 2002 17:52:05 -0400
Message-ID: <000501c25915$5fb9e9c0$9f00000a@daa1>
From: "David Hinkle" <hinkle@derbyworks.com>
To: <linux-kernel@vger.kernel.org>
Subject: Fix for promise RAID controllers not working as IDE controllers in 2.4.19
Date: Tue, 10 Sep 2002 16:59:45 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When an a promise raid 20267 (and probably others) is used as an IDE device
in 2.4.19 it won't detect using the non-raid driver as it would in 2.4.18.
(So it can be used as a high performance ide controller).

The problem lies in the addition of some ifdefs checking the status of
CONFIG_PDC202XX_FORCE in ide-pci.c.  On line 672 an ifdef needed to be
changed
to an ifndef, a bug found way back in RC2, but when it was changed the ifdef
on line 405 got changed instead.

To get everthing working properly change
#ifndef CONFIG_PDC202XX_FORCE
on line 405 to
#ifdef CONFIG_PDC202XX_FORCE

and change
#ifdef CONFIG_PDC202XX_FORCE
on line 672 to
#ifdef CONFIG_PDC202XX_FORCE

I'd quote the origional posts by my entire network just went down.

TTYlater

        David Hinkle
        Chief Engineer
        Derbyworks Systems

