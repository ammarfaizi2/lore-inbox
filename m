Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263062AbUG1ULh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbUG1ULh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 16:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263100AbUG1ULh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 16:11:37 -0400
Received: from scrye.com ([216.17.180.1]:7825 "EHLO mail.scrye.com")
	by vger.kernel.org with ESMTP id S263062AbUG1ULe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 16:11:34 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Wed, 28 Jul 2004 14:11:27 -0600
From: Kevin Fenzi <kevin-kernel@scrye.com>
To: linux-kernel@vger.kernel.org
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Subject: Re: pmdisk/swusp1 (merged) with 2.6.8-rc2-mm1
X-Draft-From: ("scrye.linux.kernel" 52588)
References: <20040728185346.45CE54189@voldemort.scrye.com>
From: Kevin Fenzi <kevin@scrye.com>
Message-Id: <20040728201130.8B529D208C@voldemort.scrye.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

>>>>> "Kevin" == Kevin Fenzi <kevin-kernel@scrye.com> writes:

Kevin> Greetings.

Kevin> I am a happy software suspend2 user, but with the recent merge
Kevin> of pmdisk and swsusp1, I thought I would give it a try and see
Kevin> how far along it's come.

Kevin> Using 2.6.8-rc2-mm1 (that has the merged pmdisk/swsusp) I
Kevin> booted single user and unloaded all modules, then started a
Kevin> hibernate.

Kevin> It gets to:

Kevin> PM: Attempting to suspend to disk.

Kevin> and then hangs. Machine has to be hard power cycled. Looking at
Kevin> the code the problem appears to be that my laptop is reporting
Kevin> that it has "S4_bios" support. It doesn't, but swsup1 sees the
Kevin> S4_bios in /proc/acpi/sleep and tries to call that instead of
Kevin> swsusp1.

Kevin> Is there any way to disable detection of S4_bios?

Kevin> Is there any way to get swsusp1 to use it's S4 instead of
Kevin> S4_bios?

Kevin> I guess I can recompile with the calls to S4_bios removed and
Kevin> see how things go.

To followup on myself here, this can be set with: 

echo "shutdown" > /sys/power/disk

to tell it to use OS shutdown instead of firmware mode letting the
bios handle things. 

Using that, I get a suspend to happen ok, but on resume I get a kernel
panic. ;( 

Pavel/Patrick: Does your current implementation handle himem and/or
preempt? 

suspend2 handles both, so I had them enabled in my config, but I
wonder if that isn't the issue. The panic is in memory allocation it
seems like. 

I can re-compile with both those off. 

kevin
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8 <http://mailcrypt.sourceforge.net/>

iD8DBQFBCAhx3imCezTjY0ERAoYRAKCQ022MJ+znKAsK0YsiCypLEeRvMQCgkHob
6LQW1i/bqgblQSZJikohdjg=
=NmQD
-----END PGP SIGNATURE-----
