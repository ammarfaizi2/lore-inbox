Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274269AbRIYALN>; Mon, 24 Sep 2001 20:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274273AbRIYALE>; Mon, 24 Sep 2001 20:11:04 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:59666 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S274269AbRIYAKx> convert rfc822-to-8bit; Mon, 24 Sep 2001 20:10:53 -0400
Date: Tue, 25 Sep 2001 02:11:13 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: [PATCH] 2.4.10 improved reiserfs a lot, but could still be better
Message-ID: <20010925021113.B22073@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	reiserfs-list@namesys.com
In-Reply-To: <B0005839269@gollum.logi.net.au> <20010924161518.KYHD11251.femail27.sdc1.sfba.home.com@there> <20010924185303.B10117@emma1.emma.line.org> <20010924200537.SRVB23487.femail38.sdc1.sfba.home.com@there>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20010924200537.SRVB23487.femail38.sdc1.sfba.home.com@there>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Sep 2001, Nicholas Knight wrote:

> Would you like to read the rest of my message please? Cheap UPS's can 
> provide protection against power failures. If your data is that 
> valuble, you can afford a cheap UPS to give you 5 minutes to shut down.

No UPS can protect you from system crashes. The problem is, with the
drive cache on, the drive will acknowledge having written the data early
and reorder its writes, but who makes guarantees it can write its whole
2 MB to disk should the power fail? No-one. ATA6 drafts have a NOTE that
says, the FLUSH CACHE command may take longer than 30 s to complete.

Journalling File systems don't get you anywhere if the drive reorders
its blocks before the write (I presume, most will do), they may instead
turn the whole partition to junk without notice, because any assumptions
as to the on-disk structure don't hold.

> > Linear writing as dd mostly does is BTW something which should never
> > be affected by write caches.
> 
> Explain the numbers then.

I can't, any explanation right now would be conjecture. I can reproduce
the numbers on my IBM DTLA-307045 (Promise) and on my Western Digital
CAC420400D (VIA KT133, the disk looks like an IBM DJNA-352030 OEM,
though).

However, would you care to elaborate how switching OFF the cache should
harm data, provided you don't need to cater for power outages (UPS
attached, e. g.)?

hdparm:

"       -W     Disable/enable the IDE drive's  write-caching  fea­
              ture (usually OFF by default)."

> I followed *YOUR* instructions for disabling write caching.

No-one doubts you did. I said it's weird that the drive write cache has
an impact on dd figures. It may be worthwhile to investigate this, but
again, any try to explain this would be a guess.

It may be an implementation problem in our IBM drives which ship with
their write caches enabled, someone please do this test on current
Fujitsu, Maxtor or Seagate IDE drives or with different controllers.

It would suffice if the kernel could flush the drive's buffers on
fsync() and other synchronous operations, but a flush command has only
recently appeared in the ATA standards, as it seems. I only have drafts
here, ATA 3 draft rev. 6 did not offer any command to flush the cache,
ATA 6 draft makes it mandatory for all devices that do offer a PACKET
interface. Not sure about the actual ATA 3, 4, or 5 standards.

Why are disk drives slower with their caches disabled on LINEAR writes?

-- 
Matthias Andree

"Those who give up essential liberties for temporary safety deserve
neither liberty nor safety." - Benjamin Franklin
