Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932182AbWGYI27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182AbWGYI27 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 04:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932185AbWGYI27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 04:28:59 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:54496 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932182AbWGYI26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 04:28:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Af2ufvYxZAttM7nFEhUSnP1U/UtsNYKBuYncIpFzcXFsc/ZTirEzqANZWnIvAOG+SmxFkV4f/qsD7gHlhFklSq7RjD6v106gyFT+dPtYpvoZIdWZYWAuRW4tq/32kz9uSo0ybz1jb1LkQIC6ji9JqTzmwWwFB/AZiH4cJtY43O0=
Message-ID: <f96157c40607250128h279d6df7n8e86381729b8aa97@mail.gmail.com>
Date: Tue, 25 Jul 2006 08:28:57 +0000
From: "gmu 2k6" <gmu2006@gmail.com>
To: "Jens Axboe" <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Re: i686 hang on boot in userspace
In-Reply-To: <20060725080002.GD4044@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <f96157c40607170902l47849e42qc4f1c64087a236d8@mail.gmail.com>
	 <f96157c40607171115r4acccb00r3f6d93e3477a3a13@mail.gmail.com>
	 <f96157c40607180238s1bfe0ca2te1d4d72dbe8626fd@mail.gmail.com>
	 <f96157c40607190326t1071377bvb426e00d6f427660@mail.gmail.com>
	 <f96157c40607240834i5ba3ca5cma51eec9fa34558bc@mail.gmail.com>
	 <20060725073208.GA10601@suse.de>
	 <f96157c40607250100x3850ffb7g1d2ed300529661f1@mail.gmail.com>
	 <20060725074107.GA4044@suse.de>
	 <f96157c40607250120s2554cbc6qbd7c42972b70f6de@mail.gmail.com>
	 <20060725080002.GD4044@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/06, Jens Axboe <axboe@suse.de> wrote:
> On Tue, Jul 25 2006, gmu 2k6 wrote:
> > On 7/25/06, Jens Axboe <axboe@suse.de> wrote:
> > >On Tue, Jul 25 2006, gmu 2k6 wrote:
> > >> On 7/25/06, Jens Axboe <axboe@suse.de> wrote:
> > >> >On Mon, Jul 24 2006, gmu 2k6 wrote:
> > >> >> the problem I have with hangs is related to changes in CFQ and that
> > >> >> CFQ is now the default. 2.6.17-git12 had the problem but booting
> > >> >> it with elevator=deadline fixes the hang.
> > >> >>
> > >> >> symptoms encountered during git-bisecting between v2.6.17 and
> > >> >v2.6.18-rc1:
> > >> >> A hang while starting network services
> > >> >> B hang while trying to login
> > >> >>   1 on remote console [not SSH] it hang after typing <uid><CR>
> > >> >>   1 via OpenSSH it hang after typing <pwd><CR> when doing slogin
> > >> >root@<IP>
> > >> >>
> > >> >> A is the problem I got in the first place and this seems to be the
> > >> >> case since 2.6.17-git11 definitely although git-bisect pointed me at
> > >> >> the following
> > >> >> changeset which is included since 2.6.17-git12:
> > >> >>
> > >> >> caaa5f9f0a75d1dc5e812e69afdbb8720e077fd3
> > >> >> by Jens Axboe
> > >> >> titled "[PATCH] cfq-iosched: many performance fixes"
> > >> >>
> > >> >> strange enough it also hangs with 2.6.17-git11 which did not include
> > >that
> > >> >> one changeset yet.
> > >> >
> > >> >So perhaps your bisect isn't 100% trust worthy? Can you do a manual
> > >> >-gitX bisect to see which 2.6.17-gitX introduced the problem?
> > >> >
> > >> >Also please put a serial console or similar on the machine, so you can
> > >> >log + store the sysrq+t output.
> > >>
> > >> well I didn't say that caa....fd3 is the exact change which broke it,
> > >> just that it's related to 1) CFQ changes and 2) CFQ being the default
> > >> now.
> > >> I have a Remote Serial Console via HP's integrated Lights-Out Java
> > >> Applet but am not sure how to enable serial console via kernel boot
> > >> params (will try to find out).
> > >> I will first try to find the 2.6.17-git* revision working before
> > >> bisecting it against -git11 or git12.
> > >
> > >Thanks, would be much appreciated to try and narrow it down to a
> > >specific fix.
> > >
> > >Are you seeing the hang on cciss?
> >
> > I'm not sure it is in the cciss driver, but the SmartArray is driven by
> > cciss.
> > starting git<11 boot tests in a minute now.
>
> Ok, thanks for confirming it's cciss. The bug is likely an interaction
> between cciss and cfq I think, so it would be very useful if you can pin
> point which of the cfq patches make it stall.

is there anything special about cciss or did you just deduce that it
must be cciss in that particular box and are suspecting interaction
problems with that driver and your CFQ changes?
