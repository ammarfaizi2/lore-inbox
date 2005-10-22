Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751322AbVJVQJT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbVJVQJT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 12:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbVJVQJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 12:09:19 -0400
Received: from web31802.mail.mud.yahoo.com ([68.142.207.65]:914 "HELO
	web31802.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751302AbVJVQJS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 12:09:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=pTk9gfJdEciuIo25X+kjzeTbrhr/KTb4iBTlskCmEZQbDQtyQ4ZnrfkGTo+BnwK94ZpVGBjdrY7YwJnlde1iZS5W0ldU1PLfd1MW1J16ZuCiGl7rS32ThqwFKLkUwD6Qj5+vQuJmKD55PWqmLvJUdTVuEZ2bIlrgnlMTJv/cJ3M=  ;
Message-ID: <20051022160915.9570.qmail@web31802.mail.mud.yahoo.com>
Date: Sat, 22 Oct 2005 09:09:14 -0700 (PDT)
From: Luben Tuikov <ltuikov@yahoo.com>
Reply-To: ltuikov@yahoo.com
Subject: Re: ioctls, etc. (was Re: [PATCH 1/4] sas: add flag for locally attached PHYs)
To: Jeff Garzik <jgarzik@pobox.com>, Luben Tuikov <luben_tuikov@adaptec.com>
Cc: andrew.patterson@hp.com, Christoph Hellwig <hch@lst.de>,
       "Moore, Eric Dean" <Eric.Moore@lsil.com>, jejb@steeleye.com,
       linux-scsi@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <43596F16.7000606@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Jeff Garzik <jgarzik@pobox.com> wrote:
>
http://linux.adaptec.com/sas/git/?p=linux-2.6-sas.git;a=commit;h=785747ddc631f7618d728a377346965f7db2256a
> 
> This effectively illustrates the wrong thing to do:  duplicating 
> information that's already in Scsi_Host_Template.

No, it doesn't.  It shows you that accomodating of this is so very easy. Easy
and straightforward, just as the comming shows.

> Just use Scsi_Host_Template in the LLDD and see where that goes.

We've done this already: adp94xx submitted earlier this year, rejected by
the community, because "common SAS tasks should go to a common layer".  Now
you _have_ that common layer, the SAS Transport Stack/Layer.  But the
requirements of the community seem to change on a daily basis.

It looks like "the community" got more than it bargained for, and since
it doesn't understand it, it wants to bastardize the code and the layering.

> > While the architecture in my mind is clear, I cannot do this myself
> > (and for all drivers).  Such a change would be gradual, involving more
> > than one developer, for more than one (new) driver, etc.
> 
> Correct.  That's why there is resistance to aic94xx's approach of 
> creating a totally new "strict SAM" path, existing in parallel with the 

No, it is not correct -- you complety turn around anything I say to make
yourself look right.

Here is what I meant: the resistance is because a few people of Linux SCSI
want things done _their_ way, using _their_ code, reinventing code and concepts
done already by engineers who use the technology every day.

Why else is there a COMPLETLY BROKEN and WRONG "SAS transport attributes"?
Politics and influence, thats why.  So that you can say "change already
existing code".  So in effect politically "correct" people can submit
COMPLETY WRONG AND BROKEN CODE with their name on it, and when there is
a proper code wating to go in, they can BLOCK IT and ask that
current BROKEN code be changed (beyond recognition) code which made it
in, NOT because of technological merit but because of political influence.

Linux SCSI people should start _listening_ to technology engineers who
work with this technology every day.  If they showed this open attitude,
I can tell you that _a lot more_ engineers would get involved to _improve_
further Linux SCSI, who are holding out now just because of this "my way
or no way" attitude of a few folks at Linux SCSI.

Furthermore, "aic94xx" is NOT CREATING ANYTHING NEW.  This is how
USB Storage and SBP already work.  There is clearly separated transport
layer, independent of the interconnect.  That layer depends on the type
of device connected.  Using such an infrastructure you can layer more
varied architectures, as opposed to dictating that aic94xx needs the
host template in it, short-circuting proper layring.

I repeat again: apd94xx already has the Host Template IN IT.
I repeat again: nothing in the Hardware of AIC-94XX Host Adapter has
_anything_ to do with Host Templates.  Host Templates are a SCSI thing.
The hardware implements an access point to the _interconnect_: Execute
Command SCSI RPC and TMFs.  It is completely backwards to force something
at a place where it does not belong.
I repeat again: USB Storage and SBP _already_ implement such an architecture
as shown by SAS.

Had we had multiple Transport Layers back when SCSI Core was written (imported
from BSD?) I can tell you that there'd be such a layering disposistion as
shown in USB/SBP/SAS _already_ in the kernel -- just because IT MAKES SENSE.

> traditional SCSI core.  You need to evolve the existing code to get 
> there.  Such changes are gradual, involving more than one developer, etc.

Thank you for the mockery.  What I meant is that I don't mind working towards
this goal, with storage engineers who _know_ and _understand_ SCSI Technology,
not necessarily SAS, but SCSI in general.  There is only a few folks
like that here at lsml who are active and at least one whom I know of
who is not active.

What actually seems to be happening at Linux SCSI is not "working together"
but "If you do not do it _my_ way, I'll spin your words and say that
you are not willing to ``work together''." which is _exactly_ what you
do.

Is it possible for Linux SCSI to learn that they are doing something wrong?
Is it possible for Linux SCSI to learn that they need to listen and learn
from company engineers, as opposed to doing things _their_ way?
Apparently not.

> We don't need one small set of SCSI drivers behaving differently from 
> the vast majority of existing SCSI drivers.

USB Storage and SBP are already like that.

Then again why are you saying this?  Would you loose control?
Cannot you see that such changes are necessary to go forward towards
the future?  Do you think that such changes would be happening only
in Linux SCSI?

If Linux overall has the attitude you are showing, Linux would go extinct
in just a few years.  Just enough time for such antics to get to paying
customers (who not necessarily have technological know-how, but it would
eventually get to them).

> Hear me now, and believe me later:  we all largely agree on the points

You are a very good politican -- just keep repeating this.
 
> you've raised about legacy crapola in the SCSI core.  James, Christoph, 
> myself, and several others disagree with your assertion that the old 
> SCSI core should exist in parallel with your new SCSI core.

This isn't my new SCSI Core.  I don't have a new SCSI Core.
But I'm flattered that you feel this way.

> We differ on the path, not the goal.  As a thought experiment, you could 
> try simply implementing the changes requested, and see where that goes.

Been there, done that: adp94xx, rejected by none other but "the community".
Here is now the Linux SAS Stack and aic94xx, working completely fine,
full source code, git tree, patch file, whole working tree (Linus' as of
Friday evening + SAS Stack + aic94xx) present at the link in my sig.

   Luben
-- 
http://linux.adaptec.com/sas/
http://www.adaptec.com/sas/


