Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318202AbSIJWrf>; Tue, 10 Sep 2002 18:47:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318203AbSIJWrf>; Tue, 10 Sep 2002 18:47:35 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:63722 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S318202AbSIJWre>; Tue, 10 Sep 2002 18:47:34 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Oktay Akbal <oktay.akbal@s-tec.de>
Date: Wed, 11 Sep 2002 08:51:56 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15742.30604.313336.285853@notabene.cse.unsw.edu.au>
Cc: Lars Marowsky-Bree <lmb@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: md multipath with disk missing ?
In-Reply-To: message from Oktay Akbal on Monday September 9
References: <20020909132713.GA29@marowsky-bree.de>
	<Pine.LNX.4.44.0209091537020.12771-100000@omega.s-tec.de>
X-Mailer: VM 7.07 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday September 9, oktay.akbal@s-tec.de wrote:
> > > Does this only work with raid-autodetection ?
> > > When no autodetection is done and a drive is missing, would a raidstart
> > > kill the raid, since the drives are now available with other devices (sda
> > > instead of former sdb...) ?
> >
> > I don't understand your question, sorry.
> 
> Example:
> 
> We have sda - sdb (8 drives) and setup up a raidtab to tell linux that
> sda and sde are the same sdc - sdd etc.
> Now for some random error the server restarts and the former sda (path to
> that drive) is no longer available. So now we have sda,sdb...sdg.
> We do not use autodetect, but raidstart to activate the raid.

raidstart is broken by design and cannot cope with devices that change
device number (whether name in /dev is preserved or not.  There are
device numbers in the superblock which raidstart trusts).

This is one of the reasons that I wrote mdadm
   http://www.cse.unsw.edu.au/~neilb/source/mdadm/

This affects all raid levels, not just multipath.

NeilBrown
