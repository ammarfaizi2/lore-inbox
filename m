Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264643AbRFYPmY>; Mon, 25 Jun 2001 11:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264642AbRFYPmO>; Mon, 25 Jun 2001 11:42:14 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:39695 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S264640AbRFYPl7>;
	Mon, 25 Jun 2001 11:41:59 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: klink@clouddancer.com
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.5-ac12 kernel oops 
In-Reply-To: Your message of "Mon, 25 Jun 2001 08:15:49 MST."
             <20010625151549.7ED6F784D9@mail.clouddancer.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 26 Jun 2001 01:41:52 +1000
Message-ID: <32526.993483712@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jun 2001 08:15:49 -0700 (PDT), 
klink@clouddancer.com (Colonel) wrote:
>ksymoops 2.4.1 on i686 2.4.5-ac12.  Options used
>Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base says c01aad00, System.map says c014cba0.  Ignoring ksyms_base entry
>Why the symbol mismatch?

The mismatch is caused by two variables called partition_name.  What
does 'nm vmlinux | grep partition_name' show?  Probably one
partition_name at c01aad00 and another at c014cba0.  Both
fs/partitions/msdos.c and drivers/md/md.c define that symbol, md
exports its version.  A good reason why exported symbols should have
unique names.

>Why ignore /proc over the System.map?

ksymoops has a hierarchy of trust.  System.map is more trustworthy than
/proc/ksyms because ksyms changes, especially if you rebooted after the
oops and before running ksymoops.

