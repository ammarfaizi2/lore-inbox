Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263401AbTJQKYq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 06:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263411AbTJQKYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 06:24:46 -0400
Received: from users.linvision.com ([62.58.92.114]:20639 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S263401AbTJQKYn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 06:24:43 -0400
Date: Fri, 17 Oct 2003 12:24:36 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Norman Diamond <ndiamond@wta.att.ne.jp>
Cc: Hans Reiser <reiser@namesys.com>, Wes Janzen <superchkn@sbcglobal.net>,
       Rogier Wolff <R.E.Wolff@BitWizard.nl>,
       John Bradford <john@grabjohn.com>, linux-kernel@vger.kernel.org,
       nikita@namesys.com, Pavel Machek <pavel@ucw.cz>
Subject: Re: Blockbusting news, this is important (Re: Why are bad disk sectors numbered strangely, and what happens to them?)
Message-ID: <20031017102436.GB10185@bitwizard.nl>
References: <32a101c3916c$e282e330$5cee4ca5@DIAMONDLX60> <200310131014.h9DAEwY3000241@81-2-122-30.bradfords.org.uk> <33a201c39174$2b936660$5cee4ca5@DIAMONDLX60> <20031014064925.GA12342@bitwizard.nl> <3F8BA037.9000705@sbcglobal.net> <3F8BBC08.6030901@namesys.com> <11bf01c39492$bc5307c0$3eee4ca5@DIAMONDLX60>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11bf01c39492$bc5307c0$3eee4ca5@DIAMONDLX60>
User-Agent: Mutt/1.3.28i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 17, 2003 at 06:40:01PM +0900, Norman Diamond wrote:
> I explained to them why the LBA sector number should still get
> reallocated even though the data are lost.

This is unbelievably bad: Sometimes it is worth it, to try and read
the block again and again. We've seen blocks getting read after we've
retried over 1000 times from "userspace". That doesn't include the
retries that the drive did for us "behind the scenes". 

If you manage to convince Toshiba to remap the sector on a "bad read",
we'll never ever be able to recover the sector.

We've also been able to provide a different environment (e.g. other
ambient temperature) to a drive so that previously bad sectors could
be read.

No, the only way is to realloc on write. (but it should remember that
the data was bad, and treat the physical area with extra caution. It's
possible that something happened while writing that sector, so that
rewriting it this time will fix the problem for good, but on the other
hand, that area of the drive demonstrated the abilitty to lose data,
so you shouldn't trust any data to it!)

			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
**** "Linux is like a wigwam -  no windows, no gates, apache inside!" ****
