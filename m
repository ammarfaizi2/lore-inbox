Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbUCDNg1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 08:36:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261895AbUCDNg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 08:36:27 -0500
Received: from 104.engsoc.carleton.ca ([134.117.69.104]:2195 "EHLO
	quickman.certainkey.com") by vger.kernel.org with ESMTP
	id S261891AbUCDNgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 08:36:25 -0500
Date: Thu, 4 Mar 2004 08:24:30 -0500
From: Jean-Luc Cooke <jlcooke@certainkey.com>
To: dean gaudet <dean-list-linux-kernel@arctic.org>
Cc: James Morris <jmorris@redhat.com>, Christophe Saout <christophe@saout.de>,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: dm-crypt, new IV and standards
Message-ID: <20040304132430.GA8213@certainkey.com>
References: <20040220172237.GA9918@certainkey.com> <Xine.LNX.4.44.0402201624030.7335-100000@thoron.boston.redhat.com> <20040221164821.GA14723@certainkey.com> <Pine.LNX.4.58.0403022352080.12846@twinlark.arctic.org> <20040303150647.GC1586@certainkey.com> <Pine.LNX.4.58.0403031735210.26196@twinlark.arctic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0403031735210.26196@twinlark.arctic.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2004 at 05:48:46PM -0800, dean gaudet wrote:
> On Wed, 3 Mar 2004, Jean-Luc Cooke wrote:
> 
> > The difference between "$1,000,000" and "$8,000,000" is 1 bit.  If an
> > attacker knew enough about the layout of the filesystem (modify times on blocks,
> > etc) they could flip a single bit and change your $1Mil purchase order
> > approved by your boss to a $8Mil order.
> 
> ah ok i was completely ignoring the desire to prevent data tampering.
> 
> you have to admit it's still a bit more effort than flipping 1 bit like
> you suggest since you need to tweak the encrypted data enough so that the
> decrypted data has only 1 bit flipped.  (especially if you use CBC like
> you mention.)
> 
> something else which i've been wondering about -- would there be any extra
> protection provided by permuting block addresses so that the location of
> wellknown blocks such as the superblock and inode maps aren't so
> immediately obvious?  given the lack of known plaintext attacks on AES i'm
> thinking there's no point to permuting, but i'm not a cryptographer, i
> only know enough to be dangerous.  (you'd want to choose a permutation
> which makes some effort to group blocks into large enough chunks so that
> *some* seek locality can be maintained.)

I think there is not value in "security though obscurity" when you're
developing an open source application.  :)

Like you said, CBC is not trivial to temper with - though it is do able.  CTR
is trivial on the other hand.  Which is why NIST and every cryptographer will
recommend using a MAC with CTR.  (Why still have CTR?  Unlike CBC, you can
compute the N+1-th block without needing to know the output from the N-th
block, so there is the possibility for very high parallelizum).

JLC

-- 
http://www.certainkey.com
Suite 4560 CTTC
1125 Colonel By Dr.
Ottawa ON, K1S 5B6
