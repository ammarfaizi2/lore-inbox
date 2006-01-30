Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964819AbWA3Ric@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964819AbWA3Ric (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 12:38:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964839AbWA3Ric
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 12:38:32 -0500
Received: from cpanel02.rubas.net ([62.216.182.2]:58072 "EHLO
	cpanel02.rubas.net") by vger.kernel.org with ESMTP id S964819AbWA3Rib convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 12:38:31 -0500
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
From: =?ISO-8859-1?Q?J=FCrg?= Billeter <j@bitron.ch>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: jengelh@linux01.gwdg.de, James@superbug.co.uk, mrmacman_g4@mac.com,
       matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       acahalan@gmail.com
In-Reply-To: <43DDFBFF.nail16Z3N3C0M@burner>
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com>
	 <43D7A7F4.nailDE92K7TJI@burner>
	 <8614E822-9ED1-4CB1-B8F0-7571D1A7767E@mac.com>
	 <43D7B1E7.nailDFJ9MUZ5G@burner>
	 <20060125230850.GA2137@merlin.emma.line.org>
	 <43D8C04F.nailE1C2X9KNC@burner> <200  <43DDFBFF.nail16Z3N3C0M@burner>
Content-Type: text/plain; charset=UTF-8
Date: Mon, 30 Jan 2006 18:38:03 +0100
Message-Id: <1138642683.7404.31.camel@juerg-pd.bitron.ch>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.5 
Content-Transfer-Encoding: 8BIT
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel02.rubas.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - bitron.ch
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jörg

On Mon, 2006-01-30 at 12:43 +0100, Joerg Schilling wrote:
> > Hm, this ATAPI stuff makes me a headache. Well, anyway, out of 
> > curiosity, what is an ATAPI drive (IDE-ATAPI) supposed to return when asked 
> > for bus number, id or lun - independent of OS and/or cdrecord?
> 
> The drive does not return this information, but the SCSI subsystem creates
> these instance numbers. A SCSI drive (like a CD/DVD burner) is supposed to
> be known to the SCSI sub-system and thus needs to have a SCSI subsystem
> related instance number.

Whenever someone talks about ATAPI drives, you respond with
s/ATAPI/SCSI/. Why do you insist that every transport should be used as
it was a SCSI bus? ATAPI drives use the same SCSI command set as SCSI
drives do, but that won't change the fact that ATAPI drives are not
connected to a SCSI bus.

It makes sense to address parallel SCSI devices via target id. If an
operating system likes to simulate virtual SCSI buses for other bus
types as well, ok, I have no objections. But if the operating system
doesn't like to simulate virtual SCSI buses and allows applications to
address devices by a filename, you should have no objections, too.

You and the linux developers just look at the same thing from two
perspectives. You seem to like SCSI buses, so you want to look at every
bus as it is was a SCSI bus. The linux developers seem to like the
principle of looking at single devices without obvious connection to a
physical or virtual bus from the application. There is no right or
wrong, here, that are just two different perspectives. As the linux
developers seem to like their approach - I do as well -, they won't
change their system and recommend application developers to use SG_IO on
device nodes and ignore the physical bus the devices are connected with.

Whatever the interface between cdrecord and libscg is, is obviously your
choice. But the libscg backend for linux should follow the
recommendations of the linux kernel developers and they recommend to use
SG_IO on device nodes, AFAICT. The command line interface of cdrecord is
obviously your choice again but IMO it should integrate in the system it
currently runs on and as linux command line users know how to deal with
device nodes, they want to use them.

As you were having the SCSI-only perspective in mind when writing the
scanbus functionality, it obviously doesn't fit well in the scheme of
the device-based perspective of linux. As there is no virtual parent of
all real and virtual SCSI buses in linux, libscg shouldn't try to find
one. The linux backend of libscg should just use HAL to enumerate the
devices.

It would be nice to get a comment whether this makes sense or which
statements you don't agree with.

Schönen Abend

Jürg
-- 
Jürg Billeter <j@bitron.ch>

