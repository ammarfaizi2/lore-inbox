Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264746AbUFLM07@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264746AbUFLM07 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 08:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264734AbUFLM07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 08:26:59 -0400
Received: from nepa.nlc.no ([195.159.31.6]:46267 "HELO nepa.nlc.no")
	by vger.kernel.org with SMTP id S264762AbUFLM0o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 08:26:44 -0400
Message-ID: <1090.83.109.11.80.1087043194.squirrel@nepa.nlc.no>
Date: Sat, 12 Jun 2004 14:26:34 +0200 (CEST)
Subject: Re: timer + fpu stuff locks my console race
From: stian@nixia.no
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.0-1
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So far I have found out this:

if you ptrace is with for instace the strace program, it runs perfectly.
No signs at all of the fpu exception, and every thing runs happy

it also happens if you for instance if you trigger the exception inside a
SIGSEGV handler

But I'm not able to trigger other FPU errors. For instance
float a=1.0;
float b=0.0;
float c;
c=a/b;
does not generate a signal, but gives (inf) (isn't this configuration
option on the fpu?). So my question is then, does the FPU-exception
handler work at all since it appears to be rarely used?

A very _VERY_ nasty quick-fix (for those who are scared) is to exit the
process if we want to send a signal SIGFPE and is it already in the queue
and perhaps do a printk() about user trying to exploit known kernel-bug.
Works atleast for me currently at my 2.4.26-rc1 box.


Stian Skjelstad
