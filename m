Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265560AbUATP26 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 10:28:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265572AbUATP25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 10:28:57 -0500
Received: from gaia.cela.pl ([213.134.162.11]:23824 "EHLO gaia.cela.pl")
	by vger.kernel.org with ESMTP id S265560AbUATP2z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 10:28:55 -0500
Date: Tue, 20 Jan 2004 16:28:50 +0100 (CET)
From: Maciej Zenczykowski <maze@cela.pl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: i386/mm and openwall change
Message-ID: <Pine.LNX.4.44.0401201625290.13857-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux 2.4.24 contains in arch/i386/mm/fault.c [around line 270]
the following code.

tsk->thread.error_code = error_code;

Openwall 2.4.24-ow1 changes (fixes?) this to:

if (address < TASK_SIZE)
       tsk->thread.error_code = error_code;
else
       tsk->thread.error_code = 0;

While Linux 2.4.25-pre6 contains:

/* Kernel addresses are always protection faults */
tsk->thread.error_code = error_code | (address >= TASK_SIZE);

I'm assuming this means the openwall change was an error?

Cheers,
MaZe.

