Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964779AbWA0AUi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964779AbWA0AUi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 19:20:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964797AbWA0AUi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 19:20:38 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:27655 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S964779AbWA0AUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 19:20:37 -0500
Message-ID: <43D96758.4030808@shadowen.org>
Date: Fri, 27 Jan 2006 00:20:40 +0000
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Eric Dumazet <dada1@cosmosbay.com>
CC: Pekka Enberg <penberg@cs.helsinki.fi>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc1-mm3
References: <20060124232406.50abccd1.akpm@osdl.org>	 <43D785E1.4020708@shadowen.org>	 <84144f020601250644h6ca4e407q2e15aa53b50ef509@mail.gmail.com>	 <43D7AB49.2010709@shadowen.org> <1138212981.8595.6.camel@localhost>	 <43D7E83D.7040603@shadowen.org> <84144f020601252303x7e2a75c6rdfe789d3477d9317@mail.gmail.com>
In-Reply-To: <84144f020601252303x7e2a75c6rdfe789d3477d9317@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg wrote:
> Hi Andy,
> 
> Pekka Enberg wrote:
> 
>>>Does vanilla 2.6.16-rc1 work for you? The oops definitely makes me think
>>>it's slab related but the other patches don't seem likely suspects.
> 
> 
> On 1/25/06, Andy Whitcroft <apw@shadowen.org> wrote:
> 
>>None of the other patches you suggested seem to be it either :/.  Yes
>>2.6.16-rc1 was ok on the boxs in question.
> 
> 
> Then I dont see how it could be slab related. At this point, the only
> suggestion I have is bisecting akpm-style:

Yes.  I think I have this one.  It appears that the patch below is the
trigger for all our recent panic woe's.  The last of the testing should
complete in the next few hours and I will be able to confirm that
hypothesis; results so far are all good.

	reduce-size-of-percpudata-and-make-sure-per_cpuobject.patch

>From the nature of the patch I would guess its likely not the patch
itself that is at issue but some errant user of percpu space.  Perhaps a
more gentle approach is needed such that we get to the point at which
consoles are available and we can report the issue (at least as an
option).

Eric can give us some help confirming whether there is an issue with the
patch or finding the source of the errant access to it?

Cheers.

-apw
