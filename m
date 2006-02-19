Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932378AbWBSJ1W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932378AbWBSJ1W (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 04:27:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932381AbWBSJ1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 04:27:21 -0500
Received: from mail.gmx.de ([213.165.64.20]:44433 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932378AbWBSJ1V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 04:27:21 -0500
X-Authenticated: #428038
Date: Sun, 19 Feb 2006 10:27:13 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: "D. Hazelton" <dhazelton@enter.net>
Cc: Gene Heskett <gene.heskett@verizon.net>,
       Christoph Hellwig <hch@infradead.org>, Bill Davidsen <davidsen@tmr.com>,
       Daniel Barkalow <barkalow@iabervon.org>, Greg KH <greg@kroah.com>,
       Nix <nix@esperi.org.uk>, Jens Axboe <axboe@suse.de>,
       Joerg Schilling <schilling@fokus.fraunhofer.de>,
       linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060219092713.GB21626@merlin.emma.line.org>
Mail-Followup-To: "D. Hazelton" <dhazelton@enter.net>,
	Gene Heskett <gene.heskett@verizon.net>,
	Christoph Hellwig <hch@infradead.org>,
	Bill Davidsen <davidsen@tmr.com>,
	Daniel Barkalow <barkalow@iabervon.org>, Greg KH <greg@kroah.com>,
	Nix <nix@esperi.org.uk>, Jens Axboe <axboe@suse.de>,
	Joerg Schilling <schilling@fokus.fraunhofer.de>,
	linux-kernel@vger.kernel.org
References: <878xt3rfjc.fsf@amaterasu.srvr.nix> <20060218120617.GA911@infradead.org> <200602181215.30277.gene.heskett@verizon.net> <200602181941.40093.dhazelton@enter.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602181941.40093.dhazelton@enter.net>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Feb 2006, D. Hazelton wrote:

> Well, in this case I'm actually trying to work with Joerg to produce a patch 
> that unifies the ATAPI and SCSI busses inside his program.

This patch already exists, see:
<http://www.ussg.iu.edu/hypermail/linux/kernel/0602.0/1103.html>

It's a proof of concept and needs to be polished (I'll look into that
again in March).

Only it still probes all /dev/hd and /dev/sg and /dev/pg in a dumb way,
rather than looking at sysfs or reading through /dev/.

> I've seen the "MRW" stuff in some of the specs, but had to check the net to 
> find out what it was. MRW is the Mt. Rainier format - basic support was added 
> by Jens back in 2.4.19 according to the archives. 
> (http://www.ussg.iu.edu/hypermail/linux/kernel/0203.2/1214.html)
> 
> I'm not positive, but the "Can Read RAM" line might refer to DVD-RAM type 
> discs

That's probably not it, since there's a separate DVD-RAM line here:

CD-ROM information, Id: cdrom.c 3.20 2003/12/17

drive name:             hdd     hdc     sr0
drive speed:            40      48      1
drive # of slots:       1       1       1
Can close tray:         1       1       1
Can open tray:          1       1       1
Can lock tray:          1       1       1
Can change speed:       1       1       0
Can select disk:        0       0       0
Can read multisession:  1       1       1
Can read MCN:           1       1       1
Reports media changed:  1       1       1
Can play audio:         1       1       1
Can write CD-R:         1       1       0
Can write CD-RW:        1       1       0
Can read DVD:           0       1       0
Can write DVD-R:        0       1       0
Can write DVD-RAM:      0       1       0
Can read MRW:           1       1       1
Can write MRW:          1       1       1
Can write RAM:          1       1       1

hdd = Plextor PX-W4824TA
hdc = NEC ND-4550A
sr0 = Plextor PX-32TS

(Now NEC only needs to teach their drives to be more error tolerant when
reading and adjust their read speed to the actual sustained transfer
rate as Toshiba drives have been doing for ages...)

-- 
Matthias Andree
