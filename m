Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752196AbWKBMdD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752196AbWKBMdD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 07:33:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752207AbWKBMdD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 07:33:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:3745 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1752196AbWKBMdA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 07:33:00 -0500
From: Neil Brown <neilb@suse.de>
To: "Kay Sievers" <kay.sievers@vrfy.org>
Date: Thu, 2 Nov 2006 23:32:49 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17737.58737.398441.111674@cse.unsw.edu.au>
Cc: "Greg KH" <gregkh@suse.de>, "Andrew Morton" <akpm@osdl.org>,
       linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 001 of 6] md: Send online/offline uevents when an md array starts/stops.
In-Reply-To: message from Kay Sievers on Thursday November 2
References: <20061031164814.4884.patches@notabene>
	<1061031060046.5034@suse.de>
	<20061031211615.GC21597@suse.de>
	<3ae72650611020413q797cf62co66f76b058a57104b@mail.gmail.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday November 2, kay.sievers@vrfy.org wrote:
> On 10/31/06, Greg KH <gregkh@suse.de> wrote:
> > On Tue, Oct 31, 2006 at 05:00:46PM +1100, NeilBrown wrote:
> > >
> > > This allows udev to do something intelligent when an
> > > array becomes available.
> > >
> > > cc: gregkh@suse.de
> > > Signed-off-by: Neil Brown <neilb@suse.de>
> >
> > Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
> 
> I don't agree with this, and asked several times to change this to
> "change" events, like device-mapper is doing it to address the same
> problem. Online/offline is not supported by udev/HAL and will not work
> as expected. Please fix this.

I don't remember who suggested "online/offline", and I don't remember
you suggesting "change", but my memory isn't what it used to be(*), so you
probably did.

Is there some document somewhere that explains exactly what each of
the kobject_actions are meant to mean and how they can be
interpreted?

Anyway, I am happy to change it.  What exactly do you want?
KOBJ_CHANGE both when the array is activated and when it is
deactivated?  Or only when it is activated?
Should ONLINE and OFFLINE remain and CHANGE be added, or should they
go away?
If they remain, should CHANGE come before or after ONLINE (and
OFFLINE)?


I must admit that it feels more like an ONLINE/OFFLINE event than a
CHANGE event to me, but they are just words after all.

What does udev/HAL do with ONLINE/OFFLINE?  Could it be changed to do
"the right thing" for ONLINE? (Not implying that it should be, just
wanting to understand as much of the picture as possible).

Thanks,
NeilBrown


(*) At least I think it isn't what it used to be, but I cannot
remember what it used to be, so I'm not sure :-)
