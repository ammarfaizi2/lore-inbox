Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267850AbUJCMPM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267850AbUJCMPM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 08:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267860AbUJCMPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 08:15:12 -0400
Received: from scanner2.mail.elte.hu ([157.181.151.9]:3005 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S267850AbUJCMPH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 08:15:07 -0400
Date: Sun, 3 Oct 2004 14:16:45 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Jean Delvare <khali@linux-fr.org>
Cc: Andrew Morton <akpm@osdl.org>, Bill Davidsen <davidsen@tmr.com>,
       linux-kernel@vger.kernel.org
Subject: Re: mmap() on cdrom files fails since 2.6.9-rc2-bk2
Message-ID: <20041003121645.GA19580@elte.hu>
References: <2Jw9b-52b-13@gated-at.bofh.it> <20040929222619.5da3f207.khali@linux-fr.org> <20041001184431.4e0c6ba5.akpm@osdl.org> <20041002090125.302fff71.khali@linux-fr.org> <20041003111458.GA15390@elte.hu> <20041003141140.319039de.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041003141140.319039de.khali@linux-fr.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jean Delvare <khali@linux-fr.org> wrote:

> Indeed, all files on which mmap was failing were located on noexec'd
> devices (although for the cdrom the noexec is not explicitely stated
> in my /etc/fstab file). Your patch fixes my problem, mmap on these
> devices is working again. Thanks!
> 
> Now I'm only curious as to why the problem only affected me. Since it
> looks like noexec is implied on cdrom devices, the problem should have
> affected everyone. Or are the "!pt_gnu_stack binaries" something rare?
> I admit I have no idea what it refers to.

it means you are running an older distro which was built with a gcc that
doesnt generate PT_GNU_STACK signatures in binaries yet. On the biggest
distros the transition to PT_GNU_STACK binaries coincided with the
transition to a 2.6 kernel, so only people who run newer kernels on
older distros are affected, which is relatively rare since most 'older
distros' are not 2.6-ready in a number of system-support areas.
(although the kernel itself of course must be able to run old code too.)

	Ingo
