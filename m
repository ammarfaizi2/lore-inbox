Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263441AbRFNRxr>; Thu, 14 Jun 2001 13:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263443AbRFNRxi>; Thu, 14 Jun 2001 13:53:38 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:26513 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S263441AbRFNRxX>;
	Thu, 14 Jun 2001 13:53:23 -0400
Message-ID: <3B28F9EC.D08D3D52@mandrakesoft.com>
Date: Thu, 14 Jun 2001 13:52:44 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>, Ingo Molnar <mingo@elte.hu>,
        linux-kernel@vger.kernel.org, Richard Henderson <rth@redhat.com>
Subject: Re: unregistered changes to the user<->kernel API
In-Reply-To: <20010614191219.A30567@athlon.random> <3B28F376.1F528D5A@mandrakesoft.com> <20010614194419.A715@athlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> On Thu, Jun 14, 2001 at 01:25:10PM -0400, Jeff Garzik wrote:
> > They don't hurt but it's also a bad precedent - you don't want to add a
> > ton of CONFIG_xxx to the Linus tree for stuff outside the Linus tree.
> > disagree with this patch.
> 
> If tux will ever be merged into mainline eventually I don't think
> there's a value in defer such bit. Of course if tux will never get
> merged then I totally agree with you.

You're missing the point -- it's a bad precedent.

How many kernel forks and patches exist out there on the net?

Many of these patches will get merged eventually.  But it is a bad idea
to include bits of such into the Linus tree, when they are not used in
the Linus tree.

-Exceptions- to this policy should be carefully considered...  reserving
syscall and sysctl numbers certainly makes sense.  Bloating kernel_stat
with tons of unused numbers, some specific to web servers AFAICS, does
not make sense.

Tangent:  Why is this webserver-specific crap in kernel_stat anyway?  It
looks like there should be a separate per-cpu structure for webserver
statistics.

> +       unsigned int parse_static_incomplete;
> +       unsigned int parse_static_redirect;
> +       unsigned int parse_static_cachemiss;
> +       unsigned int parse_static_nooutput;
> +       unsigned int parse_static_normal;
> +       unsigned int parse_dynamic_incomplete;
> +       unsigned int parse_dynamic_redirect;
> +       unsigned int parse_dynamic_cachemiss;
> +       unsigned int parse_dynamic_nooutput;
> +       unsigned int parse_dynamic_normal;
> +       unsigned int complete_parsing;
> +
> +       unsigned int nr_keepalive_reqs;
> +       unsigned int nr_nonkeepalive_reqs;
> +#define KEEPALIVE_HIST_SIZE 100
> +       unsigned int keepalive_hist[KEEPALIVE_HIST_SIZE];

Even when merging Tux, I would hope Linus would not apply this
particular change.

	Jeff


-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
