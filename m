Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266051AbTGDP1b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 11:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266053AbTGDP1a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 11:27:30 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57759 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266051AbTGDP13
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 11:27:29 -0400
Message-ID: <3F05A037.2080808@pobox.com>
Date: Fri, 04 Jul 2003 11:41:43 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <greg@kroah.com>, Chris Wright <chris@wirex.com>,
       James Morris <jmorris@intercode.com.au>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add SELinux module to 2.5.74-bk1
References: <1057254295.1110.1016.camel@moss-huskers.epoch.ncsc.mil>	 <20030703175153.GC27556@gtf.org> <1057255509.1110.1030.camel@moss-huskers.epoch.ncsc.mil>
In-Reply-To: <1057255509.1110.1030.camel@moss-huskers.epoch.ncsc.mil>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Smalley wrote:
> On Thu, 2003-07-03 at 13:51, Jeff Garzik wrote:
>>2) stick includes in the standard include/ directory.  I would suggest
>>include/security (if the headers are general) or
>>include/security/selinux.
> 
> 
> Even if the headers are private to the SELinux "module"?  No other
> kernel code uses them.  


It's a tough call, so I won't shed a tear if I'm ignored here :)

It's mainly a matter of number of headers, to me.  If the module gets so 
huge that the number of headers is climbing towards ten or so, and 
doesn't look to stop anytime soon, I tend to feel include/ is more 
appropriate.

Example:  drivers/acpi/include became include/acpi.  A few of the 
headers are used publicly, but most are private to the ACPI driver.

Adding -I to certain directories or files is easily doable, but it tends 
to break in subtle ways on occasion.  The makefiles are already set up 
to include $topdir/include, so one only needs to carve our your own 
namespace in include/.  Anyone doing something weird like building when 
objdir != srcdir or similar uncommon cases won't have to worry about 
your Makefile being a special case.

Example:  SCSI low-level driver headers were until recently 
drivers/scsi/{hosts,scsi}.h.  This is awful for out-of-tree drivers, and 
for in-tree drivers not in drivers/scsi.  There were all manner of 
"-I../../../blah" type stuff in Makefiles, which often break in uncommon 
situations.  If there are ever SELinux sub-modules that live out-of-tree 
for a while, you'll be glad the headers are in include/... things will 
Just Work(tm).

	Jeff



