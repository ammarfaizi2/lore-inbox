Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262078AbTJNJrW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 05:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262099AbTJNJrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 05:47:12 -0400
Received: from users.linvision.com ([62.58.92.114]:57496 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S262078AbTJNJqe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 05:46:34 -0400
Date: Tue, 14 Oct 2003 11:46:30 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Hans Reiser <reiser@namesys.com>
Cc: John Bradford <john@grabjohn.com>, Rogier Wolff <R.E.Wolff@BitWizard.nl>,
       Wes Janzen <superchkn@sbcglobal.net>, linux-kernel@vger.kernel.org
Subject: Re: Why are bad disk sectors numbered strangely, and what happens to them?
Message-ID: <20031014094629.GA16683@bitwizard.nl>
References: <32a101c3916c$e282e330$5cee4ca5@DIAMONDLX60> <200310131014.h9DAEwY3000241@81-2-122-30.bradfords.org.uk> <33a201c39174$2b936660$5cee4ca5@DIAMONDLX60> <20031014064925.GA12342@bitwizard.nl> <3F8BA037.9000705@sbcglobal.net> <200310140721.h9E7LmNE000682@81-2-122-30.bradfords.org.uk> <20031014074020.GC13117@bitwizard.nl> <200310140811.h9E8Bxq1000831@81-2-122-30.bradfords.org.uk> <3F8BB7AE.2040507@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F8BB7AE.2040507@namesys.com>
User-Agent: Mutt/1.3.28i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 14, 2003 at 12:45:34PM +0400, Hans Reiser wrote:
> Perhaps we should tell people to first write to the bad block, and only 
> if the block remains bad after triggering the remapping by writing to it 
> should you make any effort to get the filesystem to remap it for you.  
> What do you think?
> 
> Rogier has not indicated that he has tried writing to the bad sector, 
> has he?

Hans, 

I simply refuse to try to trigger a remapping by writing to the
sector. A couple of things can happen:

1) The write succeeds on the "bad" spot. The "normal" write doesn't
do a "veriy-after-write", so the write might simply be succeeding, 
resulting in an immediate data-loss (which might be masked if I try
to reread the data from userspace bacause the data is still cached!)

2) the realloc might succeed, hiding the fact that my drive just lost
0.5k bytes of my data. I mean, there was SOME data there. Linux
wouldn't try to be reading it if it had never been written, right?  A
drive that refers my data to /dev/null should be diverted there
itself.

Of course, I left my drive that indicated it had problems (i.e. it
didn't spot the sector going bad before it became unreadable), in the
machine for another two days. It's getting replaced ASAP (i.e. the
next hour or so).

The bad sector developed in a backup of data that is still running
hapilly on another machine. But I'm not risking a sector getting
assigned some important data going bad next time I notice something.

			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
**** "Linux is like a wigwam -  no windows, no gates, apache inside!" ****
