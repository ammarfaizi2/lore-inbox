Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161901AbWJDSMK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161901AbWJDSMK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 14:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161546AbWJDSMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 14:12:10 -0400
Received: from gundega.hpl.hp.com ([192.6.19.190]:54729 "EHLO
	gundega.hpl.hp.com") by vger.kernel.org with ESMTP id S1161901AbWJDSMI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 14:12:08 -0400
Date: Wed, 4 Oct 2006 11:10:32 -0700
To: Linus Torvalds <torvalds@osdl.org>
Cc: "John W. Linville" <linville@tuxdriver.com>, Jeff Garzik <jeff@garzik.org>,
       jt@hpl.hp.com, Lee Revell <rlrevell@joe-job.com>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       Norbert Preining <preining@logic.at>, hostap@shmoo.com,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       johannes@sipsolutions.net
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
Message-ID: <20061004181032.GA4272@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <1159807483.4067.150.camel@mindpipe> <20061003123835.GA23912@tuxdriver.com> <1159890876.20801.65.camel@mindpipe> <Pine.LNX.4.64.0610030916000.3952@g5.osdl.org> <20061003180543.GD23912@tuxdriver.com> <4522A9BE.9000805@garzik.org> <20061003183849.GA17635@bougret.hpl.hp.com> <4522B311.7070905@garzik.org> <20061003214038.GE23912@tuxdriver.com> <Pine.LNX.4.64.0610031454420.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610031454420.3952@g5.osdl.org>
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
User-Agent: Mutt/1.5.9i
From: Jean Tourrilhes <jt@hpl.hp.com>
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: jt@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2006 at 02:59:16PM -0700, Linus Torvalds wrote:
> 
> 
> On Tue, 3 Oct 2006, John W. Linville wrote:
> >
> > I.E.  With "WE-21 aware" tools already in the wild, it isn't now clear
> > to me how WE can evolve any further than WE-20.
> 
> Well, if you get a WE-22 out soon enough, the situation will be one where 
> people who are fast at updating will have a fixed version quickly, and the 
> ones that aren't quick at updating will never have even seen the broken 
> case.

	Linus,

	You can't froze kernel userspace API forever. That is simply
not workable, it will lead to stagnation and obsolescence. This is
especially unfair because some other kernel userspace API are allow to
change whenever their maintainers feels like.

	Just to give you an example why we sometime need to
change. The first two generations of 802.11 hardware were using the
ESSID as a C-string (no NUL char), so the API was also using a
C-string (no NUL char). New 802.11 hardware do accept NUL in the
ESSID, therefore the API need to evolve away from C-string to offer
this new feature to userspace. Especially that new WPA standard may
use that in the future (cf. Jouni's e-mail).

	In the past, kernel userspace API changes were done during the
devel series, but we don't have this option anymore. What I would like
people to discuss is what are the best practice to perform kernel
userspace API changes in 2.6.X.
	I personally thought that I went beyond the usual practice by
waiting 6 months, auditing all userspace and making sure the bits had
propagated to distro. And let's not forget that the tools warn users
about API mismatch.
	If you feel we need 1 more month, that's perfectly ok with all
of us. If your target is that some specific distros ship with
compatible userspace, I can personally monitor that and report. You
may want to be a bit more explicit in your standards, that would help
all of us doing a better job.

	Have fun...

	Jean
