Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261586AbTJHXoT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 19:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261744AbTJHXoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 19:44:19 -0400
Received: from main.gmane.org ([80.91.224.249]:52619 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261586AbTJHXoR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 19:44:17 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: Software RAID5 with 2.6.0-test
Date: Thu, 09 Oct 2003 01:44:13 +0200
Message-ID: <yw1xad8bfg6q.fsf@users.sourceforge.net>
References: <yw1xoewrfizk.fsf@users.sourceforge.net> <1065655452.13572.50.camel@torrey.et.myrio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:WYxVwUBnt7Iv34RZVhZgaEFRXzE=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Torrey Hoffman <thoffman@arnor.net> writes:

> My experience:
>
> I'm running 2.6.0-test6 on a dual pentium 3 with software raid-5 across
> 5 disks on two different IDE hardware controllers (VIA and Promise). 
> I've got a 224 GB reiserfs partition on that.  
>
> After 8 days uptime, it doesn't seem to have blown up yet.  However I
> don't stress it heavily - just a nightly rsync or two which does a lot
> of reading and writing, and I export my music collection on it via NFS,
> which is a low level of read activity.  

When I tried it, I was running 2.6.0-test4.  The RAID5 was 4 120 GB
Seagate disks on a Highpoint controller.  On top of that, I had LVM,
with ext3 fs.  After just minutes, strange things started happening to
files.  Some had random bits changed in the inode, others were just
trashed.  e2fsck complained a great deal.

I went back to 2.4.21, which is working OK.  A couple of things bother
me, though.  In the dmesg output there are many of these:

raid5: switching cache buffer size, 8192 --> 1024
raid5: switching cache buffer size, 1024 --> 4096
raid5: switching cache buffer size, 4096 --> 1024
raid5: switching cache buffer size, 1024 --> 4096
raid5: switching cache buffer size, 4096 --> 1024

ISTR reading somewhere, that this has a bad impact on performance.

The other thing that I don't like, is the performance of the RAID
array.  The disks individually give ~40 MB/s read speed, but the array
only measures 25 MB/s.  I was of the impression, that RAID5 would give
read speeds at least equal to the underlying disks.  Is this
incorrect?

-- 
Måns Rullgård
mru@users.sf.net

