Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281579AbRK0Quy>; Tue, 27 Nov 2001 11:50:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281478AbRK0Qub>; Tue, 27 Nov 2001 11:50:31 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:2822 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S281504AbRK0QuT>; Tue, 27 Nov 2001 11:50:19 -0500
Date: Tue, 27 Nov 2001 17:50:16 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Journaling pointless with today's hard disks?
Message-ID: <20011127175016.D13416@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10111261229190.8817-100000@master.linux-ide.org> <0111261535070J.02001@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <0111261535070J.02001@localhost.localdomain>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please fix your domain in your mailer, localhost.localdomain is prone
for Message-ID collisions.


Note, the power must RELIABLY last until all of the data has been
writen, which includes reassigning, seeking and the like, just don't do
it if you cannot get a real solution. battery-backed CMOS,
NVRAM/Flash/whatever which lasts a couple of months should be fine
though, as long as documents are publicly available that say how long
this data lasts. Writing to disk will not work out unless you can keep
the drive going for several seconds which will require BIG capacitors,
so that's no option, you must go for NVRAM/Flash or something.

OTOH, the OS must reliably know when something went wrong (even with
good power it has a right to know), and preferably this scheme should
not involve disabling the write cache, so TCQ or something mandatory
would be useful (not sure if it's mandatory in current ATA standards).

If a block has first been reported written OK and the disk later reports
error, it must send the block back (incompatible with any current ATA
draft I had my hands on), so I think tagged commands which are marked
complete only after write+verify are the way to go.

-- 
Matthias Andree

"They that can give up essential liberty to obtain a little temporary
safety deserve neither liberty nor safety."         Benjamin Franklin
