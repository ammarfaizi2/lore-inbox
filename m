Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161245AbWAHXjs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161245AbWAHXjs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 18:39:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161248AbWAHXjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 18:39:48 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:8379 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S1161245AbWAHXjr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 18:39:47 -0500
Date: Sun, 8 Jan 2006 18:39:35 -0500
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: Pavel Machek <pavel@ucw.cz>
Cc: Dave Jones <davej@redhat.com>, David Lang <dlang@digitalinsight.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Bernd Eckenfels <be-news06@lina.inka.de>, linux-kernel@vger.kernel.org
Subject: Re: oops pauser. / boot_delayer
Message-ID: <20060108233935.GA12745@filer.fsl.cs.sunysb.edu>
References: <E1EuPZg-0008Kw-00@calista.inka.de> <Pine.LNX.4.61.0601050905250.10161@yvahk01.tjqt.qr> <Pine.LNX.4.62.0601051726290.973@qynat.qvtvafvgr.pbz> <20060106053609.GB32105@redhat.com> <20060108132132.GA1952@elf.ucw.cz> <20060108193000.GB10232@filer.fsl.cs.sunysb.edu> <20060108230827.GB1686@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060108230827.GB1686@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2006 at 12:08:27AM +0100, Pavel Machek wrote:
> On Ne 08-01-06 14:30:00, Josef Sipek wrote:
> > On Sun, Jan 08, 2006 at 02:21:32PM +0100, Pavel Machek wrote:
> > > On Pá 06-01-06 00:36:09, Dave Jones wrote:
> > > > So disable CONFIG_CRYPTO_TEST. There's no reason to test this stuff every boot.
> > > 
> > > Maybe even with CRYPTO_TEST enabled we could only report _failures_?
> > 
> > Why? As far as I know, it is intended for developers as a regression test. I say
> > if you don't like the output, make the thing a module or don't compile it at all.
> 
> I don't like the output, but if it only reported failures, I could
> leave it running and potentially catch some strange failures.

I agree that it is useful to know about strange failures, however I still maintain
that _if_ the module is intended as a regression test for developers, than the
excessive (?) output is fair. I think that the most logical course of action is to
have a verbosity module paramter which defaults to displaying errors only, but it still
allows developers to get all the information they need.

> Is reporting successes actually useful?

Then I propose: :)


diff -r b4fca0ece97f kernel/sys.c
--- a/kernel/sys.c	Sat Oct 22 19:24:10 2005 +0300
+++ b/kernel/sys.c	Sun Jan  8 18:26:49 2006 -0500
@@ -436,7 +436,6 @@
 void kernel_halt(void)
 {
 	kernel_halt_prepare();
-	printk(KERN_EMERG "System halted.\n");
 	machine_halt();
 }
 EXPORT_SYMBOL_GPL(kernel_halt);

Jeff.

