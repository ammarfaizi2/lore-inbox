Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965398AbWKDUAE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965398AbWKDUAE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 15:00:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965606AbWKDUAB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 15:00:01 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:7021 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S965398AbWKDUAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 15:00:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=PkTAuDoOEcDE1MdDtqcDdcx/THAOkLn2ukh27B6axKe0u4ndKLtShyyIPnkQG73HJcKhjnhOoCQxx/AVMU321CpnxytfM5TID7lte6OKYLJjetk55kqWL/DBO+nGOJ3OD03k+hPsLAC+6vmbxyiQmHTxNRsaVp6giY3u+s+dl+Q=
Message-ID: <787b0d920611041159y6171ec25u92716777ce9bea4a@mail.gmail.com>
Date: Sat, 4 Nov 2006 14:59:53 -0500
From: "Albert Cahalan" <acahalan@gmail.com>
To: kangur@polcom.net, mikulas@artax.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: New filesystem for Linux
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Re: New filesystem for Linux

kangur@polcom.net, mikulas@artax.karlin.mff.cuni.cz,
linux-kernel@vger.kernel.org


Grzegorz Kulewski writes:
> On Thu, 2 Nov 2006, Mikulas Patocka wrote:
>> As my PhD thesis, I am designing and writing a filesystem,
>> and it's now in a state that it can be released. You can
>> download it from http://artax.karlin.mff.cuni.cz/~mikulas/spadfs/
>
> "Disk that can atomically write one sector (512 bytes) so that
> the sector contains either old or new content in case of crash."

New drives will soon use 4096-byte sectors. This is a better
match for the normal (non-VAX!) page size and reduces overhead.

> Well, maybe I am completly wrong but as far as I understand no
> disk currently will provide such requirement. Disks can have
> (after halted write):
> - old data,
> - new data,
> - nothing (unreadable sector - result of not full write and disk
> internal checksum failute for that sector, happens especially
> often if you have frequent power outages).
>
> And possibly some broken drives may also return you something that
> they think is good data but really is not (shouldn't happen since
> both disks and cables should be protected by checksums, but hey...
> you can never be absolutely sure especially on very big storages).
>
> So... isn't this making your filesystem a little flawed in design?

It's equal to typical modern designs like JFS, NTFS, XFS, and Reiserfs.

It's much worse than ZFS, which doesn't even trust the filesystem
to not silently scramble the data.

It's a tad worse than various forms of ext2/ext3/ufs/ufs2, where a
fixed layout helps recovery. (ext2 lacks the atomic updates, but
it doesn't trust a bad shutdown either -- fsck will always run)

BTW, a person with disk recovery experience told me that drives
will sometimes reorder the sectors. Sector 42 becomes sector 7732,
sector 880880 becomes sector 12345, etc. The very best filesystems
can handle with without data loss. (for example, ZFS) Merely great
filesystems will at least recognize that the data has been trashed.
