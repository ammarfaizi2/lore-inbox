Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316599AbSEUU6f>; Tue, 21 May 2002 16:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316603AbSEUU6e>; Tue, 21 May 2002 16:58:34 -0400
Received: from asie314yy33z9.bc.hsia.telus.net ([216.232.196.3]:18126 "EHLO
	saurus.asaurus.invalid") by vger.kernel.org with ESMTP
	id <S316599AbSEUU6c>; Tue, 21 May 2002 16:58:32 -0400
To: "Calin A. Culianu" <calin@ajvar.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Lazy Newbie Question
In-Reply-To: <Pine.LNX.4.33L2.0205211556040.16426-100000@rtlab.med.cornell.edu>
From: Kevin Buhr <buhr@telus.net>
Date: 21 May 2002 13:58:32 -0700
Message-ID: <87y9edfcav.fsf@saurus.asaurus.invalid>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Calin A. Culianu" <calin@ajvar.org> writes:
> 
> Get comedi-cvs.

Thanks.

> > > 'nuff said.
> >
> > On the contrary...
> 
> Yeah whatever.

Well, as you can see from the implementation of "comedi_open" that's
right in front of you, that code doesn't do anything with the filename
except parse it as string of the form "/dev/comediNNN" to get the
minor number "NNN".  It looks like a cheesy hack to fake the
kernel-mode interface to look like the user-mode interface, but that's
all it is.  So, as Richard said, we still haven't seen any evidence
that Comedi requires manipulating files in kernel space.

It's quite strange how rude and evasive you're being when everyone
who's replied has been polite and helpful.  Perhaps if you lost the
attitude and told us what it is you're really trying to do, we could
help you more effectively.

I mean, either we're all too dim to understand your device driver
hacking skills, in which case there's no point in you wasting your
time here, or one of us has enough of a clue to help, in which case
we'd all benefit from you explaining your problem as fully as you are
able instead of demanding we show you how to do the impossible (i.e.,
stat a file without a process context).

By the way, in case you missed it---and it seems you did---Richard
already gave you the right answer in the message you mistakenly
dismissed as a flame.  If you really need to stat a file from the
kernel, you do this with a helper process in the form of a bona fide
user process or a kernel thread.  Because this is relatively
complicated to get right (there's a damn good reason the code in
"comedi_open" just fakes it), you don't want to do this unless you
have to.

-- 
Kevin Buhr <buhr@telus.net>
