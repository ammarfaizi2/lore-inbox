Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264869AbTFYSBY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 14:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264870AbTFYSBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 14:01:24 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:4104 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264869AbTFYSBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 14:01:23 -0400
Date: Wed, 25 Jun 2003 19:15:32 +0100
From: Christoph Hellwig <hch@infradead.org>
To: mocm@mocm.de
Cc: Michael Hunold <hunold@convergence.de>, Sam Ravnborg <sam@ravnborg.org>,
       linux-kernel@vger.kernel.org
Subject: Re: DVB Include files
Message-ID: <20030625191532.A1083@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>, mocm@mocm.de,
	Michael Hunold <hunold@convergence.de>,
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
References: <3EF9CB25.4050105@convergence.de> <16121.53934.527440.109966@sheridan.metzler> <20030625175513.A28776@infradead.org> <16121.55366.94360.338786@sheridan.metzler> <20030625181606.A29104@infradead.org> <16121.55873.675690.542574@sheridan.metzler> <20030625182409.A29252@infradead.org> <16121.56382.444838.485646@sheridan.metzler> <20030625185036.C29537@infradead.org> <16121.58735.59911.813354@sheridan.metzler>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <16121.58735.59911.813354@sheridan.metzler>; from mocm@metzlerbros.de on Wed, Jun 25, 2003 at 08:09:51PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 25, 2003 at 08:09:51PM +0200, Marcus Metzler wrote:
>  > If the structures change incompatibly you're fucked anyway.  Better
> 
> Not necessarily, e.g. changing
> 
> #define AUDIO_SET_ATTRIBUTES       _IOW('o', 17, audio_attributes_t)
> #define AUDIO_SET_KARAOKE          _IOW('o', 18, audio_karaoke_t)
> 
> to 
> 
> #define AUDIO_SET_ATTRIBUTES       _IOW('o', 47, audio_attributes_t)
> #define AUDIO_SET_KARAOKE          _IOW('o', 48, audio_karaoke_t)
> 
> or

In that case yes, you are screwed.  Your ABI just changed incompatibly.

> Anyway, even in user/include it should be under linux/dvb because
> that's just what it is Linux DVB. So the app has to include
> <linux/dvb/xxx.h>. 

No!  <linux/*.h> is the namesapce for kernelheaders.  Currently they're
still in the the user includes, too (due to legacy reasons).  The
DVD API must move to a directory outside <linux/dvb>.

If you userland packages add headers to /usr/include/linux/ they
are totally bogus.

> I don't care what distributions do. When I get a new kernel (no
> packages), I use the includes from that kernel and compile my apps
> with that.

And that's wrong.  You must always compile against the kernel headers
that your libc was compiled against.

