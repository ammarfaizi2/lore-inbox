Return-Path: <linux-kernel-owner+w=401wt.eu-S937657AbWLIUig@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937657AbWLIUig (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 15:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937666AbWLIUig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 15:38:36 -0500
Received: from smtp.osdl.org ([65.172.181.25]:48030 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937657AbWLIUif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 15:38:35 -0500
Date: Sat, 9 Dec 2006 12:38:17 -0800
From: Andrew Morton <akpm@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jean Delvare <khali@linux-fr.org>, Paul Mackerras <paulus@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: sysfs file creation result nightmare (WAS radeonfb: Fix
 sysfs_create_bin_file warnings)
Message-Id: <20061209123817.f0117ad6.akpm@osdl.org>
In-Reply-To: <1165694351.1103.133.camel@localhost.localdomain>
References: <20061209165606.2f026a6c.khali@linux-fr.org>
	<1165694351.1103.133.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Dec 2006 06:59:10 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Sat, 2006-12-09 at 16:56 +0100, Jean Delvare wrote:
> 
> > Check for error on radeonfb device sysfs files creation. This fixes the
> > following warnings:
> 
> (Moving to LKML as I think that's a generic issue)
> 
> As usual with most of that crap about return values from
> sysfs_create_file, I disagree. strongly.

Actually, wrongly.

> Why would I prevent the framebuffer from initializing (and thus a
> console to be displayed at all on many machines) just because for some
> reason, I couldn't create a pair of EDID files in sysfs that are not
> even very useful anymore ?

Because there's a bug in your kernel.  We don't hide and work around bugs.

> I have _plenty_ of cases where the failure to create sysfs files, while
> annoying and maybe deserving a warning, certainly doesn't imply
> completely preventing the driver from initializing.

Why does it matter?  Just fix the bugs and the issue won't arise.  If you
hide them and work around them in this manner, they won't get fixed.

> However, all the
> patches I've seen so far to fix the new warnings do just that (make the
> driver fail)
> 
> I'd really like to have some kind of macro or attribute or whatever I
> can put on a function call to say that I'm purposefully ignoring the
> error. Is there some gcc magic that can do that ?

#define HIDE_AND_WORK_AROUND_A_BUG(expr) (void)(expr)

but it might meet some resistance.


Just fix the bugs, for heck's sake.

