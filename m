Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753961AbWKGPVo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753961AbWKGPVo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 10:21:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753973AbWKGPVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 10:21:44 -0500
Received: from mail1.key-systems.net ([81.3.43.253]:40429 "HELO
	mailer2-1.key-systems.net") by vger.kernel.org with SMTP
	id S1753961AbWKGPVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 10:21:43 -0500
Message-ID: <4550A481.2010408@scientia.net>
Date: Tue, 07 Nov 2006 16:21:37 +0100
From: Christoph Anton Mitterer <calestyo@scientia.net>
User-Agent: Icedove 1.5.0.7 (X11/20061014)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Strange write errors on FAT32 partition (maybe an FAT32 bug?!)
Content-Type: multipart/mixed;
 boundary="------------020302020502020006080903"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020302020502020006080903
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi.

I've got a very strange problem which I'm going to try to explain here
in detail.
As one could easily suppose that issue results from hardware problems
I'm going to explain it very very detailed because the facts let me
think that my hardware is ok (unfortunately I've got no other computer
to try to reproduce the problem).

I'm archiving my personal CD-DA collection and for that reason I had to
install Windows (yes I feel very ugly ;-) ) because I wanted to use EAC
(Exact Audo Copy) for that, due to its superior features.

So I've installed Windows XP (on NTFS) and created on additional FAT32
partition to store the extracted audio.
I did several badblock scans in addition to long SMART checks on the
whole drive, so the disc should be ok.

When extracting (under Windows): I extracted each CD twice,.. so
Windows/WAC should write exactly the same data for each CD twice to the
FAT32 partition.
This is important because I think, that if there would be errors in the
drive/FAT32 filesystem/RAM/CPU it would be likely that these files are
_not_ equal.

After ripping about 20 CDs I went back to linux and wanted to compare
the pairs of extracted data (originally I did that just to find any
errors in the ripping process).
Before doing anything I wrote sha512sums for all files.

At some point (I did that procedure for every CD) I've copied (cp -a)
the directory with all data for that CD to a temporary location on the
FAT32 partition.
Right after that, I've diffed the whole stuff (diff -q -r dirA dirB).
And there were differences in one file!!!
I copied again diffed again,.. and differences again (but in another file).

First of all I've thought that this would be an hardware issue. I
supposed the RAM could be damaged because diff would use probably the
cached data from the files I've had just copied.
So I did excessive memtests (memtest86+) for several hours/passes. But
no errors have been found in my 4GB ECC/Reg RAMs.
So I supposed it could be a CPU related problem (2x DualCore Opteron
275) and I've startet an mprime/gimps torture test on each core and let
it run for 16 hours with no errors at all.

Some days later I had the same or at least a very equal problem.
I copied,... diffed,.. but this time _no_ differences.
I restartet the system (thus the file cache was cleard)... diffed
again,.. and know differences!! This was also a reason to not believe
that my RAM is defect but the writing to the FAT32 disc.

Ok,... the original files written by Windows/EAC seem to be ok and never
changed or corrupted. Why? First of all, the sha512sums are still equal,
but one could say, that the data was already damaged when calculating
those hashes.
But EAC stores internally a hash (some CRCxx) which is (afaik)
calculated from data from the RAM. So if the RAMs are ok (and I suppose
that because of my memtests) the hashes should be correct, too.

I compared those EAC hashes with the original data and all data seem to
be correct.

So this is as far as I can say,.. only a Linux/FAT32 related problem, as
the data written by Windows seems to be correct.
And as I've said, I'm pretty sure my hardware is correct, too.

The strange thing is that one time the differences were found directly
after copying (thus one would thing RAM is damaged, because the data was
probalby (I cannot tell this for sure) taken from file cache).
and the other time after restarting with a certainly empty file cache.


Any ideas? I'm willing to help debugging and so on but I must admit that
I need someone to say me what to do :D

btw:
my system:
Debian sid (which should be unimportant)
kernel 2.6.18.2

For further data please ask :)


Thanks in advance,
Chris.

--------------020302020502020006080903
Content-Type: text/x-vcard; charset=utf-8;
 name="calestyo.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="calestyo.vcf"

YmVnaW46dmNhcmQNCmZuOk1pdHRlcmVyLCBDaHJpc3RvcGggQW50b24NCm46TWl0dGVyZXI7
Q2hyaXN0b3BoIEFudG9uDQplbWFpbDtpbnRlcm5ldDpjYWxlc3R5b0BzY2llbnRpYS5uZXQN
CngtbW96aWxsYS1odG1sOlRSVUUNCnZlcnNpb246Mi4xDQplbmQ6dmNhcmQNCg0K
--------------020302020502020006080903--
