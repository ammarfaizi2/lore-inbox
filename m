Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287005AbRL1U0K>; Fri, 28 Dec 2001 15:26:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287003AbRL1U0B>; Fri, 28 Dec 2001 15:26:01 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:36871
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S287000AbRL1UZz>; Fri, 28 Dec 2001 15:25:55 -0500
Date: Fri, 28 Dec 2001 12:23:48 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Jens Axboe <axboe@suse.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Daniel Stodden <stodden@in.tum.de>,
        linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
In-Reply-To: <20011228115956.E2973@suse.de>
Message-ID: <Pine.LNX.4.10.10112281023000.24491-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Dec 2001, Jens Axboe wrote:

> On Thu, Dec 27 2001, Andre Hedrick wrote:
> > 
> > I would provide patches if you had not goat screwed the block layer and
> > had taken a little more thought in design, but GAWD forbid we have design.
> 
> You still have zero, absolutely zero facts. _What_ is screwed?

Well your total lack of documentation.
You have changed portions of struct request * and no referrences.
You have change the behavor of calculating ones position of the
rq->buffer, wrt "nr_sectors - current_nr_sectors".  There is still no
valid reason yet given by you.

> > You have made it clear that you do not believe in testing the data
> > transport layers in storage.
> 
> That's not true. I would not mind such a framework. What I opposed was
> you claiming that you can _proof_ data correctness. Verifying data
> integrity and proof are two different things.

You have strange defs.

PROOF it works is done but "Verifying data integrity".
	thus
"Verifying data integrity" is PROOF it works.

One of those silly mathmatic rules of equality.

You have had access to this code for at least a year (one variation or
another), I can be responsible if you elect to ignore things.

> > Translation: You do not care if data gets to disk correctly or not.
> 
> Bullshit.

Really, then why did you not use the BUS Analyzers given to you to test
your changes to the new BLOCK translation between FS and DRIVER.
Obviously you have the tools, but you neglected to even look.

> > You have stated you do not believe in standards, thus you believe less in
> > me because I "Co-Author" one for NCITS.
> 
> Please stop misquoting me. _You_ claim that if you have the states down
> 100% from the specs, then your driver is proofen correct. I say that
> believing that is an illusion, only in a perfect world with perfect
> hardware would that be the case.

This is where you fail to understand, I do not know how to teach you
anymore, nor does having you visit the folks in the drive making
industry help because even they could not instruct you.

Maybe if you could see that writing code that is correct to the
state-machine described at the physical layer of the hardware, one would
have the understand of a base from which to address exceptions.

> > You have stated the tools of the trade are worthless but you have an ATA
> > and SCSI analyzer but you refuse to use them.  I know you have them
> > because I know who provided them to you.
> 
> Again, I've _never_ made such claims. I have the tools, yes, and they
> are handy at times.

Really! well let me replay an irc-log

*andre* maybe I trust it because it passes signal correctness on an ata-bus analizer
*axboe* who has proven the analyzer? :)
*andre* are you serious ?
*axboe* of course
*andre* that is all I want to know -- sorry I asked

Electrons do not lie.

> > Maybe when you get off your high horse and begin to listen, I will quit
> > being the ASS pointing out your faulty implimentation of BIO.  Maybe when
> > you decide it is important we can try to work togather again.
> 
> ... obviously no need for me to comment on this.

Yes because you have no intention of getting off your high-horse.

> > One thing you need to remember, BLOCK is everybodies "BITCH".
> > FileSystems dictate to BLOCK there requirements.
> > Low_Level Drivers dictate to BLOCK there rulesets.
> > BLOCK is there to bend over backwards to make the transition work.
> > BLOCK is not a RULE-SETTER, it is nothing but a SLAVE, and it has to be
> > damn clever.  One of you assests is you are "clever", but that will not
> > cover your knowledge defecits in pure storage transport.
> 
> I agree.

Really, now that you are backed into a corner I will tell you how the
driver is to work and you will adjust block to conform to that ruleset.

> > Now I am tired of this game you are playing, so lets spell it out.
> > 
> > Congratulations of your copying of the rq->special for the CDB transport
> > out of the ACB driver that myself and two other people authored.
> 
> Strictly a cleanup, what's your point?
> 
> > Congratulations on you first attempts to create the "pre-builder" model
> > that myself and one other has described to you, to bad you did not listen
> > 9 months ago or you would have the bigger picture.
> 
> I did it now because it's easy to do, comprende? It can be done cleanly
> because elv_next_request is there now.
> 
> > BUZZIT on mixing two issues that are volitale on there own rights to sort
> > out.  The high memory bounce and block are two different changes, and one
> > is dependent on the other, regardless if you see it or not.
> 
> Explain.

Given the volitale nature of these two areas on their own, why would
anyone in their right mind mix the two.

