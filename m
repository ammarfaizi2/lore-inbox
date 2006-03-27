Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750911AbWC0QKH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750911AbWC0QKH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 11:10:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750953AbWC0QKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 11:10:06 -0500
Received: from xproxy.gmail.com ([66.249.82.205]:10976 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750907AbWC0QKE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 11:10:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DG6TxCYgbHfArSQiFrkxkuIShvG797DScq93zbAybuWHKqB33TGG3NMTjcjnbJzjzXYGNERCUu+h3wE1Oi1nTFit92DZAjaJ9DMwT0TxdZuCix/AEZtEzuCoCxtFRxGqL3p/nKbxMyD9LM+sqBSP9dhtMpX7Io1MAXqveVaPhnU=
Message-ID: <afcef88a0603270810j58af1e7cs46f1558ba6553154@mail.gmail.com>
Date: Mon, 27 Mar 2006 10:10:03 -0600
From: "Michael Thompson" <michael.craig.thompson@gmail.com>
To: "Phillip Susi" <psusi@cfl.rr.com>
Subject: Re: eCryptfs Design Document
Cc: "Phillip Hellewell" <phillip@hellewell.homeip.net>,
       "Michael Halcrow" <lkml@halcrow.us>,
       "Michael Halcrow" <mhalcrow@us.ibm.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       viro@ftp.linux.org.uk, mcthomps@us.ibm.com, yoder1@us.ibm.com,
       toml@us.ibm.com, emilyr@us.ibm.com
In-Reply-To: <44275391.40501@cfl.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060324222517.GA13688@us.ibm.com> <442599D5.806@cfl.rr.com>
	 <20060325195015.GA8174@halcrow.us> <4426CB05.2070604@cfl.rr.com>
	 <20060326180458.GA10056@halcrow.us>
	 <20060327000522.GA11655@hellewell.homeip.net>
	 <44275391.40501@cfl.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/26/06, Phillip Susi <psusi@cfl.rr.com> wrote:
> Phillip Hellewell wrote:
> > Again I concur with Mike.  Iterative hashing is a very common technique,
> > and is very effective against this type of dictionary attack.  If you
> > hash 1000 times, then an attack that normally could check 1 million
> > passwords per second would now only be able to check 1000 passwords per
> > second.
> >
> > Without iterative hashing, as computers get faster, so would dictionary
> > attacks, and then people would have to keep using longer and longer
> > passwords to be as effective.  Iterative hashing "levels the playing
> > field" in a way.
> >
>
>
> Except that I believe you can write code to compute the nth hash in O(1)
> time rather than O(n) time, so that kind of defeats the purpose, though
> I'm no expert so I could be wrong.

I do not believe it is possible to compute the nth hash in O(1) time,
starting with no previously-computer hashes, since in order to
computer the nth hash, you need input which is the n-1th hash. This
takes the form: hash(n) = hash(hash(n-1)). In order to know the hash 
of n-1, you need to know the hash of n-2. This chains down to your
original hash. This argument holds if you retaining the standard
properties of hashes: that is it is non-trivial to find input which
yields a given hash.

--
Michael C. Thompson <mcthomps@us.ibm.com>
Software-Engineer, IBM LTC Security
