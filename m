Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274571AbRIYJ0x>; Tue, 25 Sep 2001 05:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274573AbRIYJ0e>; Tue, 25 Sep 2001 05:26:34 -0400
Received: from lsmls01.we.mediaone.net ([24.130.1.20]:24808 "EHLO
	lsmls01.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S274571AbRIYJ0X>; Tue, 25 Sep 2001 05:26:23 -0400
Message-ID: <3BB04D8B.15F89500@kegel.com>
Date: Tue, 25 Sep 2001 02:25:31 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
CC: Davide Libenzi <davidel@xmailserver.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Gordon Oliver <gordo@pincoya.com>
Subject: Re: [PATCH] /dev/epoll update ...
In-Reply-To: <20010924225616.D9688@kushida.jlokier.co.uk> <XFMail.20010924150804.davidel@xmailserver.org> <20010924230909.A10253@kushida.jlokier.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> > Anyway there's a pretty good patch ( http://www.luban.org/GPL/gpl.html ),
> > that has been tested here :
> >
> > http://www.xmailserver.org/linux-patches/nio-improve.html
> >
> > that implement the signal-per-fd mechanism and it achieves a very good
> > scalability too.
> 
> It has the bonus of requiring no userspace changes too.  Lovely!

Well, not quite *no* userspace changes, but not many.  You have to
use si_band rather than si_code (and with Luban's version, you also
need to set a new flag).

It has some locking problems that only show up under very heavy use,
so caveat emptor.  I put together a stress test 
(http://www.kegel.com/dkftpbench/ with the -sf option);
run that against betaftpd, and around 4500 ftp sessions, you might
see it crash because a signal comes in while the file table is expanding...

(By the way, I finally updated http://www.kegel.com/c10k.html to
distinguish properly between edge-triggered readiness notification
methods and level-triggered ones.  Hope that helps dispel some 
confusion in the future.)
- Dan
