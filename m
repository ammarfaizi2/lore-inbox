Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274991AbRIYNGT>; Tue, 25 Sep 2001 09:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274992AbRIYNGI>; Tue, 25 Sep 2001 09:06:08 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:45446
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S274991AbRIYNF7> convert rfc822-to-8bit; Tue, 25 Sep 2001 09:05:59 -0400
Date: Tue, 25 Sep 2001 09:06:02 -0400
From: Chris Mason <mason@suse.com>
To: comandante@zaralinux.com, tegeran@home.com
cc: Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: [reiserfs-list] Re: [PATCH] 2.4.10 improved reiserfs a lot, but
 could still be better
Message-ID: <327790000.1001423162@tiny>
In-Reply-To: <3BB07EA2.4010804@juridicas.com>
In-Reply-To: <B0005839269@gollum.logi.net.au>
 <20010924173210.A7630@emma1.emma.line.org>
 <20010924161518.KYHD11251.femail27.sdc1.sfba.home.com@there>
 <3BB07EA2.4010804@juridicas.com>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tuesday, September 25, 2001 02:54:58 PM +0200 Jorge Nerín
<jnerin@juridicas.com> wrote:
>> 
> Who says test.zero is a linear file and it's not scattered around the
> whole disk and the fs layer is filling holes...? If it's the case the
> write cache is a BIG win, just think that the fs writes a chunk at the
> beggining of the disk, then another chunk at the end, then another near
> the beginning, then...  you get the picture, in this case the disk
> reorders the seeks to best fit.
> 
> If you want to try a REAL linear write do a dd if=/dev/zero of=/dev/hde7
> or whatever unused partition you have.
> 

Exactly, especially since during the dd you're going to seek back to the
log for a few commit writes.

>From a filesystem point of view, I've spent hours and hours getting
reiserfs to order the writes correctly to keep data consistent after a
crash.  Turning on writeback caching without a battery backup more or less
throws all that work out the window.  Don't do it.

For some people, a UPS counts as a battery backup, but there are lots of
reasons that doesn't fly in any kind of production environment.  If your
job somehow depends on the data being safe, just get a raid controller with
batter backed cache.

-chris



