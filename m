Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285166AbRL2SC7>; Sat, 29 Dec 2001 13:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285161AbRL2SCs>; Sat, 29 Dec 2001 13:02:48 -0500
Received: from waste.org ([209.173.204.2]:24783 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S285114AbRL2SCf>;
	Sat, 29 Dec 2001 13:02:35 -0500
Date: Sat, 29 Dec 2001 12:02:00 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Richard Gooch <rgooch@ras.ucalgary.ca>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Russell King <rmk@arm.linux.org.uk>,
        Rik van Riel <riel@conectiva.com.br>,
        Dana Lacoste <dana.lacoste@peregrine.com>,
        "'Eyal Sohya'" <linuz_kernel_q@hotmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: The direction linux is taking
In-Reply-To: <E16JoEp-000088-00@starship.berlin>
Message-ID: <Pine.LNX.4.43.0112291136350.18183-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Dec 2001, Daniel Phillips wrote:

> Hi Richard,
>
> On December 27, 2001 06:59 pm, Richard Gooch wrote:
> > But years of observations tells me that Linus likes the way he does
> > things and doesn't care if others don't like it. I don't expect to see
> > much change there.
>
> Except that, at the kernel summit this year, Linus *did* give the nod to a
> patchbot, in principle.  I could have sworn.
>
> It seems clear that the challenge is to come up with something that really is
> so lightweight and useful that Linus will use it.  That's the 'Linus test'.
> If somebody hands him a piece of crap to use then why would we expect him to
> deviate from his normal behaviour ;-)

If my understanding of the new kbuild and configure system is correct,
make clean and dep should be largely unnecessary and it should be possible
to build a patchbot that checks for incremental compilability:

for the current kernel release:
  unpack tree
  build the tree with default options (unprivileged user, obviously)

  for each patch in queue:
    copy tree (-a)
    apply patch
    if rejects:
      bounce("doesn't cleanly apply to kernel x")
    if not includes linux/patch.changelog:
      bounce("doesn't include changelog entry")
    if not includes linux/patch.config:
      bounce("doesn't include possibly empty config options")
    for each option in patch.config:
      if not (cml2 --new-enable-option-from-command-line-feature option)
        bounce("config option x couldn't be enabled")
    if not (make): bounce("couldn't build patch: <diags>")
    remove copied tree

Optimize above to deal with dependencies in the patch queue.

Then we need a web interface that allows rejects with various canned
messages:

  applied, thanks
  redundant
  obviously incorrect
  doesn't meet coding style (partially automatable with lindent)
  too ugly to live
  breaks code freeze, resubmit later
  submit to appropriate maintainer
  missing MAINTAINER entry
  insufficient documentation
  insufficient rationale
  forgot configure.help text (automatable)
  (custom message, of course)
  (drop silently)

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

