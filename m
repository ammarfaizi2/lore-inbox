Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131730AbRCVLvM>; Thu, 22 Mar 2001 06:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131989AbRCVLvC>; Thu, 22 Mar 2001 06:51:02 -0500
Received: from mailhost.mipsys.com ([62.161.177.33]:22270 "EHLO
	mailhost.mipsys.com") by vger.kernel.org with ESMTP
	id <S131730AbRCVLuu>; Thu, 22 Mar 2001 06:50:50 -0500
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <linux-kernel@vger.kernel.org>
Subject: kernel_thread vs. zombie
Date: Thu, 22 Mar 2001 12:49:27 +0100
Message-Id: <20010322114927.14509@mailhost.mipsys.com>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

I'm changing the ADB bus reset & probe code to be in a kernel threads
that is created when a bus reset is triggered and that dies of it's own
death. 

Everything is fine when the bus reset is triggered during kernel init as
my thread is a child of init. However, when created as a result of an
ioctl, the thread becomes a zombie as it's a child of the process who
caused the ioctl (typically when entering sleep mode).

How do I force a kernel thread to always be a child of init and never
become a zombie ?

I do call daemonize at the beginning of the thread (as it won't do
anything with files, signals or whatever), but that doesn't seem to be enough.

Reagrds,
Ben.



