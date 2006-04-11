Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750964AbWDKQU5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964AbWDKQU5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 12:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750965AbWDKQU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 12:20:57 -0400
Received: from MAIL.13thfloor.at ([212.16.62.50]:18318 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S1750914AbWDKQU4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 12:20:56 -0400
Date: Tue, 11 Apr 2006 18:20:55 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Kirill Korotaev <dev@sw.ru>
Cc: Bill Davidsen <davidsen@tmr.com>, Kir Kolyshkin <kir@openvz.org>,
       akpm@osdl.org, Nick Piggin <nickpiggin@yahoo.com.au>, sam@vilain.net,
       linux-kernel@vger.kernel.org,
       "Eric W. Biederman" <ebiederm@xmission.com>, serue@us.ibm.com,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Subject: Re: [Devel] Re: [RFC] Virtualization steps
Message-ID: <20060411162055.GA22367@MAIL.13thfloor.at>
Mail-Followup-To: Kirill Korotaev <dev@sw.ru>,
	Bill Davidsen <davidsen@tmr.com>, Kir Kolyshkin <kir@openvz.org>,
	akpm@osdl.org, Nick Piggin <nickpiggin@yahoo.com.au>,
	sam@vilain.net, linux-kernel@vger.kernel.org,
	"Eric W. Biederman" <ebiederm@xmission.com>, serue@us.ibm.com,
	Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
References: <1143228339.19152.91.camel@localhost.localdomain> <200603282029.AA00927@bbb-jz5c7z9hn9y.digitalinfra.co.jp> <4429A17D.2050506@openvz.org> <443151B4.7010401@tmr.com> <443B873B.9040908@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <443B873B.9040908@sw.ru>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2006 at 02:38:51PM +0400, Kirill Korotaev wrote:
> Bill,
> 
> >>OpenVZ will have live zero downtime migration and suspend/resume some 
> >>time next month.
> >>
> >Please clarify. Currently a migration involves:
> >- stopping or suspending the instance
> >- backing up the instance and all of its data
> >- creating an environment for the instance on a new machine
> >- transporting the data to a new machine
> >- installing the instance and all data
> >- starting the instance
> 
> >If you could just briefly cover how you do each of these steps with zero
> >downtime...
> 
> it does exactly what you wrote with some minor steps such as networking 
> stop on source and start on destination etc.
> 
> So I would detailed it like this:
> - freeze VPS
> - freeze networking
> - copy VPS data to destination
> - dump VPS

IIRC, Xen does some kind of repetitive sync of
memory pages to allow the 'original' to continue
running for as long as possible, so pages and
structures get resynced until it looks like the
migration would require only a few pages to be
synced for the final move, then it does the actual
move ...

> - copy dump to the destination
> - restore VPS
> - unfreeze VPS
> - kill original VPS on source
> 
> Moreover, in OpenVZ live migration allows to migrate 32bit VPSs between 
> i686 and x86-64 Linux machines.

I think that zero downtime is some kind of marketing
buzzword here, and has nothing to do with the actual
time the migration takes, which will probably be
around 20 seconds or so (for larger guests) ...

best,
Herbert

> Thanks,
> Kirill
