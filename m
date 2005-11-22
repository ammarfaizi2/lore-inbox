Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965043AbVKVSCP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965043AbVKVSCP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 13:02:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965046AbVKVSCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 13:02:15 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:5522 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S965043AbVKVSCD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 13:02:03 -0500
Date: Tue, 22 Nov 2005 19:01:47 +0100
From: Pavel Machek <pavel@suse.cz>
To: Gerd Knorr <kraxel@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
       Zachary Amsden <zach@vmware.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] SMP alternatives
Message-ID: <20051122180147.GA1748@elf.ucw.cz>
References: <Pine.LNX.4.64.0511111218110.4627@g5.osdl.org> <20051113074241.GA29796@redhat.com> <Pine.LNX.4.64.0511131118020.3263@g5.osdl.org> <Pine.LNX.4.64.0511131210570.3263@g5.osdl.org> <4378A7F3.9070704@suse.de> <Pine.LNX.4.64.0511141118000.3263@g5.osdl.org> <4379ECC1.20005@suse.de> <437A0649.7010702@suse.de> <437B5A83.8090808@suse.de> <438359D7.7090308@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <438359D7.7090308@suse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> For testing & benchmarking purposes I've put also in two (temporary) 
> sysrq's to switch between UP and SMP bits without booting/shutting down 
> the second CPU.  That one breaks non-i386 builds which are trivially 
> fixable by just dropping the drivers/char/sysrq.c changes ;)

> +/* Replace instructions with better alternatives for this CPU type.
> +
> +   This runs before SMP is initialized to avoid SMP problems with
> +   self modifying code. This implies that assymetric systems where
> +   APs have less capabilities than the boot processor are not handled. 
> +   Tough. Make sure you disable such features by hand. */ 
> +void apply_alternatives(struct alt_instr *start, struct alt_instr *end,
> +			__u8 *tstart, __u8 *tend)
> +{ 
> +        unsigned char **noptable = intel_nops;
> +	struct alt_instr *a; 

Some alignment problems here. (Maybe it is okay as a source).

> +struct smp_alt_module {
> +	/* what is this ??? */

:-))))))).

> +	struct module    *mod;
> +	char             *name;
> +
> +	/* our SMP alternatives table */
> +	struct alt_instr *astart;
> +	struct alt_instr *aend;
> +
> +	/* .text segment, needed to avoid patching init code ;) */
> +	__u8             *tstart;
> +	__u8             *tend;

You should be able to use u8 here.

> +		if (0 == strcmp(".text", secstrings + s->sh_name))
> +			text = s;
> +		if (0 == strcmp(".altinstructions", secstrings + s->sh_name))
> +			alt = s;
> +		if (0 == strcmp(".smp_altinstructions", secstrings + s->sh_name))
> +			smpalt = s;

Can we get if (!strcmp()) here?

								Pavel

-- 
Thanks, Sharp!
