Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262327AbTJSWuM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 18:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbTJSWuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 18:50:12 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:39433 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S262327AbTJSWuF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 18:50:05 -0400
Date: Sun, 19 Oct 2003 15:49:52 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Hans Reiser <reiser@namesys.com>, Larry McVoy <lm@bitmover.com>,
       Norman Diamond <ndiamond@wta.att.ne.jp>,
       Wes Janzen <superchkn@sbcglobal.net>,
       Rogier Wolff <R.E.Wolff@BitWizard.nl>,
       John Bradford <john@grabjohn.com>, nikita@namesys.com,
       Pavel Machek <pavel@ucw.cz>, Justin Cormack <justin@street-vision.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Vitaly Fertman <vitaly@namesys.com>, Krzysztof Halasa <khc@pm.waw.pl>,
       axboe@suse.de
Subject: Re: Blockbusting news, results are in
Message-ID: <20031019224952.GA7328@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org,
	William Lee Irwin III <wli@holomorphy.com>,
	Hans Reiser <reiser@namesys.com>, Larry McVoy <lm@bitmover.com>,
	Norman Diamond <ndiamond@wta.att.ne.jp>,
	Wes Janzen <superchkn@sbcglobal.net>,
	Rogier Wolff <R.E.Wolff@BitWizard.nl>,
	John Bradford <john@grabjohn.com>, nikita@namesys.com,
	Pavel Machek <pavel@ucw.cz>,
	Justin Cormack <justin@street-vision.com>,
	Russell King <rmk+lkml@arm.linux.org.uk>,
	Vitaly Fertman <vitaly@namesys.com>,
	Krzysztof Halasa <khc@pm.waw.pl>, axboe@suse.de
References: <1c6401c395e7$16630d00$3eee4ca5@DIAMONDLX60> <20031019041553.GA25372@work.bitmover.com> <3F924660.4040405@namesys.com> <20031019083551.GA1108@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031019083551.GA1108@holomorphy.com>
User-Agent: Mutt/1.3.27i
X-Message-Flag: This message may cause mental anguish to the close-minded. Read at your own risk.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 19, 2003 at 01:35:51AM -0700, William Lee Irwin III wrote:
> Larry McVoy wrote:
> >> I've told you guys over and over that you need to CRC the data in user
> >> space, we do that in our backup scripts and it tells us when the drives
> >> are going bad.  S
> 
> On Sun, Oct 19, 2003 at 12:08:00PM +0400, Hans Reiser wrote:
> > Why do the CRC in user space, that requires modifying every one of 7000+ 
> > applications (if I understand you correctly, which is far from a sure 
> > thing;-) )?
> > Write a reiser4 CRC file plugin.  It would take a weekend, and most of the 
> > work would be cut and pasting from the default file plugin..  
> > I understand why you do it in BK, but for user space as a whole user space 
> > is the wrong place.
> 
> I think the fs driver layer might be the wrong thing too; maybe it'd be
> best to do the CRC and/or checksumming at the block layer?

Or even better, do it on the disk controller strapped to the
physical disk so you can hide the fact that CRCs add data
overhead for every block making them longer than 2^n and can
use a CRC with optimised for the type of errors most common
on the media.  Wait, that is where it is already being done.

What is apparently missing is better handling of the
uncorrectable errors.  Specifically the ability to pass the
errors and warnings up to the OS for evaluation and for the
OS to be able to request a block remap or to undo a block
remap.

I'd guess that most of Hans' errors are not coming from
spinning media but from tranmission errors on the HD cables
and system busses, and from undetected memory errors.


-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
