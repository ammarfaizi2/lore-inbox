Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750940AbWHAVYy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbWHAVYy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 17:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750984AbWHAVYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 17:24:54 -0400
Received: from mx1.redhat.com ([66.187.233.31]:11724 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750940AbWHAVYx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 17:24:53 -0400
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: David Greaves <david@dgreaves.com>, Neil Brown <neilb@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org
Subject: Re: let md auto-detect 128+ raid members, fix potential race condition
References: <ork65veg2y.fsf@free.oliva.athome.lsd.ic.unicamp.br>
	<20060730124139.45861b47.akpm@osdl.org>
	<orac6qerr4.fsf@free.oliva.athome.lsd.ic.unicamp.br>
	<17613.16090.470524.736889@cse.unsw.edu.au>
	<ord5blcyg0.fsf@free.oliva.athome.lsd.ic.unicamp.br>
	<44CE7A9B.8020508@dgreaves.com>
	<oru04xrych.fsf@free.oliva.athome.lsd.ic.unicamp.br>
	<44CF109C.7060008@tls.msk.ru>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat OS Tools Group
Date: Tue, 01 Aug 2006 18:24:11 -0300
In-Reply-To: <44CF109C.7060008@tls.msk.ru> (Michael Tokarev's message of "Tue, 01 Aug 2006 12:28:12 +0400")
Message-ID: <orpsfkf8uc.fsf@free.oliva.athome.lsd.ic.unicamp.br>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.5-b27 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug  1, 2006, Michael Tokarev <mjt@tls.msk.ru> wrote:

> Alexandre Oliva wrote:
> []
>> If mdadm can indeed scan all partitions to bring up all raid devices
>> in them, like nash's raidautorun does, great.  I'll give that a try,

> Never, ever, try to do that (again).  Mdadm (or vgscan, or whatever)
> should NOT assemble ALL arrays found, but only those which it has
> been told to assemble.  This is it again: you bring another disk into
> a system (disk which comes from another machine), and mdadm finds
> FOREIGN arrays and brings them up as /dev/md0, where YOUR root
> filesystem should be.  That's what 'homehost' option is for, for
> example.

Exactly.  So make it /all/all local/, if you must.  It's the same as
far as I'm concerned.

> If initrd should be reconfigured after some changes (be it raid
> arrays, LVM volumes, hostname, whatever), -- I for one am fine
> with that.

Feel free to be fine with it, as long as you also let me be free to
not be fine with it and try to cut a better deal :-)

-- 
Alexandre Oliva         http://www.lsd.ic.unicamp.br/~oliva/
Secretary for FSF Latin America        http://www.fsfla.org/
Red Hat Compiler Engineer   aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist  oliva@{lsd.ic.unicamp.br, gnu.org}
