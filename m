Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262267AbRERHpP>; Fri, 18 May 2001 03:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262268AbRERHpG>; Fri, 18 May 2001 03:45:06 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:4615 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S262267AbRERHoq>;
	Fri, 18 May 2001 03:44:46 -0400
Date: Fri, 18 May 2001 03:43:07 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Michael Meissner <meissner@spectacle-pond.org>,
        Keith Owens <kaos@ocs.com.au>, CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: CML2 design philosophy heads-up
Message-ID: <20010518034307.A10784@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Tom Rini <trini@kernel.crashing.org>,
	Michael Meissner <meissner@spectacle-pond.org>,
	Keith Owens <kaos@ocs.com.au>, CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010517032636.A1109@thyrsus.com> <28870.990085661@kao2.melbourne.sgi.com> <20010517053549.A17562@munchkin.spectacle-pond.org> <20010517093411.A12740@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010517093411.A12740@opus.bloom.county>; from trini@kernel.crashing.org on Thu, May 17, 2001 at 09:34:11AM -0700
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini <trini@kernel.crashing.org>:
> > > SCSI emulation over IDE, CONFIG_BLK_DEV_IDESCSI.  You have the SCSI mid
> > > layer code but no SCSI hardware drivers.  It is a realistic case for an
> > > embedded CD-RW appliance.
> > 
> > Or alternatively, you want to enable SCSI code, with no hardware driver,
> > because you are going to build pcmcia, which builds the scsi drivers only
> > if CONFIG_SCSI is defined, and the user might put in an Adaptec 1460B or
> > 1480 scsi card into your pcmcia slot.
> 
> Both of these 'problems' assume that you can have IDE or PCMCIA on these
> particular boxes.  Does anyone know if that's actually true?

The answer is: no, you can't.  

I found a feature list for the MVME147 on the web at
<http://www.mcg.mot.com/cfm/templates/article.cfm?PageID=1095>.  It
confirmed what thought I remembered from the Motorola site; no PCMCIA,
no IDE/ATAPI.  As a matter of fact neither of these technologies
existed yet when the board was being designed in the mid-1980s.

(The article I found is kind of interesting.  It's a dissection of the
MVME147's design and history...narrated in first person.)

In any case, if this *had* been a problem, the right fix IMO would have
been to split the SCSI symbol into SCSI and SCSI_DRIVERS and have
constraints that would make SCSI and the presence of any SCSI card 
imply SCSI_DRIVERS.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

The prestige of government has undoubtedly been lowered considerably
by the Prohibition law. For nothing is more destructive of respect for
the government and the law of the land than passing laws which cannot
be enforced. It is an open secret that the dangerous increase of crime
in this country is closely connected with this.
	-- Albert Einstein, "My First Impression of the U.S.A.", 1921
