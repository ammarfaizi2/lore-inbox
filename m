Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317354AbSH0XgJ>; Tue, 27 Aug 2002 19:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317371AbSH0XgJ>; Tue, 27 Aug 2002 19:36:09 -0400
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:12798 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S317354AbSH0XgH>; Tue, 27 Aug 2002 19:36:07 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15724.3548.862436.514142@wombat.chubb.wattle.id.au>
Date: Wed, 28 Aug 2002 09:40:12 +1000
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Pavel Machek <pavel@suse.cz>, Peter Chubb <peter@chubb.wattle.id.au>,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: Large block device patch, part 1 of 9
In-Reply-To: <20020827185833.B26573@redhat.com>
References: <15717.52317.654149.636236@wombat.chubb.wattle.id.au>
	<20020823070759.GS19435@clusterfs.com>
	<20020827152303.L35@toy.ucw.cz>
	<20020827185833.B26573@redhat.com>
X-Mailer: VM 7.04 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Ben" == Benjamin LaHaise <bcrl@redhat.com> writes:

Ben> On Tue, Aug 27, 2002 at 03:23:04PM +0000, Pavel Machek wrote:
>> Hi!
>> 
>> > Then the following works properly without ugly casts or warnings:
>> > 
>> > __u64 val = 1;
>> > 
>> > printk("at least "PFU64" of your u64s are belong to us\n", val);
>> 
>> Casts are ugly but this looks even worse. I'd go for casts.

Ben> Casts override the few type checking abilities the compiler gives
Ben> us.  At least with the PFU64 style, we'll get warnings when
Ben> someone changes a variable into a pointer without remembering to
Ben> update the printk.

We did go through all this after the first or second incarnation of
this patch, back in May.  After going around in circles for a bit, the
use of casts seemed then to win the day.

If Linus has a major objection I'll redo things.

The main advantage of casts, to me at present, is it allows the
patches to be incremental.  Not all places that should be sector_t are
yet --- some are int, and some are long.  Casting them all to unsigned
long long and printing with %llu works now, before all the places are
changed (in patch 3 or 4 IIRC).

See the thread that starts at 
   http://marc.theaimsgroup.com/?l=linux-kernel&m=102100347212072&w=2

--
Dr Peter Chubb				    peterc@gelato.unsw.edu.au
You are lost in a maze of BitKeeper repositories, all almost the same.
