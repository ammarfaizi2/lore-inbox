Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbUALXEb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 18:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbUALXEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 18:04:31 -0500
Received: from ip213-185-39-113.laajakaista.mtv3.fi ([213.185.39.113]:50565
	"HELO dag.newtech.fi") by vger.kernel.org with SMTP id S261744AbUALXET
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 18:04:19 -0500
Message-ID: <20040112230418.12856.qmail@dag.newtech.fi>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-0.27
To: linux-kernel@vger.kernel.org
Subject: Re: Added disk activity from 2.6.0 to 2.6.1
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 13 Jan 2004 01:04:18 +0200
From: Dag Nygren <dag@newtech.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Mon, Jan 12, 2004 at 02:22:04PM -0500, Tim Shepard wrote:
> > 
> > > > some days ago I installed 2.6.1 here and immediately
> > > > noticed a slower bootup time.
> > > > The disk during boot is also very much  showing a lot more
> > > > activity.
> > > > And the same when starting up a new program.
> > > > Was there a change that explains this?
> > > > 
> > > > I just reinstalled 2.6.0 and everything went back to being
> > > > quite peaceful.
> > > 
> > > Run "vstat 1" while you're seeing the problem with 2.6.1, and post it here.
> > 
> > I just spent about 5 minutes trying to figure out what the "vstat"
> > program is.  I've concluded that there's no such thing and that you
> > must have meant "vmstat" (just a typo away).
> > 
> 
> That's right, vmstat, sorry.

I sort of guessed that ;-)

Anyway, I tested a bit and the results shows interesting
differences:

vmstat 1 when starting knode on 2.6.0:

procs                      memory      swap          io     system         cpu
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy wa id
 0  0      0 161556  54636 170172    0    0   344   395  600   343 22  8 32 38
 0  1      0 159020  54652 171788    0    0  1464     0 1140   893  4  2 13 82
 1  0      0 156668  54652 173420    0    0  1600     0 1081   774 29  9 14 49
 1  0      0 156540  54656 173416    0    0     4     0 1027   379 40 10  0 49
 1  0      0 156540  54656 173416    0    0     0     0 1003   386 41  9  0 49
 0  3      0 156476  54708 173432    0    0     0  4936 1174   414 22  9 48 22
 0  3      0 156476  54708 173432    0    0     0  2072 1273   425  1  1 99  0
 0  2      0 156476  54712 173428    0    0     0   332 1230   481  1  0 96  3
 0  1      0 155252  54916 173428    0    0   112  1204 1202  1481 21  4 35 40
 0  0      0 153924  54996 173688    0    0    96     0 1029  2797 36  6  5 54
 0  0      0 153924  54996 173688    0    0     0     0 1167  1126  5  1  0 94
 0  0      0 153916  55004 173680    0    0     8     0 1157  1193  7  2  0 92
 0  0      0 156916  55040 173712    0    0     4     0 1096  1437 16  6  0

and the same situation on 2.6.1

procs                      memory      swap          io     system         cpu
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy wa id
 0  0      0 148312  56644 176052    0    0   280   317  589   325 17  7 26 49
 0  1      0 144232  56660 178484    0    0  2304   120 1234  1022  5  4 28 64
 1  0      0 142832  56660 179232    0    0   756     0 1097   855 35 10  7 48
 1  0      0 142832  56660 179232    0    0     0     0 1066   433 41 11  0 49
 1  0      0 142832  56660 179232    0    0     0     0 1046   437 41 10  0 49
 0  3      0 142768  56680 179280    0    0    24  4904 1226   575 26  8 31 36
 0  3      0 142688  56812 179284    0    0    24  2212 1332   534  3  1 97  0
 0  1      0 142624  56816 179280    0    0     0   852 1281   561  2  1 93  5
 1  0      0 141024  56916 179520    0    0    76   524 1192  1619 20  5 50 26
 0  0      0 140624  56968 179536    0    0    68     0 1064  2486 27  4  3 65
 0  0      0 140624  56968 179604    0    0     0     0 1204  1022  4  1  0 95
 0  0      0 140624  56976 179596    0    0     0    28 1088   546  2  0  1 97
 0  0      0 140624  56984 179588    0    0     8     0 1167   970  7  2  0 92
 0  0      0 140496  57164 179612    0    0     0   708 1164   567  1  0 21 77
 0  0      0 140544  57164 179612    0    0     0     0 1049   475  1  0  0 99
 2  0      0 140480  57212 179564    0    0     8     0 1055  1264 15  4  1 81
 0  0      0 143480  57212 179564    0    0     0     0 1157  1028  6  2  0 92
 0  0      0 143480  57224 179552    0    0     4    20 1171   715  3  1  2 95
 0  1      0 143432  57352 179560    0    0     0   136 1170  1100  6  3  1 89
 0  0      0 143432  57352 179560    0    0     0   188 1092   545  1  1 11 88
 0  0      0 143432  57352 179560    0    0     0     0 1182   701  2  1  0 97
 0  0      0 143432  57352 179560    0    0     0     0 1070   568  1  0  0 98

I chose knode as this seemed to generate most of the strange
diskactivity.

AFAIK the difference is that 2.6.1 will overlap IN and OUT activities
better than 2.6.0 thus generating more seeks (explains the different
sounding disks) and worse alltogether performance.

I also did some more experiments with starting konqueror, which
shows similar behaviour.

The boot times from /var/log/boot.log
2.6.0 takes 24 seconds
2.6.1 takes 26 seconds

That means that the difference isn't that big, it just _feels_
longer because of the furious diskactivity.

Another "feeling" is that 2.6.0 is more interactively responsive,
no proof for that though.

> > I've not yet used any USB disks on 2.6.1, but I noticed some
> > variability of USB disk performance on earlier 2.6.0-test* kernels.
> > Are any USB disks involved in your 2.6.1 observations?  For that
> > matter, what type of disks are involved in your 2.6.1 observations:
> > USB, SCSI, or IDE/ATAPI?  And what type of file systems (ext2 or ext3
> > or ?)?

No USB.
Most of the filesystems are reiserfs, but the rootfs is ext3

Was there a significant change in the resiserfs code ?

BRGDS
Dag


