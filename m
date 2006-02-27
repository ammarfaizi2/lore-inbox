Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751239AbWB0UWa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbWB0UWa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 15:22:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751507AbWB0UWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 15:22:30 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:47733 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1751239AbWB0UW3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 15:22:29 -0500
Message-ID: <44035FBB.9060209@tmr.com>
Date: Mon, 27 Feb 2006 15:23:23 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
References: <878xt3rfjc.fsf@amaterasu.srvr.nix> <20060218120617.GA911@infradead.org> <200602181215.30277.gene.heskett@verizon.net> <200602181941.40093.dhazelton@enter.net> <20060219092713.GB21626@merlin.emma.line.org>
In-Reply-To: <20060219092713.GB21626@merlin.emma.line.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree wrote:
> On Sat, 18 Feb 2006, D. Hazelton wrote:
> 
>> Well, in this case I'm actually trying to work with Joerg to produce a patch 
>> that unifies the ATAPI and SCSI busses inside his program.
> 
> This patch already exists, see:
> <http://www.ussg.iu.edu/hypermail/linux/kernel/0602.0/1103.html>
> 
> It's a proof of concept and needs to be polished (I'll look into that
> again in March).
> 
> Only it still probes all /dev/hd and /dev/sg and /dev/pg in a dumb way,
> rather than looking at sysfs or reading through /dev/.
> 
>> I've seen the "MRW" stuff in some of the specs, but had to check the net to 
>> find out what it was. MRW is the Mt. Rainier format - basic support was added 
>> by Jens back in 2.4.19 according to the archives. 
>> (http://www.ussg.iu.edu/hypermail/linux/kernel/0203.2/1214.html)
>>
>> I'm not positive, but the "Can Read RAM" line might refer to DVD-RAM type 
>> discs
> 
> That's probably not it, since there's a separate DVD-RAM line here:
> 
> CD-ROM information, Id: cdrom.c 3.20 2003/12/17
> 
> drive name:             hdd     hdc     sr0
> drive speed:            40      48      1
> drive # of slots:       1       1       1
> Can close tray:         1       1       1
> Can open tray:          1       1       1
> Can lock tray:          1       1       1
> Can change speed:       1       1       0
> Can select disk:        0       0       0
> Can read multisession:  1       1       1
> Can read MCN:           1       1       1
> Reports media changed:  1       1       1
> Can play audio:         1       1       1
> Can write CD-R:         1       1       0
> Can write CD-RW:        1       1       0
> Can read DVD:           0       1       0
> Can write DVD-R:        0       1       0
> Can write DVD-RAM:      0       1       0
> Can read MRW:           1       1       1
> Can write MRW:          1       1       1
> Can write RAM:          1       1       1
> 
> hdd = Plextor PX-W4824TA
> hdc = NEC ND-4550A
> sr0 = Plextor PX-32TS

Other than my 2.6.15 not producing those last three lines, looks good.
The names are those in /sys, which of course many distros change in udev
to make things hard for the user. Hard t write an app portably to cope
with /dev/scd0, /dev/sr0, /dev/cdroms/sr0, etc.

I am NOT suggesting changing a stable interface, but this really should
be in /sys I would think. It would be nice to have the major/minor and
model info, so programs could find the "better" named in /dev or just
mknod their own.
> 
> (Now NEC only needs to teach their drives to be more error tolerant when
> reading and adjust their read speed to the actual sustained transfer
> rate as Toshiba drives have been doing for ages...)
> 

This would appear to be almost all the user needs to at least find the
devices. I don't know why no one mentioned it several years ago.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

