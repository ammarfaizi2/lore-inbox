Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265275AbTB0PjY>; Thu, 27 Feb 2003 10:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265276AbTB0PjY>; Thu, 27 Feb 2003 10:39:24 -0500
Received: from poup.poupinou.org ([195.101.94.96]:25135 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP
	id <S265275AbTB0PjX>; Thu, 27 Feb 2003 10:39:23 -0500
Date: Thu, 27 Feb 2003 16:49:22 +0100
To: Pavel Machek <pavel@suse.cz>
Cc: Robert Woerle Paceblade/Support <robert@paceblade.com>,
       "Grover, Andrew" <andrew.grover@intel.com>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] Re: mem= option for broken bioses
Message-ID: <20030227154922.GY13404@poup.poupinou.org>
References: <F760B14C9561B941B89469F59BA3A8471380D7@orsmsx401.jf.intel.com> <20030226224450.GD15455@atrey.karlin.mff.cuni.cz> <3E5E2061.2060807@paceblade.com> <20030227151907.GC12434@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030227151907.GC12434@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.4i
From: Ducrot Bruno <ducrot@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2003 at 04:19:07PM +0100, Pavel Machek wrote:
> Hi!
> 
> > >>OK, looks reasonable. Can you also gen up a patch documenting this in
> > >>kernel-parameters.txt?
> > >>   
> > >>
> > >
> > >You can, assuming you took the patch ;-).
> > > 
> > >
> > well how can i find the correct value`s to put in ??
> 
> Well, similar method to how you use mem=123@456 parameters. You just
> guess them. [Given kernel messages, it is actually quite easy.]
> 

If I understand you,  you then just have to mem= with the correct
value reported via, for example:

ducrot@novae:~$ dmesg | grep 'ACPI data'
 BIOS-e820: 000000000fef0000 - 000000000feff000 (ACPI data)

Interresting :)

Ok.  Here is actually a method:
A phoenix bios (and you have one) will reserved typically 64ko
for ACPI data below ACPI NVS.

ducrot@novae:~$ dmesg | grep -i 'ACPI NVS'
 BIOS-e820: 000000000feff000 - 000000000ff00000 (ACPI NVS)
ducrot@novae:~$ python
Python 2.1.1+ (#1, Jan  8 2002, 00:37:12) 
[GCC 2.95.4 20011006 (Debian prerelease)] on linux2
Type "copyright", "credits" or "license" for more information.
>>> 0x000000000feff000 - 65536
267317248

If my bios will be incorrect, I will then pass
mem=267317248#65536
and voila.


But big problem though.  It is really really strange that the
BIOS mainteners have broken e820 call, are you sure you have
enabled acpi in BIOS, and/or power management ?

Cheers,

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
