Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262954AbTJPNmm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 09:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262965AbTJPNmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 09:42:42 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:15888 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id S262954AbTJPNmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 09:42:38 -0400
Message-ID: <3F8E9DA4.11ED60DA@ardistech.com>
Date: Thu, 16 Oct 2003 15:31:16 +0200
From: Roman Zippel <roman@ardistech.com>
Organization: Ardis Technologies BV
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [ANNOUNCE] iSCSI target implementation
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm proud to announce the first public release of this iSCSI target
implementation. It's already usable, but it doesn't implement everything
yet what is required by the iSCSI spec. The missing parts shouldn't be
that difficult to add (I just didn't need them so far). Other more
interesting parts of the spec (e.g. session recovery) are not
implemented because I had no client to test it with (although recent UNH
releases seem to support this now). It was mostly tested with Cisco
iSCSI initiator driver, but also with with the MS initiator driver. You
can download the driver from http://www.ardistech.com/iscsi/ , the
README should have all the information to configure and build the
driver.

This target driver is partly implemented in the kernel, the user space
daemon takes care of session startup, cleanup and discovery and the
kernel module takes care of the iSCSI requests and disk IO. There are a
few reasons to put part of it into the kernel, the main reason is to
have direct access to the page cache, this is also a main difference to
other available target implementations, which don't use the page cache
directly. User space has not that fine grained control (yet) and had to
use a lot of threads (the kernel module currently uses 2 threads per
target and 1 per device). Part of the problem could be solved with async
IO, another part is to be able to control what is in the cache (this is
somewhat related to the recent direct IO discussion). So this also an
experiment of what is needed if it should be ever moved to user space.

Anyway, while it's in the kernel, there are also some interesting issues
for the kernel-user space communication. Right now it's a proc only
interface (no sysfs as it's 2.4 only, no evil ioctl, but someone will
kill me for the macro abuse :) ), but it should be rather easy to
replace it with something else. Perfomance isn't not that important at
the moment (but not completely unimportant, if a lot of information has
to be read from the kernel, e.g. at startup). More important issues are
error reporting and event handling, which could benefit from a better
integrated interface. So this driver is also intended to experiment with
a few things, if anyone is interested I can explain it further.

Further development will depend a bit on the feed back. This is an older
project and we thought about for a while and since we have no immediate
need and not the resources to develop it alone, we decided it would be a
good idea to release it completely under the GPL. So I updated it to the
latest spec and fixed some of the worst embarrasments. If there is
enough interest, the development will continue, but without some help it
will be rather slow. :-)

bye, Roman

