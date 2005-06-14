Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261183AbVFNQHs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261183AbVFNQHs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 12:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbVFNQHr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 12:07:47 -0400
Received: from cdc868fe.powerlandcomputers.com ([205.200.104.254]:13641 "EHLO
	pl6w2kex.lan.powerlandcomputers.com") by vger.kernel.org with ESMTP
	id S261183AbVFNQHo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 12:07:44 -0400
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
Subject: RE: gzip zombie / spawned from init
Date: Tue, 14 Jun 2005 11:07:42 -0500
Message-ID: <18DFD6B776308241A200853F3F83D50702128D37@pl6w2kex.lan.powerlandcomputers.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: gzip zombie / spawned from init
Thread-Index: AcVw0PkcWa/uriCaQu+o949vDCLzAwAJi0NQ
From: "Chad Kitching" <CKitching@powerlandcomputers.com>
To: "Nico Schottelius" <nico-kernel@schottelius.org>,
       "Bart Hartgers" <bart@etpmod.phys.tue.nl>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nico Schottelius
>
>Well, wait waitpid(-1, ...) cannot be used, as there are many other
>children (the system is booting up at the time the gzip process
>becomes a zombie).
>
try waitpid(-1, &status, WNOHANG)

You will need to implement this in your replacement init because 
one of init's jobs is to wait on unparented zombie tasks.  In the 
sysvinit package, see chld_handler() in init.c which handles the 
SIGCHLD signal.

Basically, I believe all you need to do is waitpid() in the SIGCHLD
handler until you get a 0 return code.
