Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314042AbSDKNFt>; Thu, 11 Apr 2002 09:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314043AbSDKNFs>; Thu, 11 Apr 2002 09:05:48 -0400
Received: from c5cust8.starstream.net ([206.170.161.8]:13964 "HELO
	10cust182.starstream.net") by vger.kernel.org with SMTP
	id <S314042AbSDKNFs>; Thu, 11 Apr 2002 09:05:48 -0400
Date: Thu, 11 Apr 2002 06:05:44 -0700
From: Ted Deppner <ted@psyber.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Jens Axboe <axboe@suse.de>, Martin Dalecki <martin@dalecki.de>,
        Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org,
        Hans Reiser <reiser@namesys.com>
Subject: Re: New IDE code and DMA failures
Message-ID: <20020411130544.GA8163@dondra.ofc.psyber.com>
Reply-To: Ted Deppner <ted@psyber.com>
Mail-Followup-To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
	Jens Axboe <axboe@suse.de>, Martin Dalecki <martin@dalecki.de>,
	Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org,
	Hans Reiser <reiser@namesys.com>
In-Reply-To: <200204111236.g3BCaMX10247@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2002 at 03:39:33PM -0200, Denis Vlasenko wrote:
> I have a flaky IDE subsystem in one box. Reads work fine,
> writes sometimes don't work and hang either IDE/block device
> 
> Please inform me whenever you want me to test your patches.

I've been testing 2.4.17 and 2.4.19-pre6 and see some similar issues.  I
have an Asus A7V w/ 1gig Athlon processor.  Using the onboard Promise
UDMA100 controller, I can read and write all day long to /dev/hde all by
itself...  However, after few minutes of any type of access to /dev/hdh,
/dev/hde suddenly starts having DMA errors and switches to PIO.  I'm on my
third DMA66 cable (yet it fights tightly), and am still seeing the exact
same issues.  I don't believe my IDE subsystem to be flaky.  hde is a WD
drive, and hdh is a Maxtor.

In one of my tests the contents /dev/hdh was additionally corrupted (a
write test to /dev/hdh1) so badly that the partion information changed
from type 83 to type 3 (Xenix), and the contents of a reiser partition so
badly damaged that a --rebuild-tree and later a --rebuild-sb to reiserfsck
didn't restore it to usable. (I put those options in at the request of
reiserfsck, and I haven't wiped the drive yet if someone would like
further tests against the reiserfs partition).

-- 
Ted Deppner
http://www.psyber.com/~ted/
