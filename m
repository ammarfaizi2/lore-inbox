Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132545AbRDEBfo>; Wed, 4 Apr 2001 21:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132546AbRDEBfZ>; Wed, 4 Apr 2001 21:35:25 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:40349 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S132545AbRDEBfW>;
	Wed, 4 Apr 2001 21:35:22 -0400
Date: Wed, 4 Apr 2001 21:34:40 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Dawson Engler <engler@csl.Stanford.EDU>
cc: linux-kernel@vger.kernel.org
Subject: Re: [QUESTION] MOD_INC/MOD_DEC: useful to check for correct usage?
In-Reply-To: <200104050125.SAA21252@csl.Stanford.EDU>
Message-ID: <Pine.GSO.4.21.0104042133060.22608-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 4 Apr 2001, Dawson Engler wrote:

> Hi,
> 
> in the old days you couldn't call a sleeping function in a module
> before doing a MOD_INC or after doing a MOD_DEC.  Then some safety nets
> were added that made these obsolete (in some number of places).  I was
> told that people had decided to potentially get rid of all safety
> nets.  Is this true?  Is it worthwhile to have a checker for these two
> rules?

It's worth removing the MOD_{INC,DEC}_USE_COUNT. Which had been done
in quite a few places. Let the caller handle the refcount on callee -
_that_ is definitely safe.

