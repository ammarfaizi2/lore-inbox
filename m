Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262195AbTJNHYo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 03:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262201AbTJNHYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 03:24:44 -0400
Received: from users.linvision.com ([62.58.92.114]:39317 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S262195AbTJNHYm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 03:24:42 -0400
Date: Tue, 14 Oct 2003 09:24:41 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Wes Janzen <superchkn@sbcglobal.net>
Cc: Rogier Wolff <R.E.Wolff@BitWizard.nl>,
       Norman Diamond <ndiamond@wta.att.ne.jp>,
       John Bradford <john@grabjohn.com>, linux-kernel@vger.kernel.org
Subject: Re: Why are bad disk sectors numbered strangely, and what happens to them?
Message-ID: <20031014072441.GA13117@bitwizard.nl>
References: <32a101c3916c$e282e330$5cee4ca5@DIAMONDLX60> <200310131014.h9DAEwY3000241@81-2-122-30.bradfords.org.uk> <33a201c39174$2b936660$5cee4ca5@DIAMONDLX60> <20031014064925.GA12342@bitwizard.nl> <3F8BA037.9000705@sbcglobal.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F8BA037.9000705@sbcglobal.net>
User-Agent: Mutt/1.3.28i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 14, 2003 at 02:05:27AM -0500, Wes Janzen wrote:
> >I've seen a disk (which now failed and will be replaced 3 hours from now)
> >remap defective sectors without reporting any errors to the OS. 
> >The SMART "remapped sector count" just went up, but no errors in the
> >logs. So apparently, the disk noticed something and remapped teh sector
> >without anybody noticing. 
> > 
> >
> Can't you pretty much get the drive to check itself using smartctl, such 
> as running:
>     smartctl -o on -s on -S on /dev/hde &> /dev/null

I strongly recommend you  store the output somewhere. This way you
will get to ignore for instance:
	hde: no such device
without being ABLE to notice it. (being an initscript, outputting to
stdout is not good. Store it in /var/log somewhere)

> in an init script?  Also, I think if you just happen to write to a bad 
> sector the drive will remap it without a warning (unless it doesn't have 
> any remapping sectors left), but if you read from it then to get the 
> drive to "notice" it, you have to write back to that sector.  Or run the 
> drive test which should find it and correct it.

The drive which I'm replacing has had a total of 22 powercycles.
Something like 15 powercycles seem to happen during "install", we
had some hardware problems after that (replaced the motherboard)
in apparently another 7 power cycles. That's all. 

If you manage to get the drive to notice sectors going bad
just before they actually GO bad, then you'll see an exponential
increase in sectors going bad, resulting in the drive quickly 
running out of spare sectors. This defeats the purpose of SMART
in alerting you to a failing drive before it costs you your valuable
data.

If an area of say 2mm x 2mm is going bad, then that's already many
megabytes on a modern drive. The drive is going to decide to remap
sectors there on a case-by-case basis, keeping on storing your valuable
data in sectors which just didn't get noticed. You don't have the
ability to notice the structure in the bad sectors. 

If say a read-amp is slowly going bad, the worst sectors are going 
first, but the whole drive will fail soonish. 

Take it as a warning. Take the drive back on warranty. Point them to the
marketingspeak on the box which says: "defect free interface" or
somethign like that. You want a drive without bad sectors. 

If you can't take it back, move it away to your "long term storage"
disk, where you keep the backup of your CD collection or something like
that. Don't put anything important on it. 

			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
**** "Linux is like a wigwam -  no windows, no gates, apache inside!" ****