> > BUZZIT on your short sightedness on the immediate intercept of command
> > mode
> 
> Explain

Well the obvious usage for "immediate immediate" is for domain-validation.
This allows one to test and access the behavor of the codebase before
assuming it is valid and it gives you a way to compare expected v/s
observed when using a bus analyzer.  This is another way to verify if the
code written is doing what is expected.

> > BUZZIT on you himem operations that is not able to perform the vaddr
> > windowing for the entire request, but choose to suffer the latency of
> > single sector transaction repetion.
> 
> s/single sector/single segment. And that temp mapping is done for _PIO_
> for christ sakes, I challenge you to show me that being a bottleneck in
> any way at all. Red herring.

"bottleneck" no, it breaks a valid and tested method for using the
buffer, and PIO is where we land if we have DMA problems.

> > BUZZIT on your total lack of documention the the changes to the
> > request_struct, otherwise I could follow your mindset and it would not be
> > a pissing contest.
> 
> Tried reading the source?

I would if there were any docs.

Maybe you could finally explain your new recipe for the changes in the
request struct.  I have been asking you in private for more than a month
and you have yet to disclose the usage.

Recall above where you agree that BLOCK is a SLAVE to the DRIVER.
Now I require that upon entry the following be set and only released upon
the dequeuing of the request.


to = ide_map_buffer(rq, &flags);

This is to be performed upon entry for the given request.
It is to be released upon a dequeuing.

ide_unmap_buffer(to, &flags);

This will allow me to walk "to" and not "buffer" so that BLOCK can
properly map into the DRIVER.

/*
 * Handler for command with PIO data-in phase
 */
ide_startstop_t task_in_intr (ide_drive_t *drive)
{
        byte stat               = GET_STAT();
        byte io_32bit           = drive->io_32bit;
        struct request *rq      = HWGROUP(drive)->rq;
        char *pBuf              = NULL;

        if (!OK_STAT(stat,DATA_READY,BAD_R_STAT)) {
                if (stat & (ERR_STAT|DRQ_STAT)) {
                        return ide_error(drive, "task_in_intr", stat);
                }
                if (!(stat & BUSY_STAT)) {
                        DTF("task_in_intr to Soon wait for next interrupt\n");
                        ide_set_handler(drive, &task_in_intr, WAIT_CMD, NULL);
                        return ide_started;
                }
        }
        DTF("stat: %02x\n", stat);
        pBuf = rq->buffer + ((rq->nr_sectors - rq->current_nr_sectors) * SECTOR_SIZE);
        DTF("Read: %p, rq->current_nr_sectors: %d\n", pBuf, (int) rq->current_nr_sectors);

        drive->io_32bit = 0;
        taskfile_input_data(drive, pBuf, SECTOR_WORDS);
        drive->io_32bit = io_32bit;

        if (--rq->current_nr_sectors <= 0) {
                /* (hs): swapped next 2 lines */
                DTF("Request Ended stat: %02x\n", GET_STAT());
                ide_end_request(1, HWGROUP(drive));
        } else {
                ide_set_handler(drive, &task_in_intr,  WAIT_CMD, NULL);
                return ide_started;
        }
        return ide_stopped;
}

As you can see "rq->nr_sectors" is not touched, nor is "rq->buffer".
This was your primary bender and I fixed it but you choose not to use it.
I only modify "rq->current_nr_sectors" and no longer bastardize the rest
of the request.

> > BUZZIT on your moving CDROM operations to create a bogus BLOCK_IOCTL, for
> > what?  Who know it may have some valid usage, but CDROM is not it.
> 
> That part isn't even started yet, block_ioctl is just to show that
> rq->cmd[] and ide-cd does work with passing packet commands around.

Well maybe if you had or would disclose a model then people could help and
not be left wondering about the mess created, while working to clean up a
bigger mess from the past.

> > BUZZIT on your cut and past in block to make an effective rabbit warren or
> > chaotic maze to make it total opaque in what is really going on.
> 
> Again, what are you talking about?

Well after discussing w/ Suparna, I now understand that it is related to
the multi-segments but I am sure that most do not see that because it is
not comments or explained in any model.  Much of what I saw was a glorious
cut-n-paste job to make a readable (but rather large function) now
scattered and run through a whopper-chopper.  However I see some of the
validity of the changes but still much needs explaining.

> Congratulations on spending so much time writing an email with very
> little factual content. Here's an idea -- try backing up your statements
> and claims with something besides hot air.

And for you in a total waste of communication requests from the past that
have yet to appear, thus I have to be a BOHA to get your attention.
However you still ignore valid questions and concerns.


Regards,

Andre Hedrick
CEO/President, LAD Storage Consulting Group
Linux ATA Development
Linux Disk Certification Project



