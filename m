Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132367AbRASTIp>; Fri, 19 Jan 2001 14:08:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132917AbRASTIg>; Fri, 19 Jan 2001 14:08:36 -0500
Received: from palrel1.hp.com ([156.153.255.242]:33036 "HELO palrel1.hp.com")
	by vger.kernel.org with SMTP id <S132367AbRASTIQ>;
	Fri, 19 Jan 2001 14:08:16 -0500
Message-ID: <3A68908C.3F3FE453@cup.hp.com>
Date: Fri, 19 Jan 2001 11:07:56 -0800
From: Rick Jones <raj@cup.hp.com>
Organization: the Unofficial HP
X-Mailer: Mozilla 4.75 [en] (X11; U; HP-UX B.11.00 9000/785)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [Fwd: [Fwd: Is sendfile all that sexy? (fwd)]]
In-Reply-To: <Pine.LNX.4.30.0101181840380.16292-100000@twinlark.arctic.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dean gaudet wrote:
> 
> On Wed, 17 Jan 2001, Rick Jones wrote:
> 
> > > actually the problem isn't nagle...  nagle needs to be turned off for
> > > efficient servers anyhow.
> >
> > i'm not sure I follow that. could you expand on that a bit?
> 
> the problem which caused us to disable nagle in apache is documented in
> this paper <http://www.isi.edu/~johnh/PAPERS/Heidemann97a.html>.  mind you
> i should personally revisit the paper after all these years so that i can
> reconsider its implications in the context of pipelining and webmux.

ah yes, that - where the web server even for just static content was
providing the replies in more than one send. i would not consider that
to have been an "efficient" server.

i'm not sure that I agree with their statment that piggy-backing is
rarely successful in request/response situations.

the business about the last 1100ish bytes of a 4096 byte send being
delayed by nagle only implies that the stack's implementation of nagle
was broken and interpreting it on a per-segment rather than a per-send
basis. if the app sends 4096 bytes, then there should be no
nagle-induced delays on a connection with an MSS of 4096 or less.

it would seem that in the context of that paper at least, most if not
all of the problems were the result of bugs - either in the webserver
software, or the host TCP stack. otherwise, the persistent connections
would have worked just fine.

> i'm not aware yet of any study in the field.  and i'm out of touch enough
> with the clients that i don't know if new netscape or IE have finally
> begun to use pipelining (they hadn't as of 1998).

someone else sent a private email implying that no browsers were yet
doing pipelining.

rick
-- 
ftp://ftp.cup.hp.com/dist/networking/misc/rachel/
these opinions are mine, all mine; HP might not want them anyway... :)
feel free to email, OR post, but please do NOT do BOTH...
my email address is raj in the cup.hp.com domain...
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
