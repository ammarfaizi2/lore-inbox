Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264447AbTFIO4y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 10:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264448AbTFIO4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 10:56:53 -0400
Received: from mail.ithnet.com ([217.64.64.8]:58885 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S264447AbTFIO4v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 10:56:51 -0400
Date: Mon, 9 Jun 2003 17:10:11 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: linux-kernel@vger.kernel.org, willy@w.ods.org, gibbs@scsiguy.com,
       marcelo@conectiva.com.br, green@namesys.com
Subject: Re: Undo aic7xxx changes (now rc7+aic20030603)
Message-Id: <20030609171011.7f940545.skraw@ithnet.com>
In-Reply-To: <20030608134901.363ebe42.skraw@ithnet.com>
References: <Pine.LNX.4.55L.0305071716050.17793@freak.distro.conectiva>
	<2804790000.1052441142@aslan.scsiguy.com>
	<20030509120648.1e0af0c8.skraw@ithnet.com>
	<20030509120659.GA15754@alpha.home.local>
	<20030509150207.3ff9cd64.skraw@ithnet.com>
	<20030605181423.GA17277@alpha.home.local>
	<20030608131901.7cadf9ea.skraw@ithnet.com>
	<20030608134901.363ebe42.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I just finished another bunch of tests around the discussed issue and it's
getting to an end.
Yesterday I started using the test box with UP kernel instead of SMP, because I
have the feeling the whole problem is somewhere around an SMP race condition.
As far as I can see now the box runs 24h stable _and_ (and this is the
important part) one problem I did not talk about till now is completely gone:

During the whole testing with SMP I recognised that the tar-verify always
brought up "content differs" warnings. Which basically means that the filesize
is ok but the content is not. As there might be various causes for this (bad
tape, bad drive, bad cabling) I did not give very much about it. But it turns
out there are no more such warnings when using an UP kernel (on the same box
with the complete same hardware including tapes).

>From this experience I would conclude the following (for my personal test
case):

1) aic-driver has problems with smp/up switching (meaning crashes when trying
an SMP build with nosmp). This is completely reproducable.

2) aic-driver (almost no matter what version) has problems with SMP setup and
tape drives. Obviously data integrity is not given. This is completely
reproducable in my test setup.

For Marcelo: 
It seems you can take any version of the aic driver for small box setups with
UP, I never saw any troubles with it. As soon as you look at SMP flush it down
the t..let.

For Justin:
Thank you for your continous openness and support in the whole issue in form of
exactly _zero_ comments (,besides "how do you know aic is to blame?").

For Willy:
I honour your efforts, but we are not capable of solving the issue.

For Oleg:
Stay tuned, I will test the re-creation issue and your patch.

And now I go and buy a Symbios controller and re-try.

Regards,
Stephan
