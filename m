Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265030AbTFYUSZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 16:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265037AbTFYUSZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 16:18:25 -0400
Received: from ihemail1.lucent.com ([192.11.222.161]:14065 "EHLO
	ihemail1.firewall.lucent.com") by vger.kernel.org with ESMTP
	id S265030AbTFYURh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 16:17:37 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16122.1630.134766.108510@gargle.gargle.HOWL>
Date: Wed, 25 Jun 2003 16:30:22 -0400
From: "John Stoffel" <stoffel@lucent.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Willy Tarreau <willy@w.ods.org>, linux-kernel@vger.kernel.org,
       marcelo@conectiva.com.br, kpfleming@cox.net, stoffel@lucent.com,
       gibbs@scsiguy.com, green@namesys.com
Subject: Re: Undo aic7xxx changes (now rc7+aic20030603)
In-Reply-To: <20030625214221.2cd9613f.skraw@ithnet.com>
References: <20030509150207.3ff9cd64.skraw@ithnet.com>
	<41560000.1055306361@caspian.scsiguy.com>
	<20030611222346.0a26729e.skraw@ithnet.com>
	<16103.39056.810025.975744@gargle.gargle.HOWL>
	<20030613114531.2b7235e7.skraw@ithnet.com>
	<20030625191655.GA15970@alpha.home.local>
	<20030625214221.2cd9613f.skraw@ithnet.com>
X-Mailer: VM 7.14 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Stephan" == Stephan von Krawczynski <skraw@ithnet.com> writes:

Stephan> On Wed, 25 Jun 2003 21:16:55 +0200
Stephan> Willy Tarreau <willy@w.ods.org> wrote:

>> Hmmm no, you're right, I forgot about this case. I think that
>> access time or other time-dependant informations may change often
>> enough to make a big diff on checksums. I have no more idea at the
>> moment. Or perhaps tar to a disk file instead of the tape and check
>> that file :-/

Stephan> I have tried that already but never managed to get
Stephan> verification errors on tar archives written to disk.  Maybe I
Stephan> try again some more...

I've been trying to get tar errors myself, while writing a 35gb
filesystem to a DLT7000.  I'm now running 2.4.21-pre5-ac1 and I
haven't seen any errors.  Yet.  I'm using the 6.2.8 version of the
driver as well.  The filesystem is just a copy of my home directory
and some MP3s and other random files and such.  Lots of text and jpegf
files, along with some other stuff. 

Maybe I need to try and generate 15-18 files 2gb+ each and dump them
to tape with tar and see how that's handled, and if we get erorrs.

Stephan, can you double check your version info as well?  And it would
be great to get some info on your 3ware setup as well, just so we can
work on narrowing down the issues.

Unfortunately, due to the way I have to setup things, the RAID array
and the tape drive are on the same channel, which slows down things
I'm sure.  

Here are some timings from dumping and verifying the data to tape:

  jfsnew:/# time tar -c-W -b 128 -f /dev/st0 /scratch
  tar: Removing leading `/' from member names
  408.840u 869.730s 4:03:02.80 8.7%       0+0k 0+0io 258pf+0w

  jfsnew:/# time tar -c-W -b 256 -f /dev/st0 /scratch
  tar: Removing leading `/' from member names
  443.210u 1104.930s 4:07:00.89 10.4%     0+0k 0+0io 264pf+0w

My filesystem is a as follows:

  jfsnew:/home# mdadm -D /dev/md1
  /dev/md1:
	  Version : 00.90.00
    Creation Time : Mon Jun 23 22:51:43 2003
       Raid Level : raid0
       Array Size : 44457600 (42.40 GiB 45.57 GB)
     Raid Devices : 5
    Total Devices : 5
  Preferred Minor : 1
      Persistence : Superblock is persistent

      Update Time : Mon Jun 23 22:51:43 2003
	    State : dirty, no-errors
   Active Devices : 5
  Working Devices : 5
   Failed Devices : 0
    Spare Devices : 0

       Chunk Size : 64K

      Number   Major   Minor   RaidDevice State
	 0       8       48        0      active sync   /dev/sdd
	 1       8       64        1      active sync   /dev/sde
	 2       8       80        2      active sync   /dev/sdf
	 3       8       96        3      active sync   /dev/sdg
	 4       8      112        4      active sync   /dev/sdh
	     UUID : ffa7efb1:1c151f2d:4f6a138c:77085f29

