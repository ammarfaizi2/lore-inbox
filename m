Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261977AbVDKWlJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261977AbVDKWlJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 18:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261973AbVDKWlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 18:41:08 -0400
Received: from FW-30-241.go.retevision.es ([62.174.241.30]:499 "EHLO
	puil.ghetto") by vger.kernel.org with ESMTP id S261984AbVDKWka
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 18:40:30 -0400
Date: Tue, 12 Apr 2005 00:40:21 +0200
To: linux-kernel@vger.kernel.org
Subject: Call to atention about using hash functions as content indexers (SCM saga)
Message-ID: <20050411224021.GA25106@larroy.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.6+20040907i
From: piotr@larroy.com (Pedro Larroy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I had a quick look at the source of GIT tonight, I'd like to warn you
about the use of hash functions as content indexers.

As probably you are aware, hash functions such as SHA-1 are surjective not
bijective (1-to-1 map), so they have collisions. Here one can argue
about the low probability of such a collision, I won't get into
subjetive valorations of what probability of collision is tolerable for
me and what is not. 

I my humble opinion, choosing deliberately, as a design decision, a
method such as this one, that in some cases could corrupt data in a
silent and very hard to detect way, is not very good. One can also argue
that the probability of data getting corrupted in the disk, or whatever
could be higher than that of the collision, again this is not valid
comparison, since the fact that indexing by hash functions without
additional checking could make data corruption legal between the
reasonable working parameters of the program is very dangerous.

And by the way, I've read
http://www.usenix.org/events/hotos03/tech/full_papers/henson/henson_html/node15.html

and I don't agree with it. Asides from the "avalanche effect" the
properties of a good hash function is that distributes well the entropy
between the output bits, so probably, although the inputs are not
random, the pdf change in the outputs would be small, otherwise it would
be easier to find collision by differential or statistical methods.

Last, hash functions should be only used to check data integrity, and
that's the reason of the "avalanche effect", so even single bit errors
are propagated and it's effect is very noticeable at the output.

Regards.

-- 
Pedro Larroy Tovar | Linux & Network consultant |  pedro%larroy.com 
Make debian mirrors with debian-multimirror: http://pedro.larroy.com/deb_mm/
	* Las patentes de programación son nocivas para la innovación * 
				http://proinnova.hispalinux.es/
