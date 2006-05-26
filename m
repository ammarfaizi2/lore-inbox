Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030210AbWEZAMs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030210AbWEZAMs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 20:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030212AbWEZAMs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 20:12:48 -0400
Received: from gw.openss7.com ([142.179.199.224]:61325 "EHLO gw.openss7.com")
	by vger.kernel.org with ESMTP id S1030210AbWEZAMr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 20:12:47 -0400
Date: Thu, 25 May 2006 18:12:45 -0600
From: "Brian F. G. Bidulock" <bidulock@openss7.org>
To: 4Front Technologies <dev@opensound.com>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel@vger.kernel.org
Subject: Re: How to check if kernel sources are installed on a system?
Message-ID: <20060525181245.A3859@openss7.org>
Reply-To: bidulock@openss7.org
Mail-Followup-To: 4Front Technologies <dev@opensound.com>,
	Jesper Juhl <jesper.juhl@gmail.com>,
	Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org
References: <e55715+usls@eGroups.com> <1148596163.31038.30.camel@mindpipe> <4476321A.8090508@opensound.com> <9a8748490605251606q256d7e67s8b8220eae05a5422@mail.gmail.com> <44763AE0.6050907@opensound.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <44763AE0.6050907@opensound.com>; from dev@opensound.com on Thu, May 25, 2006 at 04:16:48PM -0700
Organization: http://www.openss7.org/
Dsn-Notification-To: <bidulock@openss7.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dev,

It appears that you might be fairly new to the game of maintaining open
source kernel modules outside of mainline.  Having worked for a number
of years providing STREAMS distributions outside of mainline and that
need to be compatible with a wide range of distributions, I spent some
amount of time developing a GNU autoconf/automake based approach that
works with most major distributions.

Even though Linux Fast-STREAMS has proven that STREAMS-based pipes can
outperform Linux SVR 3.2 based pipes under FC4 (see
http://www.openss7.org/streams_perf.html ), and current UDP tests show
that STREAMS easily rivals a sockets-based approach, strong dogmatic
opinions against STREAMS keeps it from being accepted in the mainline
(see http://www.tux.org/#s9-9 ).

You seem to be in a similar circumstance.  What the autoconf macros
developed as part of the OpenSS7 Project do are as follows:

- identifies the distribution
- identifies the running or target kernel
- locates configured sources appropriate for build
- identifies other LSB related issues such as init scripts
- builds source and binary RPM packages and source and binary Debian
  packages

Several common issues with building outside the kernel tree on
production distributions addressed are as follows:

- provides access to non-exported symbols (note that OpenSS7 is released
  under GPLv2 so there are no issues for OpenSS7 packages).

- provides methods for performing all autoconf tests against kernel
  headers or source.  Often for production distributions testing kernel
  version is not sufficient because kernels have been hacked by the
  distributor: this provides a means to test the actual kernel rather
  than basing tests on kernel versions.

- extracts compilation flags from kernel Makefiles and works with both
  2.4 and 2.6 kernel series, as well as distribution-hacked makefiles.

- by identifying the distribution, locates kernel sources and
  configuration files in a distribution dependent fashion.

- suitable for use with RPM spec files and Debian build scripts.

If you would like to take a look, download the streams-0.7a.4.tar.bz2
from http://www.openss7.org/download.html and take a look at the
autoconf macros in the m4 subdirectory, the automake makefile fragments
in the am subdirectory, scripts in the scripts subdirectory,
acinclude.m4, the streams.spec.in RPM spec file, and the debian
subdirectory.

If there is sufficient interest, I would entertain separately
maintaining the autoconf/automake fragments.

--brian


On Thu, 25 May 2006, 4Front Technologies wrote:

> Jesper Juhl wrote:
> > On 26/05/06, 4Front Technologies <dev@opensound.com> wrote:
> >>
> >> Anything to get out-of-kernel modules compiling without jumping 
> >> through 1000
> >> hoops is good.
> >>
> > 
> > hmm, I'd say that anything that encourages people to merge their code
> > with mainline instead of maintaining out-of-tree modules is good.
> > 
> 
> 
> Honestly, if I put Open Sound drivers under GPL would Linus really merge my code 
> back into the kernel?. Be honest!
> 
> 
> If you aren't going to maintain OSS, then give me a way to support my product!.
> 
> 
> 
> 
> 
> best regards
> 
> Dev Mazumdar
> -----------------------------------------------------------
> 4Front Technologies
> 4035 Lafayette Place, Unit F, Culver City, CA 90232, USA.
> Tel: (310) 202 8530		URL: www.opensound.com
> Fax: (310) 202 0496 		Email: info@opensound.com
> -----------------------------------------------------------
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Brian F. G. Bidulock    ¦ The reasonable man adapts himself to the ¦
bidulock@openss7.org    ¦ world; the unreasonable one persists in  ¦
http://www.openss7.org/ ¦ trying  to adapt the  world  to himself. ¦
                        ¦ Therefore  all  progress  depends on the ¦
                        ¦ unreasonable man. -- George Bernard Shaw ¦
