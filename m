Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264480AbTDPQvP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 12:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264467AbTDPQtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 12:49:22 -0400
Received: from [205.205.44.10] ([205.205.44.10]:30212 "EHLO
	sembo111.teknor.com") by vger.kernel.org with ESMTP id S264447AbTDPQrW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 12:47:22 -0400
Message-ID: <5009AD9521A8D41198EE00805F85F18F039D3A65@sembo111.teknor.com>
From: "Isabelle, Francois" <Francois.Isabelle@ca.kontron.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: "Audet, Jean-Michel" <Jean-Michel.Audet@ca.Kontron.com>
Subject: Using kill_fasync for sig >= SIGRTMIN ?
Date: Wed, 16 Apr 2003 12:59:13 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using kernel 2.4.20.

Is it possible to kill_fasync a signal >= SIGRTMIN to asynchronously notify
a user of the availability of data from a driver ? 

It seems to me the code always sends a SIGIO instead.

Looking at fs/fnctl.c and kernel/signal.c, it appears to fail in
send_sig_info().

signal chosen is 40 ( lower than 64 on i386 )
bad_signal() , should not fail, except if kernel mode is not allowed to send
RT signals ...
then deliver_signal is called, which in turns call send_signal() .
rtsig-nr = 0  , rtsig-max = 1024, there is no reason to fail...

Any explanation would help, thank you.

Please CC me.

Francois Isabelle
