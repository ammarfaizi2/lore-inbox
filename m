Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932081AbWFMMYD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbWFMMYD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 08:24:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932082AbWFMMYD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 08:24:03 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:43433 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932081AbWFMMYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 08:24:01 -0400
Subject: Re: VGER does gradual SPF activation (FAQ matter)
From: David Woodhouse <dwmw2@infradead.org>
To: Matthias Andree <matthias.andree@gmx.de>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>, jdow <jdow@earthlink.net>,
       Jesper Juhl <jesper.juhl@gmail.com>, nick@linicks.net,
       Bernd Petrovitsch <bernd@firmix.at>, marty fouts <mf.danger@gmail.com>,
       Matti Aarnio <matti.aarnio@zmailer.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060613104557.GA13597@merlin.emma.line.org>
References: <200606130300.k5D302rc004233@laptop11.inf.utfsm.cl>
	 <1150189506.11159.93.camel@shinybook.infradead.org>
	 <20060613104557.GA13597@merlin.emma.line.org>
Content-Type: text/plain
Date: Tue, 13 Jun 2006 13:24:34 +0100
Message-Id: <1150201475.12423.12.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-13 at 12:45 +0200, Matthias Andree wrote:
> > It's fairly trivial with a decent MTA. I use all kinds of conditions to
> > trigger greylisting -- HTML mail, 'Re:' in subject with no References:,
> > lack of reverse DNS or CSA on the sending host, >=0.1 SA points, etc.
> > Adding "is not subscribed to the mailing list they're trying to post to"
> > should be trivial.
> 
> Given that list drivers are separate from the MTA (and that's good),

I'm unconvinced of the goodness of that. With a suitably capable MTA,
there isn't a huge reason not to have the basic receive-and-resend mail
path handled _entirely_ by the MTA, rather than pawning it off to
separate software. Obviously the interface to subscribers, be it through
email or http, wants to be separate -- but receiving and sending email
is what an MTA does best. And I've learned to hate mailman with a
vengeance -- I've been meaning to investigate exilist for some time now,
for my mailing lists.

http://duncanthrax.net/exilist-distro/

> it's less trivial than simple looking at message headers or DNS info
> that the MTA shuffles around anyways. The MTA doesn't need the
> subscription list however, since "exploding" the subscriber list is a
> separate problem handled by Majordomo, Mailman, Sympa, whatever. 

Even if you have a cron job which extracts the subscriber list into a
text file or other database which is used by the MTA, it isn't
particularly hard. In many cases, Exim should probably be able to read
the subscriber database directly, anyway.

Actually, just tagging _all_ posts to the list for greylisting is
probably OK as long as you're doing your greylisting sensibly. The thing
about greylisting is that you're checking to see if it's a dump-and-run
spammer, or whether it's a real mail host with a queue. Once a given
host is observed to actually retry and get past the greylisting, there's
little point in _ever_ greylisting mail from that host again anyway.

If you get that right, it doesn't matter if you tag every incoming mail
to the list for greylisting; it doesn't keep causing delays to people
who've got mail through before.

-- 
dwmw2

