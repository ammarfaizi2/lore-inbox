Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272527AbRIPQq6>; Sun, 16 Sep 2001 12:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272528AbRIPQqs>; Sun, 16 Sep 2001 12:46:48 -0400
Received: from family.zawodny.com ([63.174.200.26]:24851 "EHLO
	family.zawodny.com") by vger.kernel.org with ESMTP
	id <S272527AbRIPQqf>; Sun, 16 Sep 2001 12:46:35 -0400
Date: Sun, 16 Sep 2001 09:47:59 -0700
From: Jeremy Zawodny <Jeremy@Zawodny.com>
To: Tonu Samuel <tonu@mysql.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: broken VM in 2.4.10-pre9
Message-ID: <20010916094759.A14053@peach.zawodny.com>
In-Reply-To: <Pine.LNX.4.33L2.0109160031500.7740-100000@flashdance> <9o1dev$23l$1@penguin.transmeta.com> <1000722338.14005.0.camel@x153.internalnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1000722338.14005.0.camel@x153.internalnet>
User-Agent: Mutt/1.3.20i
X-message-flag: Mailbox corrupt.  Please upgrade your mail software.
X-Uptime: 09:42:12 up 49 days,  7:40, 10 users,  load average: 0.00, 0.00, 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2001 at 06:25:38PM +0800, Tonu Samuel wrote:
> On 16 Sep 2001 05:31:11 +0000, Linus Torvalds wrote:
> 
> > Also note that the amount of "swap used" is totally meaningless in
> > 2.4.x. The 2.4.x kernel will _allocate_ the swap backing store much
> > earlier than 2.2.x, but that doesn't actuall ymean that it does any of
> > the IO. Indeed, allocating the swap backing store just means that the
> > swap pages are then kept track of, so that they can be aged along with
> > other stores.
> 
> Problem still exists and persists. Not long time ago man from Yahoo
> described well case when change from 2.2.19 to 2.4.x caused
> performance problems. On 2.2.19 everything ran fine. They have MySQL
> running+did backups from disk. After upgrade to 2.4.x MySQL
> performance felt down on backup time. They investigated stuff and
> found that MySQL daemon gets swapped out in the middle of usage to
> make room for buffers. In summary: this made both sql and backup
> double slow. Even increasing memory from 1G->2G didn't
> helped. Finally they disabled swap at all and problem lost.

Yep, that was me.  It was frustrating to have to double the RAM in the
machine and then turn off swap.  The extra RAM did help, but it really
only delayed the problem.

> If you do not want to change it back as it was in 2.2.x then would
> be good if this is tunable somehow.

Agreed.  I'd be great if there was an option to say "Don't swap out
memory that was allocated by these programs.  If you run out of disk
buffers, toss the oldest ones and start re-using them."

Jeremy
-- 
Jeremy D. Zawodny     |  Perl, Web, MySQL, Linux Magazine, Yahoo!
<Jeremy@Zawodny.com>  |  http://jeremy.zawodny.com/
