Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263246AbSKTXEv>; Wed, 20 Nov 2002 18:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263188AbSKTXEv>; Wed, 20 Nov 2002 18:04:51 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:34211 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S263228AbSKTXEt>; Wed, 20 Nov 2002 18:04:49 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Thu, 21 Nov 2002 10:11:43 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15836.5807.792124.255167@notabene.cse.unsw.edu.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-raid@vger.kernel.org
Subject: Re: RFC - new raid superblock layout for md driver
In-Reply-To: message from Alan Cox on  November 20
References: <15835.2798.613940.614361@notabene.cse.unsw.edu.au>
	<1037801381.3267.17.camel@irongate.swansea.linux.org.uk>
X-Mailer: VM 7.07 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  November 20, alan@lxorguk.ukuu.org.uk wrote:
> On Wed, 2002-11-20 at 04:09, Neil Brown wrote:
> >     u32  set_uuid[4]
> 
> Wouldnt u8 for the uuid avoid a lot of endian mess

Probably....
This makes it very similar to 'name'.  
The difference if partly the intent for how user-space would use it,
and partly that set_uuid must *never* change, while you would probably
want name to be allowed to change.


> 
> >     u32  ctime
> 
> Use some padding so you can go to 64bit times
> 
Before or after?  Or just make it 64bits of seconds now?
This brings up endian-ness?  Should I assert 'little-endian' or should
the code check the endianness of the magic number and convert if
necessary?
The former is less code which will be exercised more often, so it is
probably safe.

So:
  All values shall be little-endian and times shall be stored in 64
  bits with the top 20 bits representing microseconds (so we & with
  (1<<44)-1  to get seconds.

Thanks.

NeilBrown
