Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422857AbWI2WEd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422857AbWI2WEd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 18:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422856AbWI2WEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 18:04:33 -0400
Received: from qb-out-0506.google.com ([72.14.204.235]:18242 "EHLO
	qb-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1422852AbWI2WEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 18:04:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ESh6TWHO8F7TY9tjxObT7F0Hj62mrD8kWzldVJQEuhMJ6OfXxFeauAcwbzvixjglD2EclMZrn5tzJLZA3urIjxKViscSVCML6t8i6+IWGJZ81TymajOdTZvTLdytHJS923eRbSbERPsrW3CTAPe9NDZcK9PnVR5SkVY0QpCu2iA=
Message-ID: <5a4c581d0609291504r40bc1796q715c5ffa41aa7b1b@mail.gmail.com>
Date: Sat, 30 Sep 2006 00:04:31 +0200
From: "Alessandro Suardi" <alessandro.suardi@gmail.com>
To: jt@hpl.hp.com
Subject: Re: 2.6.18-git9 wireless fixes break ipw2200 association to AP with WPA
Cc: "John W. Linville" <linville@tuxdriver.com>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <20060929212748.GA10288@bougret.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <5a4c581d0609291225r4a2cbaacr35e5ef73d69f8718@mail.gmail.com>
	 <20060929202928.GA14000@tuxdriver.com>
	 <5a4c581d0609291340q835571bg9657ac0a68bab20e@mail.gmail.com>
	 <20060929212748.GA10288@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/29/06, Jean Tourrilhes <jt@hpl.hp.com> wrote:
> On Fri, Sep 29, 2006 at 10:40:29PM +0200, Alessandro Suardi wrote:
> > On 9/29/06, John W. Linville <linville@tuxdriver.com> wrote:
> > >On Fri, Sep 29, 2006 at 09:25:53PM +0200, Alessandro Suardi wrote:
> > >> Dell Latitude D610, FC5-latest, ipw2200 configured to associate
> > >> with a D-Link DSL-G604T (combo of router/ADSL modem/802.11g AP).
> > >>
> > >> 2.6.18-git8 (plus semaphore.h) is ok
> > >> -git9, -git10, -git11 fail to associate
> > >> -git11 with reverted wireless changes is ok
> > >>
> > >> Attaching diff of what I reverted in -git11 to make it work again.
> > >>
> > >> wpa_supplicant log of failing session available upon request.
> > >
> > >It looks like you reverted the WE-21 stuff.  Is your wireless-tools
> > >package up to date?
> >
> > Well, that's the latest I get under FC5:
> >
> > [asuardi@sandman ~]$ rpm -q wireless-tools
> > wireless-tools-28-0.pre13.5.1
>
>         That's too old, the cutoff is 27-pre15.

Are you sure ? For how I read it, 28-0.pre13.5.1 is more recent
 than 27-pre15, not older.

> > but indeed (-git11 minus the reverts) iwconfig says
> >
> > [asuardi@sandman ~]$ iwconfig eth1
> > Warning: Driver for device eth1 has been compiled with version 21
> > of Wireless Extension, while this program supports up to version 19.
> > Some things may be broken...
>
>         That's exactly the point of this warning (some distro like to
> kill it), I think it spells pretty clearly what's wrong. Don't say I
> did not warn you...

Oh, but I think I've seen these warnings forever in the last years ;)

> > If you have suggestions about either upgrading wireless-tools
> > from a non-FC5 repository or narrowing down the reverts, I'm
> > up for giving them a go :)
>
>         If you run a custom kernel, I think you won't see any problems
> running a custom version of Wireless Tools. They are available on my
> web site, pretty easy to install, and have minimal
> implications. Usually distro do no customisation of my tools.

Indeed - it's not a problem to me :)

However, I downloaded and built the wireless_tools.29.pre10.tar.gz
 sources from your pages and the problem is still there - minus the
 iwconfig warning... more precisely,

 -git8 works
 -git9 fails
 -git11 fails
 -git11 minus the reverts works, and says

[asuardi@sandman ~]$ iwconfig -v
iwconfig  Wireless-Tools version 29
          Compatible with Wireless Extension v11 to v21.

Kernel    Currently compiled with Wireless Extension v21.

eth1      Recommend Wireless Extension v18 or later,
          Currently compiled with Wireless Extension v21.

[asuardi@sandman ~]$ ldd /sbin/iwconfig
        linux-gate.so.1 =>  (0xb7f87000)
        libiw.so.29 => /lib/libiw.so.29 (0xb7f72000)
        libm.so.6 => /lib/libm.so.6 (0x46b0d000)
        libc.so.6 => /lib/libc.so.6 (0x469d8000)
        /lib/ld-linux.so.2 (0x469bb000)

So I guess there's an actual bug that doesn't depend on the
 wireless-tools. Or maybe it's wpa_supplicant that has to be
 upgraded ?

[asuardi@sandman ~]$ rpm -q wpa_supplicant
wpa_supplicant-0.4.8-10.fc5

>         On the other hand, FC6, which is in beta, contains already the
> proper version of the tools. I have been monitoring the various distro
> in the last few months before sending those WE-21 patches, and all
> major distro have WT-28 in the pipeline.

Even if so, wireless-tools would be the only package I have to
 build out of the FC5 distribution to keep up with the latest -git
 snapshot of the Torvalds kernel... I'm not especially troubled
 with this anyway. Perhaps you could push the Fedora folks to
 be a bit more up-to-date with wireless-tools in their current
 main version ?

>         Actually, you might be able to install the wireless-tools RPM
> of FC6 of FC-dev onto your FC5.

Still listening on how to further research the issue... many thanks
 in the meantime, ciao,

--alessandro

"Well a man has two reasons for things that he does
  the first one is pride and the second one is love
  all understandings must come by this way"

     (Husker Du, 'She Floated Away')
