Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293447AbSCABhZ>; Thu, 28 Feb 2002 20:37:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293486AbSCABfY>; Thu, 28 Feb 2002 20:35:24 -0500
Received: from THUNK.ORG ([216.175.175.175]:50411 "EHLO thunk.org")
	by vger.kernel.org with ESMTP id <S310301AbSCAB3z>;
	Thu, 28 Feb 2002 20:29:55 -0500
Date: Thu, 28 Feb 2002 20:29:51 -0500
From: Theodore Tso <tytso@mit.edu>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: doug@lathi.net, linux-kernel@vger.kernel.org
Subject: Re: cs46xx on ThinkPad A22m and poor quality output
Message-ID: <20020228202951.B14374@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Dave Hansen <haveblue@us.ibm.com>, doug@lathi.net,
	linux-kernel@vger.kernel.org
In-Reply-To: <87vgcjvs1p.fsf@localhost.localdomain> <87pu2r1x7s.fsf@localhost.localdomain> <3C7D22B8.9070304@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <3C7D22B8.9070304@us.ibm.com>; from haveblue@us.ibm.com on Wed, Feb 27, 2002 at 10:17:28AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2002 at 10:17:28AM -0800, Dave Hansen wrote:
> You aren't crazy.  Lots of us with T2[012]'s have this problem.  It does 
> indeed appear to be a problem with the OSS version of the driver. 
> Someone had a theory that the APM code stays in an interrupt too long 
> and causes the card to get into an unanticipated state, causing the poor 
> sound quality.

The way I deal with this is to ahve the following in my apm events script:

case "$1" in
resume)
	esdctl off
	rmmod cs4281 ; 	insmod cs4281
	rmmod cs46xx ; 	insmod cs46xx
	/etc/init.d/aumix start
	esdctl on
esac

The reason for the cs4281 and cs46xx is so that the script will work
both on my X20 as well as my T21.

It's a gross kludge, but it works....

							- Ted
