Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262652AbTCZXjs>; Wed, 26 Mar 2003 18:39:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262663AbTCZXjs>; Wed, 26 Mar 2003 18:39:48 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:63427 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S262652AbTCZXjp>; Wed, 26 Mar 2003 18:39:45 -0500
Message-Id: <200303262350.h2QNoqje015366@post.webmailer.de>
From: Arnd Bergmann <arnd@bergmann-dalldorf.de>
Subject: Re: [PATCH] s390 update (3/9): listing & kerntypes.
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       schwidefsky@de.ibm.com
Date: Thu, 27 Mar 2003 00:20:07 +0100
References: <20030326164014$3fac@gated-at.bofh.it> <20030326202006$09c8@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

> On Wed, Mar 26, 2003 at 05:32:12PM +0100, Martin Schwidefsky wrote:
>> 
>> > No.  Either we add Kerntypes to the architecture-independent code (I'm
>> all
>> > for it!) or not at all.  Cludging this into s390-specific code is a very,
>> > very bad idea.
AFAIK, s390 is the only architecture that has hardware support for taking
system dumps without the lkcd patch. Since the lkcd patch does not
appear to be going into mainline linux and most s390 users want the
kerntypes anyway (every distributor includes them), arch/s390/boot
seems to be the right place to put them.

>> Well, even if the Kerntypes gets added to the architecture-independent code
>> we still would need some special s390 includes to get all the types we need.
> 
> The patches from the lkcd folks don't seem to need additional includes.
> Please argue with them instead of trying to push such changes through the
> backdoor.
You need to include the struct definition for every data type that you
want lcrash to know about. E.g. if you want to analyse scsi structures
in a crash dump, you have to include drivers/scsi/scsi.h.
Most internal information about s390 devices is in structs defined
in drivers/s390/cio/, so we need them as well.

This is not an attempt to sneak the (mostly unrelated) lkcd patch in. If they
ever get included, we can still do a merge of the kerntypes file, but until 
then it is just a tiny architecture special file that everybody else can 
ignore.

        Arnd <><
