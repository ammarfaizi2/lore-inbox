Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130090AbRAQHHL>; Wed, 17 Jan 2001 02:07:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131791AbRAQHGv>; Wed, 17 Jan 2001 02:06:51 -0500
Received: from cx879306-a.pv1.ca.home.com ([24.5.157.48]:26863 "EHLO
	siamese.dhis.twinsun.com") by vger.kernel.org with ESMTP
	id <S130090AbRAQHGs>; Wed, 17 Jan 2001 02:06:48 -0500
From: junio@siamese.dhis.twinsun.com
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: 2.4.1-pre7 raid5syncd oops
In-Reply-To: <7vzogr47qb.fsf@siamese.dhis.twinsun.com>
	<14949.4047.622440.985949@notabene.cse.unsw.edu.au>
Date: 16 Jan 2001 23:06:32 -0800
In-Reply-To: <14949.4047.622440.985949@notabene.cse.unsw.edu.au>
Message-ID: <7vy9way7wn.fsf@siamese.dhis.twinsun.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "NB" == Neil Brown <neilb@cse.unsw.edu.au> writes:

NB> On  January 16, junio@siamese.dhis.twinsun.com wrote:

NB> Or in short "this cannot happen" :-)

NB> Is there any chance of a memory error?

NB> Has this happened more than once?

I have to confess that I was not running with the stock
2.4.1-pre7 drivers/md/raid5.c; instead I compiled it with the
change in -ac9 tree, which checks the return value of
alloc_page() early (around line 160).  Also I had your ``Desk
check'' patch (responding to mtew@cds.duke.edu's post) from
linux-raid list (around line 1075), and mingo's
hot-add/hot-remove fixes.

The symptom was very reproducible with that particular kernel
(essentially, early in the every reboot sequence I got the same
error).  In the end, I had to futz with partition type to
disable autodetection of those offending raid-5 component
partitions to recover from the failure.  Since then I reverted
back to the stock 2.4.1-pre7 driver with only the ``Desk check''
and mingo's hot-add/hot-remove patch, and have not seen the
problem again.  It appears that using those early-null-check
code from -ac9 without understanding its implications was purely
my stupidity, but I still do not offhand see why that would
hurt...
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
