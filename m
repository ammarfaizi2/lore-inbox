Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261988AbTCZT7g>; Wed, 26 Mar 2003 14:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262001AbTCZT7f>; Wed, 26 Mar 2003 14:59:35 -0500
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:12036 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S261988AbTCZT7c>; Wed, 26 Mar 2003 14:59:32 -0500
Date: Wed, 26 Mar 2003 21:10:31 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: BK-kernel-tools/shortlog update
Message-ID: <20030326201031.GA29746@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030326103036.064147C8DD@merlin.emma.line.org> <Pine.LNX.4.44.0303260917320.15530-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303260917320.15530-100000@home.transmeta.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Mar 2003, Linus Torvalds wrote:

> Btw, one feature I'd like to see in shortlog is the ability to use 
> regexps for email address matching, ie something like
> 
> 	'torvalds@.*transmeta.com' => 'Linus Torvalds'
> 	... 
> 	'alan@.*swansea.linux.org.uk' => 'Alan Cox'
> 	...
> 	'bcrl@redhat.com' => 'Benjamin LaHaise',
> 	'bcrl@.*' => '?? Benjamin LaHaise',
> 	..
> 
> I don't know whether you can force perl to do something like this, but if 
> somebody were to try...

I'd like to keep the hash for all those addresses that aren't wildcards
and that aren't regexps -- we have fast, that is O(1) to O(log n),
access to the hash (depending on Perl's implementation) and we have
worse than O(n) for regexp, where n is the count of address strings or
regexps.

Would you agree to a version that has a set of fixed addresses and a
separate list of regexps, tries the hash first and then a list of
regexps?  That sounds like a) easy addition, b) good performance to me
(before implementing it). If so, I could add some code for that feature.

-- 
Matthias Andree
