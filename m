Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286172AbSAEAep>; Fri, 4 Jan 2002 19:34:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286161AbSAEAef>; Fri, 4 Jan 2002 19:34:35 -0500
Received: from dsl-213-023-043-154.arcor-ip.net ([213.23.43.154]:37896 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S286147AbSAEAeS>;
	Fri, 4 Jan 2002 19:34:18 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: hashed waitqueues
Date: Sat, 5 Jan 2002 01:37:40 +0100
X-Mailer: KMail [version 1.3.2]
Cc: riel@surriel.com, mjc@kernel.org, bcrl@redhat.com
In-Reply-To: <20020104094049.A10326@holomorphy.com>
In-Reply-To: <20020104094049.A10326@holomorphy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16MeqE-0001Ea-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 4, 2002 06:40 pm, William Lee Irwin III wrote:

> +       unsigned long hash = (unsigned long)page;

Just to be anal here, 'long' doesn't add anything useful to this 
declaration.  In fact, u32 is what you want since you've chosen your 
multiplier with a 32 bit register in mind - on 64bit arch I think you'll get 
distinctly non-random results as it stands.

> +	hash *= GOLDEN_RATIO_PRIME;
> +	hash >>= BITS_PER_LONG - zone->wait_table_bits;
> +	hash &= zone->wait_table_size - 1;

Nice hash!  For arches with expensive multiplies you might want to look 
for a near-golden ratio multiplier that has a simple contruction in terms of 
1's & 0's so it can be computed with 2 or 3 shift-adds, dumping the 
efficiency problem on the compiler.  You don't have to restrict your search 
to the neighbourhood of 32 bits, you can go a few bits less than that and 
substract from a smaller value than BITS_PER_LONG (actually, you should just 
write '32' there, since that's what you really have in mind).

--
Daniel


