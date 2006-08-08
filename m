Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932180AbWHHM5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbWHHM5M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 08:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbWHHM5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 08:57:11 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:57092 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S932180AbWHHM5K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 08:57:10 -0400
Date: Tue, 8 Aug 2006 12:56:52 +0000
From: Pavel Machek <pavel@suse.cz>
To: Muli Ben-Yehuda <muli@il.ibm.com>
Cc: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
       Shem Multinymous <multinymous@gmail.com>, Robert Love <rlove@rlove.org>,
       Jean Delvare <khali@linux-fr.org>, Greg Kroah-Hartman <gregkh@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net
Subject: Re: [PATCH 04/12] hdaps: Correct readout and remove nonsensical attributes
Message-ID: <20060808125652.GA5284@ucw.cz>
References: <11548492171301-git-send-email-multinymous@gmail.com> <11548492543835-git-send-email-multinymous@gmail.com> <20060807140721.GH4032@ucw.cz> <41840b750608070930p59a250a4l99c07260229dda8e@mail.gmail.com> <20060807182047.GC26224@atjola.homenet> <20060808122234.GD5497@rhun.haifa.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060808122234.GD5497@rhun.haifa.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 08-08-06 15:22:34, Muli Ben-Yehuda wrote:
> On Mon, Aug 07, 2006 at 08:20:47PM +0200, Björn Steinbrink wrote:
> > On 2006.08.07 19:30:55 +0300, Shem Multinymous wrote:
> > > Hi Pavel,
> > > 
> > > On 8/7/06, Pavel Machek <pavel@suse.cz> wrote:
> > > >> +     int total, ret;
> > > >> +     for (total=READ_TIMEOUT_MSECS; total>0; total-=RETRY_MSECS) {
> > > >
> > > >Could we go from 0 to timeout, not the other way around?
> > > 
> > > Sure.
> > > (That's actually vanilla hdapsd code, moved around...)
> > 
> > Maybe you could convert that to sth. like this along the way?
> > 
> > int ret;
> > unsigned long timeout = jiffies + msec_to_jiffies(READ_TIMEOUT_MSECS);
> > for (;;) {
> > 	ret = thinkpad_ec_lock();
> > 	if (ret)
> > 		return ret;
> 
> Just in case someone was going to cut and paste, this will return with
> the ec_lock taken.

Well, taking lock failed (hence error return) so I think code is
correct.

-- 
Thanks for all the (sleeping) penguins.
