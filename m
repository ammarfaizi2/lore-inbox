Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264534AbTFABBk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 21:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264535AbTFABBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 21:01:40 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:41945 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S264534AbTFABBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 21:01:39 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Scott A Crosby <scrosby@cs.rice.edu>, linux-kernel@vger.kernel.org
Subject: Re: Algoritmic Complexity Attacks and 2.4.20 the dcache code
Date: Sun, 1 Jun 2003 03:15:07 +0200
User-Agent: KMail/1.5.1
References: <oydbrxlbi2o.fsf@bert.cs.rice.edu>
In-Reply-To: <oydbrxlbi2o.fsf@bert.cs.rice.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306010315.07264.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 29 May 2003 22:42, Scott A Crosby wrote:
> The solution for these attacks on hash tables is to make the hash
> function unpredictable via a technique known as universal
> hashing. Universal hashing is a keyed hash function where, based on
> the key, one of a large set hash functions is chosen. When
> benchmarking, we observe that for short or medium length inputs, it is
> comparable in performance to simple predictable hash functions such as
> the ones in Python or Perl. Our paper has graphs and charts of our
> benchmarked performance.

You should have said "a solution", not "the solution", above.  For the Ext2/3 
HTree index, we found a rather nice solution that varies the hash dispersion 
pattern on a per-volume basis, in a way that's difficult for a DOSer to 
reconstruct (please feel free to analyze this approach and find a hole, if 
there is one).

This is much simpler than what you propose.  As we are talking core kernel 
here, adding an extra spiderweb of complexity in the form of multiple hash 
algorithms really isn't appealing, if it can be avoided.  Not to mention the 
overhead of indexing into the correct hash algorithm on each lookup.

> I highly advise using a universal hashing library, either our own or
> someone elses. As is historically seen, it is very easy to make silly
> mistakes when attempting to implement your own 'secure' algorithm.

Translation: adding bloat is often the easy way out for the lazy.  Anyway, 
thanks for your analysis, but I disagree with your recommendation.

Regards,

Daniel
