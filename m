Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262772AbTJUKkz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 06:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262798AbTJUKky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 06:40:54 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:57688 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262772AbTJUKkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 06:40:53 -0400
To: Hans Reiser <reiser@namesys.com>
Cc: Larry McVoy <lm@bitmover.com>, Norman Diamond <ndiamond@wta.att.ne.jp>,
       Wes Janzen <superchkn@sbcglobal.net>,
       Rogier Wolff <R.E.Wolff@BitWizard.nl>,
       John Bradford <john@grabjohn.com>, linux-kernel@vger.kernel.org,
       nikita@namesys.com, Pavel Machek <pavel@ucw.cz>,
       Justin Cormack <justin@street-vision.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Vitaly Fertman <vitaly@namesys.com>, Krzysztof Halasa <khc@pm.waw.pl>
Subject: Re: Blockbusting news, results are in
References: <1c6401c395e7$16630d00$3eee4ca5@DIAMONDLX60>
	<20031019041553.GA25372@work.bitmover.com>
	<3F924660.4040405@namesys.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 21 Oct 2003 04:31:57 -0600
In-Reply-To: <3F924660.4040405@namesys.com>
Message-ID: <m1he226fvm.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser <reiser@namesys.com> writes:

> Larry McVoy wrote:
> 
> >
> >
> >I've told you guys over and over that you need to CRC the data in user
> >space, we do that in our backup scripts and it tells us when the drives
> >are going bad.  S
> >
> Why do the CRC in user space, that requires modifying every one of 7000+
> applications (if I understand you correctly, which is far from a sure thing;-)
> )?

End to end data integrity checking is a requirement.  Otherwise errors
happen silently and you rarely if ever see them.  And the error checking
must be end to end because you cannot trust the other layers to work
properly 100% of the time.

However to actually track down errors to root causes of errors, the closer
you can have your error checking to the hardware the better.  So having
CRC data or similar in the filesystem for both the metadata and the
file information is a good thing.

> Write a reiser4 CRC file plugin.  It would take a weekend, and most of the work
> would be cut and pasting from the default file plugin..  I understand why you do
> it in BK, but for user space as a whole user space is the wrong
> place.

Error checking should not be necessary for casual files that you don't
really care about but for times when you care about the integrity of
your data the application should be checking it.

Eric
