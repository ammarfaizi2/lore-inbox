Return-Path: <linux-kernel-owner+w=401wt.eu-S1761850AbWLIT7a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761850AbWLIT7a (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 14:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761863AbWLIT7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 14:59:30 -0500
Received: from gate.crashing.org ([63.228.1.57]:37574 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761850AbWLIT73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 14:59:29 -0500
Subject: sysfs file creation result nightmare (WAS radeonfb: Fix
	sysfs_create_bin_file warnings)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jean Delvare <khali@linux-fr.org>
Cc: Andrew Morton <akpm@osdl.org>, Paul Mackerras <paulus@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20061209165606.2f026a6c.khali@linux-fr.org>
References: <20061209165606.2f026a6c.khali@linux-fr.org>
Content-Type: text/plain
Date: Sun, 10 Dec 2006 06:59:10 +1100
Message-Id: <1165694351.1103.133.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-12-09 at 16:56 +0100, Jean Delvare wrote:

> Check for error on radeonfb device sysfs files creation. This fixes the
> following warnings:

(Moving to LKML as I think that's a generic issue)

As usual with most of that crap about return values from
sysfs_create_file, I disagree. strongly.

Why would I prevent the framebuffer from initializing (and thus a
console to be displayed at all on many machines) just because for some
reason, I couldn't create a pair of EDID files in sysfs that are not
even very useful anymore ?

I have _plenty_ of cases where the failure to create sysfs files, while
annoying and maybe deserving a warning, certainly doesn't imply
completely preventing the driver from initializing. However, all the
patches I've seen so far to fix the new warnings do just that (make the
driver fail)

I'd really like to have some kind of macro or attribute or whatever I
can put on a function call to say that I'm purposefully ignoring the
error. Is there some gcc magic that can do that ?

Ben.


