Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130541AbRCDXaf>; Sun, 4 Mar 2001 18:30:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130544AbRCDXa0>; Sun, 4 Mar 2001 18:30:26 -0500
Received: from tetsuo.zabbo.net ([204.138.55.44]:50191 "HELO tetsuo.zabbo.net")
	by vger.kernel.org with SMTP id <S130541AbRCDXaS>;
	Sun, 4 Mar 2001 18:30:18 -0500
Date: Sun, 4 Mar 2001 18:30:17 -0500
From: Zach Brown <zab@zabbo.net>
To: linux-kernel@vger.kernel.org
Subject: [CFT] maestro update vs 2.2.18
Message-ID: <20010304183017.A19760@tetsuo.zabbo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I finally spent some time fixing up the maestro driver.  lots of
feature additions had backed up, and the source was rotting.  Its still
gross, but at least its cleaned up a bit.  "It works for me" on my
pentium with an ESS maestro2 engineering board, but laptops will be
another story entirely.  I'd love it if people could apply this patch to
vanilla 2.2.18 and let me know how it goes.  

The patch does a few things.  Most interestingly for the user, it moves
away from the model of having multiple /dev/dsp? files and instead allows
/dev/dsp to be opened concurrently.  It also adds some support for the
hardware volume buttons on laptops, but not all vendors wire this the same
way.  As I don't have a maestro-bearing laptop, this is totally untested.

The code is butchered, so the diff is almost illegible.  Perhaps I'll
learn and do things in stages next time, but I was on a roll :)  One
of the more notable changes involves using the kernel's ac97_codec
code rather than its own.  Hopefully this will result in better mixer
behaviour.

I'm particularly interested in hearing how suspend/resume functions,
whether or not the multi-open stuff works, and I'd like to get subvendor
IDs from people whose laptop's hardware volume buttons work.  See the
Documentation/sound/Maestro text for instructions on enabling multi-open
(channels=2 or 4) and hardware volume support (hw_vol=1).

Its an awfully large diff, so it can be fetched from:

	http://www.zabbo.net/maestro/patches/2.2.18-mega-1.diff.gz

if this works I'll officially submit it and make the same sorts of
changes to 2.4.  

-- 
 zach
