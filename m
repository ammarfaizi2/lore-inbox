Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S144472AbRA1XrZ>; Sun, 28 Jan 2001 18:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S144513AbRA1XrQ>; Sun, 28 Jan 2001 18:47:16 -0500
Received: from kullstam.ne.mediaone.net ([66.30.138.210]:62611 "HELO
	kullstam.ne.mediaone.net") by vger.kernel.org with SMTP
	id <S144472AbRA1Xq7>; Sun, 28 Jan 2001 18:46:59 -0500
From: "Johan Kullstam" <kullstam@ne.mediaone.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Poor SCSI drive performance on SMP machine, 2.2.16
In-Reply-To: <003f01c088fb$a35c06e0$b001a8c0@caesar>
	<20010128174016.3fba71ad.bruce@ask.ne.jp>
	<002901c08951$f751bfa0$b001a8c0@caesar>
Organization: none
Date: 28 Jan 2001 18:50:16 -0500
In-Reply-To: <002901c08951$f751bfa0$b001a8c0@caesar>
Message-ID: <m2wvbfi6dj.fsf@euler.axel.nom>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"paradox3" <paradox3@maine.rr.com> writes:

> I did this:
> 
> date
> dd if=/dev/zero of=TESTFILE bs=1024 count=102400
> date
> sync
> date
> 
> 
> and I gave the time differences from the first to the last
> timestamp.

hmm.  i ran this on my old ppro200 with adaptec 2940uw and ibm
DDRS-39130W drive.

sophia(jk)$ cat foo 
date
dd if=/dev/zero of=TESTFILE bs=1024 count=102400
date
sync
sync
sync
date

i get

sophia(jk)$ time bash foo
Sun Jan 28 18:41:52 EST 2001
102400+0 records in
102400+0 records out
Sun Jan 28 18:42:11 EST 2001
Sun Jan 28 18:42:13 EST 2001

real    0m20.803s
user    0m0.400s
sys     0m8.780s

and this during a full kernel compile.

i get similar decent results using my other computer with a symbios
8751sp and fujitsu and seagate drives.

something must be messed up in a configuration somewhere.  are you
sure you are running the drive in synchronous ultra wide mode?  is you
termination good?

> Regards, Para-dox (paradox3@maine.rr.com)
> 
> 
> 
> ----- Original Message -----
> From: "Bruce Harada" <bruce@ask.ne.jp>
> To: "paradox3" <paradox3@maine.rr.com>
> Cc: <linux-kernel@vger.kernel.org>
> Sent: Sunday, January 28, 2001 2:31 PM
> Subject: Re: Poor SCSI drive performance on SMP machine, 2.2.16
> 
> 
> >
> > Hm. As a point of comparison, I use a similar system to yours (full SCSI,
> > though, no IDE) and I can copy a 100MB file from disk-to-disk, or on the
> > same disk, in around 13 seconds. Where are you copying to the SCSI drive
> > from - the same drive, an IDE disk, CDROM? If IDE, what are its
> > particulars? (Check with hdparm -iI /dev/hd?)
> >
> > --
> > Bruce Harada
> > bruce@ask.ne.jp
> >
> >
> >
> > On Sun, 28 Jan 2001 12:44:29 -0500
> > "paradox3" <paradox3@maine.rr.com> wrote:
> > >
> > > I don't get any messages relating to the drives in any syslog output.
> > >
> > > >
> > > > Do you get messages like the ones below in /var/log/messages?
> > > >
> > > >   sym53c875-0-<0,0>: QUEUE FULL! 8 busy, 7 disconnected CCBs
> > > >   sym53c875-0-<0,0>: tagged command queue depth set to 7
> > > >
> > > > In fact, do you get any messages in your log files that look like they
> > > > might be related?
> > > >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > Please read the FAQ at http://www.tux.org/lkml/
> >
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-- 
J o h a n  K u l l s t a m
[kullstam@ne.mediaone.net]
Don't Fear the Penguin!
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
