Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286687AbRL1CGn>; Thu, 27 Dec 2001 21:06:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286692AbRL1CGd>; Thu, 27 Dec 2001 21:06:33 -0500
Received: from noodles.codemonkey.org.uk ([62.49.180.5]:63945 "EHLO
	noodles.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id <S286687AbRL1CGP>; Thu, 27 Dec 2001 21:06:15 -0500
Date: Fri, 28 Dec 2001 02:06:45 +0000
From: Dave Jones <davej@suse.de>
To: "Kevin P. Fleming" <kevin@labsysgrp.com>
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
        andre@linux-ide.org, axboe@suse.de
Subject: Re: [PATCH] ide-probe does not set removable flag for ide-floppy devices
Message-ID: <20011228020645.A10548@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	"Kevin P. Fleming" <kevin@labsysgrp.com>, marcelo@conectiva.com.br,
	linux-kernel@vger.kernel.org, andre@linux-ide.org, axboe@suse.de
In-Reply-To: <009c01c1842a$d281f670$6caaa8c0@kevin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <009c01c1842a$d281f670$6caaa8c0@kevin>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2001 at 04:06:39PM -0700, Kevin P. Fleming wrote:
 > Small patch, relative to 2.4.17-pre8, but should apply to any recent version
 > 
 > diff -urN -X dontdiff linux/drivers/ide/ide-probe.c
 > linux-new/drivers/ide/ide-probe.c
 > --- linux/drivers/ide/ide-probe.c Wed Dec 12 11:01:24 2001
 > +++ linux-new/drivers/ide/ide-probe.c Sun Dec  9 11:41:15 2001
 > @@ -122,6 +122,7 @@
 >        printk("cdrom or floppy?, assuming ");
 >       if (drive->media != ide_cdrom) {
 >        printk ("FLOPPY");
 > +      drive->removable = 1;
 >        break;
 >       }
 >      }

<nitpick old mails time>
To me, this looks like it would make more sense to set this to 1 _before_
the switch statement, and set to 0 as necessary, as most of the cases
look removable to me. Should cut out a few lines of code, and also mark
things like ide-tape as removable in the process too. Or is this not
desired behaviour for some reason ?

Dave.

-- 
Dave Jones.                    http://www.codemonkey.org.uk
SuSE Labs.
