Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270618AbTHJTEk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 15:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270622AbTHJTEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 15:04:40 -0400
Received: from intrepid.intrepid.com ([192.195.190.1]:39858 "EHLO
	intrepid.intrepid.com") by vger.kernel.org with ESMTP
	id S270618AbTHJTEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 15:04:39 -0400
From: "Gary Funck" <gary@intrepid.com>
To: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: can select() eventually exhaust kernel memory?
Date: Sun, 10 Aug 2003 12:04:34 -0700
Message-ID: <KNEFLOIOCHLFEGCDNFPHIECLCJAA.gary@intrepid.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[running Linux kernel 2.4.20-6, Redhat 9 (stock), on Athlon XP 2000]

Hello, recently I've been trying to run one of the Spamassassin (SA) tools,
called mass_check, which is used to tune the weights used by SA, and is run
by various volunteers prior to releasing SA. Mass_check (as well as SA) is
a Perl program. Well, mass_check fails in a rather unusual (for me, though
others seem to be running it fine) - after doing about 4 hours processing,
and reading only about 1/3 of the mail messages that I've asked it to process,
the main process goes into a state where it consumes cpu time (at about the 20%
to 30%
level per 'top'), and slowly over the course of 12 hours or so continually uses
up
more and more memory (swap space), until eventually it uses all available
memory (top
reports 0 memory free). Of course, at this point the load average goes through
the roof,
and the system has trouble making any forward progress. I ran 'strace' on the
mass_check
after it goes into this "consuming cpu and memory" state. Strace shows only
this
single line:

select(8, [6], NULL, NULL, NULL)        = ? ERESTARTNOHAND (To be restarted)

and the system memory continues to dwindle away, until after about 12 hours,
all 1G of
swap space has been consumed. Once the mass_check process is killed, the memory
is
released; mass_check appears to be the culprit, and since the only system call
it
is running is "select()", it appears that this call is somehow leading to
memory
exhaustion.

Question: Have you seen a problem like this before? Are there any known
problems
with the 2.4 kernel's implementation of select() that lead to the exhaustion of
available memory?




