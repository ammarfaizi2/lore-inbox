Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266730AbSKUPQz>; Thu, 21 Nov 2002 10:16:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266723AbSKUPQz>; Thu, 21 Nov 2002 10:16:55 -0500
Received: from ihemail2.lucent.com ([192.11.222.163]:31206 "EHLO
	ihemail2.firewall.lucent.com") by vger.kernel.org with ESMTP
	id <S266721AbSKUPQx>; Thu, 21 Nov 2002 10:16:53 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15836.64140.186693.238318@gargle.gargle.HOWL>
Date: Thu, 21 Nov 2002 10:23:56 -0500
From: "John Stoffel" <stoffel@lucent.com>
To: Steven Dake <sdake@mvista.com>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org
Subject: Re: RFC - new raid superblock layout for md driver
In-Reply-To: <3DDC28E2.30404@mvista.com>
References: <15835.2798.613940.614361@notabene.cse.unsw.edu.au>
	<3DDBC0D9.5030904@mvista.com>
	<15836.8031.649441.843857@notabene.cse.unsw.edu.au>
	<3DDC28E2.30404@mvista.com>
X-Mailer: VM 7.07 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Steven> This is useful, atleast in the current raid implementation,
Steven> because md_import can be changed to return an error if the
Steven> device's unique identifier doesn't match the host identifier.
Steven> In this way, each device of a RAID volume is individually
Steven> locked to the specific host, and rejection occurs at import of
Steven> the device time.

This is a key issue on SANs as well.  I think that having the hosts'
UUID in the RAID superblock will allow rejection to happen
gracefully.  If needed, the user-land tools can have a --force
option. 

Steven> Perhaps locking using the name field would work except that
Steven> other userspace applications may reuse that name field for
Steven> some other purpose, not providing any kind of uniqueness.

I think the there needs to be two fields, a UUID field for the host
owning the RAID superblocks, and then a name field so that the host,
along with any other systems which can *view* the RAID superblock, can
know the user defined name.

John
   John Stoffel - Senior Unix Systems Administrator - Lucent Technologies
	 stoffel@lucent.com - http://www.lucent.com - 978-399-0479
