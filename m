Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269639AbUJGOD7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269639AbUJGOD7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 10:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269659AbUJGOD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 10:03:59 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:36014 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269639AbUJGODh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 10:03:37 -0400
Subject: RE: [Patch] new serial flow control
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Stuart MacDonald <stuartm@connecttech.com>
Cc: "'Samuel Thibault'" <samuel.thibault@ens-lyon.org>,
       "=?ISO-8859-1?Q?=27S=E9bastien?= Hinderer'" 
	<Sebastien.Hinderer@libertysurf.fr>,
       rmk@arm.linux.org.uk,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
In-Reply-To: <043c01c4ac0d$2c8bac80$294b82ce@stuartm>
References: <043c01c4ac0d$2c8bac80$294b82ce@stuartm>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1097154020.31614.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 07 Oct 2004 14:00:24 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-10-07 at 02:30, Stuart MacDonald wrote:
> RS485 is a driver-transparent electrical interface. Unfortunately the
> half-duplex and master-slave(s) arrangements require some sort of
> token passing to know when they can successfully transmit. This is
> usually handled by the apps in some manner, although it's often wanted
> to be handled by the serial driver. This could be one method of
> signalling, but isn't sufficient to show RS485 operation.

No its one I've seen a lot there and it turns out having dug into docs
and consulted the serial people in pointy hats that it is RS232
half-duplex mode which is one of those bits of the spec nobody ever
uses.

In this mode the DTE end (host normally) asserts RTS to request 
transmit access to the link. The DCE asserts CTS to indicate it has
finished sending bits, and the DTE then transmits.

RTS is a direction selector (RTS = 0, DCE transmit) (RTS = 1, DTE
transmit). CTS acts as the handshake to deal with the link turn around.

So that makes this much more useful. 

Alan

