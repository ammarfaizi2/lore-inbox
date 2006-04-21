Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932422AbWDUQVs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932422AbWDUQVs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 12:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932421AbWDUQVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 12:21:48 -0400
Received: from mummy.ncsc.mil ([144.51.88.129]:38094 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S932416AbWDUQVr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 12:21:47 -0400
Subject: Re: Time to remove LSM (was Re: [RESEND][RFC][PATCH 2/7]
	implementation of LSM hooks)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Greg KH <greg@kroah.com>, Arjan van de Ven <arjan@infradead.org>,
       James Morris <jmorris@namei.org>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, T?r?k Edwin <edwin@gurde.com>,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       Chris Wright <chrisw@sous-sol.org>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0604211528140.22097@yvahk01.tjqt.qr>
References: <200604142301.10188.edwin@gurde.com>
	 <1145290013.8542.141.camel@moss-spartans.epoch.ncsc.mil>
	 <20060417162345.GA9609@infradead.org>
	 <1145293404.8542.190.camel@moss-spartans.epoch.ncsc.mil>
	 <20060417173319.GA11506@infradead.org>
	 <Pine.LNX.4.64.0604171454070.17563@d.namei>
	 <20060417195146.GA8875@kroah.com>
	 <Pine.LNX.4.61.0604191010300.12755@yvahk01.tjqt.qr>
	 <1145462454.3085.62.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.61.0604192102001.7177@yvahk01.tjqt.qr>
	 <20060419201154.GB20545@kroah.com>
	 <Pine.LNX.4.61.0604211528140.22097@yvahk01.tjqt.qr>
Content-Type: text/plain
Organization: National Security Agency
Date: Fri, 21 Apr 2006 12:25:55 -0400
Message-Id: <1145636755.21749.165.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-21 at 15:30 +0200, Jan Engelhardt wrote:
> >> >> Well then, have a look at http://alphagate.hopto.org/multiadm/
> >> >
> >> >hmm on first sight that seems to be basically an extension to the
> >> >existing capability() code... rather than a 'real' LSM module. Am I
> >> >missing something here?
> >> 
> >> (So what's the definition for a "real" LSM module?)
> >
> >No idea, try submitting the patch :)
> >
> Because it's too big, you only get URLs:
> 
> [01/02] http://alphagate.hopto.org/multiadm/mtadm_hooks-2.6.17-rc2.diff  137KB
> [02/02] http://alphagate.hopto.org/multiadm/mtadm_module-2.6.17-rc2.diff  27KB

For proper submission, you should split it up, e.g. one patch per new
hook you need and then your module.

The bulk of the first patch appears to be capable -> capable_x changes.
What is the purpose of that?

The set_task_ioprio hook looks legitimate; should be submitted
separately, modulo CodingStyle issues.

What's the rationale for the int->gid_t and int->uid_t changes in sys?

Some of the hooks used to exist in LSM patches but didn't have a real
user for merging at the time.  But it isn't clear whether you actually
need separate hooks for each of them or if they are being mapped to the
same check in many cases - can it be abstracted to a common hook?

Seems like you are duplicating a lot of the base DAC logic in the
process; would be nice to encapsulate that in the core kernel, and then
just use a common helper in both cases?

> Don't mention CodingStyle, I know. This is just a post to respond to the
> topic on why noone submitted it earlier.
> I already see it coming...

-- 
Stephen Smalley
National Security Agency

