Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267189AbTBFOFR>; Thu, 6 Feb 2003 09:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267237AbTBFOFR>; Thu, 6 Feb 2003 09:05:17 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:29961 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267189AbTBFOFQ>; Thu, 6 Feb 2003 09:05:16 -0500
Date: Thu, 6 Feb 2003 14:14:52 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Christoph Hellwig <hch@infradead.org>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Update of the input subsystem - 37 csets
Message-ID: <20030206141452.A10148@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Vojtech Pavlik <vojtech@suse.cz>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
References: <20030206141352.A10182@ucw.cz> <20030206134939.A9732@infradead.org> <20030206151025.A10594@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030206151025.A10594@ucw.cz>; from vojtech@suse.cz on Thu, Feb 06, 2003 at 03:10:25PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2003 at 03:10:25PM +0100, Vojtech Pavlik wrote:
> On Thu, Feb 06, 2003 at 01:49:39PM +0000, Christoph Hellwig wrote:
> 
> >   * Some laptops take the 789uiojklm,. keys as number pad when NumLock is on.
> >   * This seems a good reason to start with NumLock off.
> >   */
> > +#ifndef CONFIG_X86_PC9800
> >  #define KBD_DEFLEDS 0
> > +#else
> > +#define KBD_DEFLEDS (1 << VC_NUMLOCK)
> > +#endif
> >  #endif
> > 
> > This ifdef is the wrong way around.
> 
> The ifdef is the right way around. KBD_DEFLEDS used to be 0. Now
> KBD_DEFLEDS is also 0, except when CONFIG_X86_PC9800 is defined. Note
> it's an if*n*def there.

yes, that's what I meant :)  Don't use ifndef nless nessecary.
Sorry for the unclear wording.

> Hmm. I know this isn't the prefered way of doing it, but so far it's the
> most convenient one - serio.h still changes now and then (adding new
> #defines, etc), and the only one program using it is inputattach.c. To
> me it seems quite sane to have inputattach.c include this kernel header.
> If you know of any other reasonably maintainable way to do it ...

split serio.h into serio_ids.h (the ids used by inputattach.c) and serio.h
(the actual kernel header).  Copy over serio_ids.h to the inputattach source
tarball and resync it whenever nessecary.

