Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262119AbSIPPZF>; Mon, 16 Sep 2002 11:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262081AbSIPPZF>; Mon, 16 Sep 2002 11:25:05 -0400
Received: from b114225.adsl.hansenet.de ([62.109.114.225]:22788 "EHLO
	smaug.lan.local") by vger.kernel.org with ESMTP id <S261401AbSIPPZE>;
	Mon, 16 Sep 2002 11:25:04 -0400
Message-ID: <XFMail.20020916172958.f.hinzmann@hamburg.de>
X-Mailer: XFMail 1.5.2 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
In-Reply-To: <1032187595.1285.13.camel@irongate.swansea.linux.org.uk>
Date: Mon, 16 Sep 2002 17:29:58 +0200 (CEST)
From: Florian Hinzmann <f.hinzmann@hamburg.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: DMA problems w/ PIIX3 IDE, 2.4.20-pre4-ac2
Cc: Jan-Hinnerk Reichert <jan-hinnerk_reichert@hamburg.de>
Cc: Jan-Hinnerk Reichert <jan-hinnerk_reichert@hamburg.de>,
       linux-kernel@vger.kernel.org, Andre Hedrick <andre@linux-ide.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alan!


On 16-Sep-2002 Alan Cox wrote:
> On Mon, 2002-09-16 at 15:26, Florian Hinzmann wrote:
>> 
>> On 16-Sep-2002 Alan Cox wrote:
>> > On Mon, 2002-09-16 at 12:17, Florian Hinzmann wrote:
>> >> kernel: hdb: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
>> >> kernel: hdb: read_intr: error=0x10 { SectorIdNotFound }, LBAsect=97567071, high=5, lo
>> >> kernel: hdb: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
>> > 
>> > Which is the drive reporting a physical media error
>> 
>> Which seems to exist only while using the named combinations of DMA access
>> and kernel versions. While using i.e. 2.4.19 without DMA I can access the same data,
>> dd the whole disk to /dev/null or run badblock checks without finding
>> any physical media errors.
>> 
>> 2.4.19 should complain, too, if there is a physical error indeed, right?
> 
> The "sectoridnotfound" return is from the drive. That makes it very hard
> to believe it isnt a physical error

This is what makes me believe it:

- I get "SectorIdNotFound" with differing sector numbers at three physical hard disk drives.
  At least two of this drives are not very old. One of them was bought only a few weeks
  ago.
- I had several occasions where I got this error while copying one given file. After rebooting
  (the same kernel with the same settings) accessing the same file was fine. 
- I can reproduce this errors starting to copy random groups of files from that disks
  within one or two minutes. That makes me think it is not one special area at the disk(s).
  On the other hand I can start several copy commands at once using the same commands
  as before without getting any errors with i.e. 2.4.19 without DMA. It is running then
  running stable for a long time (I think I tried times up to one hour).


My BIOS doesn't like disks larger than 32GB. Therefore the three disks are jumpered to
appear as 32GB (Maxtor disks) and I am using setmax resp. CONFIG_IDEDISK_STROKE to 
unclip them. 
Maybe this setup has something to do with the possibly bogus SectorIdNotFound message?


I am eager to sort this out. I would like to do the following:

- First, prove the drives don't have physical media errors. Is running "e2fsck -c" 
  sufficient? Do you have other suggestions to stress test my drives?

- Second, try hard to exclude other possible reasons for my drive returning that
  message. 
  While digging the archives I found one mail stating an old/broken/weak power supply
  caused that messages and a new one made them go away. I have already built in 
  a stronger and newer power supply - it did not change anything. 
  I changed nearly every part of that box in the past. Any ideas what else might 
  produce this errors? Too much heat? Cabling?

- Third, take a look at the software again. Is there anything I could try to help
  debugging this, i.e. trying every -ac release since 2.4.19 and find out which
  version is the first with this errors?


I would highly appreciate some guidance as I am trying to solve this for
months now and I am somehow aimless at this point.


  Regards
      Florian


--
  Florian Hinzmann                         private: f.hinzmann@hamburg.de
                                            Debian: fh@debian.org
PGP Key / ID: 1024D/B4071A65
Fingerprint : F9AB 00C1 3E3A 8125 DD3F  DF1C DF79 A374 B407 1A65
