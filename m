Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318006AbSGZSwi>; Fri, 26 Jul 2002 14:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318023AbSGZSwh>; Fri, 26 Jul 2002 14:52:37 -0400
Received: from pc-62-30-72-138-ed.blueyonder.co.uk ([62.30.72.138]:55681 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S318006AbSGZSwh>; Fri, 26 Jul 2002 14:52:37 -0400
Date: Fri, 26 Jul 2002 19:55:28 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Steven Cole <elenstev@mesatop.com>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Andrew Morton <akpm@zip.com.au>,
       linux-kernel@vger.kernel.org, Steven Cole <scole@lanl.gov>
Subject: Re: 2.5.28, dbench results with ext3 significantly lower than with ext2.
Message-ID: <20020726195528.B2299@redhat.com>
References: <1027701923.3148.10.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1027701923.3148.10.camel@spc9.esa.lanl.gov>; from elenstev@mesatop.com on Fri, Jul 26, 2002 at 10:45:23AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jul 26, 2002 at 10:45:23AM -0600, Steven Cole wrote:
> I found that dbench gives significantly lower numbers when
> the partition on which it is run is mounted as ext3.

Yes, especially with ext3 using its default 5-second commit intervals
and ext2 using 30 second timeouts for its own bdflush.

dbench does a lot of IO to temporary files, writing large amounts of
data and then shortly deleting it.  If it can run fast enough to
delete the data before it hits disk, it goes _much_ faster, so you end
up measuring cache speed and not disk speed.  ext3 is particulary hurt
by that given its shorted default commit timeouts.

Cheers,
 Stephen
