Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265031AbTFTXfQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 19:35:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265035AbTFTXfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 19:35:16 -0400
Received: from mail.ithnet.com ([217.64.64.8]:31759 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S265031AbTFTXfG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 19:35:06 -0400
Date: Sat, 21 Jun 2003 01:48:28 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: marcelo@conectiva.com.br, kpfleming@cox.net, stoffel@lucent.com,
       gibbs@scsiguy.com, linux-kernel@vger.kernel.org, willy@w.ods.org,
       green@namesys.com
Subject: Re: Undo aic7xxx changes (now rc7+aic20030603)
Message-Id: <20030621014828.0420b74f.skraw@ithnet.com>
In-Reply-To: <20030620220331.GA1100@alpha.home.local>
References: <20030509150207.3ff9cd64.skraw@ithnet.com>
	<41560000.1055306361@caspian.scsiguy.com>
	<20030611222346.0a26729e.skraw@ithnet.com>
	<16103.39056.810025.975744@gargle.gargle.HOWL>
	<20030613114531.2b7235e7.skraw@ithnet.com>
	<20030620220331.GA1100@alpha.home.local>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Jun 2003 00:03:31 +0200
Willy Tarreau <willy@w.ods.org> wrote:

> Hi !
> 
> On Fri, Jun 20, 2003 at 06:13:53PM -0300, Marcelo Tosatti wrote:
> > > Actually, without another copy of the data on a different system to
> > > verify it with, you can't know that for sure. It could easily be getting
> > > to the tape (the actual media) just fine, but then get corrupted during
> > > the verify readback.
> > 
> > Right. Stephan, if you could use a bit of your time to isolate the problem
> > I would be VERY grateful.
> 
> I remember Stephan once said that he used tar to verify the tape, and that
> for one backup, he did several tests showing corruption on different files.
> Altough that doesn't mean that the tape is written totally correctly, it at
> proves that there's at least a read corruption.

Hello Willy, hello Marcelo,

in fact I noticed that doing multiple verify cycles the so-called corruption
happens rarely (read _very_ rarely) on the same files. So it is indeed very
likely that the read case is a problem.
Another thing to note is that I did not manage to produce a failed verify on a
dataset tar'ed to the 3ware raid and not to tape. I did not test that very
intensively, but from the tests I did I would have expected a corruption to
happen based on the cycles I did on tape.

> I think that comparing multiple reads to find a pattern in corruption offsets
> (if any) is the only thing he could do (not speaking about mixing read/writes
> with good/bad kernels). Of course, storing several times 70GB on disk is not
> easy, but at least a 16 bits checksum for each 1kB block would result on
> about 140 MB files, which will be "easier" to compare. It could be enough to
> check for empty blocks, duplicated blocks or totally random ones.
> 
> Stephan, if you're willing to do the test but don't have such a tool, I may
> write a quick dirty one tomorrow if that helps.
> 
> BTW, it could be interesting to note the read buffer's hardware address for
> each test, in case it matters.

Well, in fact I am a bit lost in the case, because of the shere data volume, I
have space for several sets on disk, but it takes a damn long time to produce
one cycle write/verify. Anyway I will do if that helps. The big problem with
tar is that I have (to my knowledge) no chance to let it somewhere save the
verify-failing data parts. I guess this could help a lot, because we could then
see what the corruption looks like, how long (in bytes) it is and so on.
If anybody has an idea how to achieve this goal let me know.

I am not 100% confident that the tests would look the same if I simply read the
whole tape onto the disks again and then verify via file compare, but anyway I
should try this too several times to complete the picture. 

Ok, weekend is here, I see what can be done.

Regards,
Stephan
