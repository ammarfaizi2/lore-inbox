Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269015AbUI2Ub6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269015AbUI2Ub6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 16:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269007AbUI2U3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 16:29:52 -0400
Received: from 104.engsoc.carleton.ca ([134.117.69.104]:49360 "EHLO
	certainkey.com") by vger.kernel.org with ESMTP id S269018AbUI2U3T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 16:29:19 -0400
Date: Wed, 29 Sep 2004 16:27:07 -0400
From: Jean-Luc Cooke <jlcooke@certainkey.com>
To: "Theodore Ts'o" <tytso@mit.edu>, linux@horizon.com,
       linux-kernel@vger.kernel.org, cryptoapi@lists.logix.cz
Subject: Re: [PROPOSAL/PATCH 2] Fortuna PRNG in /dev/random
Message-ID: <20040929202707.GO16057@certainkey.com>
References: <20040924005938.19732.qmail@science.horizon.com> <20040929171027.GJ16057@certainkey.com> <20040929193117.GB6862@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040929193117.GB6862@thunk.org>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Why would we want to miss that when so much effort was made to meet the
requirements of the traditional /dev/random?  So...

Here's patch v2.1.2 that waits at least 0.1 sec before reseeding for
non-blocking reads to alleviate Ted's concern wrt waiting for reseeds.



When reading nbytes from /dev/{u}random, Legacy /dev/random would:
 - Mix nbytes of data from primary pool into secondary pool
 - Then generate nbytes from secondary pool

When reading nbytes from /dev/{u}random, Fortuna-patch /dev/random would:
 - Mix ??? of data from input pools into the AES key for output generation
 - Then generate nbytes from AES256-CTR

Perhaps I miss the subtlety of the difference in terms of security.  If
nbytes >= size of both pools - wouldn't Legacy also be vulnerable to the
same attack?

JLC

On Wed, Sep 29, 2004 at 03:31:17PM -0400, Theodore Ts'o wrote:
> While addition of the entropy estimator helps protect the Fortuna
> Random number generator against a state extension attack, /dev/urandom
> is using the same entropy extraction routine as /dev/random, and so
> Fortuna is still vulernable to state extension attacks.  This is
> because a key aspect of the Fortuna design has been ignored in JLC's
> implementation.  
