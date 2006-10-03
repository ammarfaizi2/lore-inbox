Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932087AbWJCMxM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbWJCMxM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 08:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932085AbWJCMxL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 08:53:11 -0400
Received: from wx-out-0506.google.com ([66.249.82.226]:15040 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932087AbWJCMxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 08:53:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LGcN6LZnVj7fOEMW/WntkaMmr5drejDwDpEjgYd6MHNTx9YbdJbv8JoYrzQRv2Fvtc2qTwW00PldBv0NGJ7Nl8CZAVe+owgSsfuwj9KDTFg1DcoApbP5/7StusjB/5WW7lrLDFWz4XX3hTkvc9ttOAszUS9vRbZyYC87vLgQh1o=
Message-ID: <5a4c581d0610030553n643fe289p8ebaec56161faa75@mail.gmail.com>
Date: Tue, 3 Oct 2006 12:53:08 +0000
From: "Alessandro Suardi" <alessandro.suardi@gmail.com>
To: "Dan Williams" <dcbw@redhat.com>
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
Cc: "Theodore Tso" <tytso@mit.edu>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       jt@hpl.hp.com, "Andrew Morton" <akpm@osdl.org>,
       "John W. Linville" <linville@tuxdriver.com>,
       "Norbert Preining" <preining@logic.at>, hostap@shmoo.com,
       linux-kernel@vger.kernel.org, ipw3945-devel@lists.sourceforge.net
In-Reply-To: <1159877574.2879.11.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061002085942.GA32387@gamma.logic.tuwien.ac.at>
	 <20061002111537.baa077d2.akpm@osdl.org>
	 <20061002185550.GA14854@bougret.hpl.hp.com>
	 <200610022147.03748.rjw@sisk.pl>
	 <1159822831.11771.5.camel@localhost.localdomain>
	 <20061002212604.GA6520@thunk.org>
	 <5a4c581d0610021508hdc331f0w7c9b71c3944d4d8b@mail.gmail.com>
	 <1159877574.2879.11.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/06, Dan Williams <dcbw@redhat.com> wrote:
> On Tue, 2006-10-03 at 00:08 +0200, Alessandro Suardi wrote:
> > On 10/2/06, Theodore Tso <tytso@mit.edu> wrote:
> > > On Mon, Oct 02, 2006 at 05:00:31PM -0400, Dan Williams wrote:
> > > > Distributions _are_ shipping those tools already.  The problem is more
> > > > with older distributions where, for example, the kernel gets upgraded
> > > > but other stuff does not.  If a kernel upgrade happens, then the distro
> > > > needs to make sure userspace works with it.  That's nothing new.
> > >
> > > Um, *which* distro's are shipping it already?  RHEL4?  SLES10?  I
> > > thought we saw a note saying that even Debian **unstable** didn't have
> > > a new enough version of the wireless-tools....
> >
> > That was my point initially. FC5-latest is apparently carrying
> >  tools which are "too old"... and I yum update twice or thrice
> >  a week. Not that *I* minded building packages from source,
> >  but this is likely a bit too much for a good slice of the userbase.
>
> And that's my fault.  I was made aware of this issue last week and am
> currently testing out the newer wireless-tools with the intention of
> pushing them to FC5-updates.  Had I actually been tracking the
> wireless-tools release cycle more closely, I would have pushed the
> wireless-tools-28 final version when it came out.
>
> But, as far as I know (please correct me if I'm wrong), that 2.6.18
> doesn't actually include WE-21! [1]  Somebody is trying to run
> out-of-kernel ipw3945 drivers using a 2.6.18 kernel from FC5 that's
> WE-20 only, but the driver uses WE-21?
>
> ipw3945 isn't in the upstream kernel, and Fedora certainly isn't going
> to go out of its way to make sure every piece of software under the sun
> that's not included in the distro works with it [2].  Distros try to
> make sure they are internally consistent, not globally consistent.  If
> somebody uses out-of-kernel drivers, they take that responsibility.  The
> solution to the problem is to make sure that ipw3945 gets in the kernel
> as quickly as possible, something I think we'd all like to have happen.
>
> Dan
>
> [1] /lib/modules/2.6.18-1.2708.fc6/build/include/linux/wireless.h
> defines WIRELESS_EXT = 20
>
> [2] Yeah it would be nice; but go out of the way to have Skype w/ OSS,
> Nvidia binary drivers, ATI binary drivers, ndiswrapper,
> out-of-kernel-drivers?  No.

While strongly agreeing with the above reasoning, I'd just
 point out that the two current reports were

 mine -> FC5, in-kernel ipw2200, wpa_supplicant and wireless-tools "too old",
   rebuild userspace from recent sources => all fine and dandy

 Norbert's -> Debian unstable, out-of-kernel ipw3945, wpa_supplicant okay,
   wireless-tools "too old", rebuild these from recent sources =>
still a few issues

 so it was only myself running FC5, and with a WE-21 capable Torvalds kernel
 as I test at least 4 -git snapshots per week (and yes, 2.6.18 doesn't
have WE-21,
 which is the root of the reports - WE-21 went in in 2.6.18-git9).


Indeed the in-kernel driver appeared to be the easily solved case, as
expected...

Thanks, ciao,

--alessandro

"Well a man has two reasons for things that he does
  the first one is pride and the second one is love
  all understandings must come by this way"

     (Husker Du, 'She Floated Away')
