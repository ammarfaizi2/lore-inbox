Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261597AbVASKt3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261597AbVASKt3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 05:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261683AbVASKt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 05:49:28 -0500
Received: from ext-nj2gw-7.online-age.net ([64.14.56.43]:11678 "EHLO
	ext-nj2gw-7.online-age.net") by vger.kernel.org with ESMTP
	id S261597AbVASKtW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 05:49:22 -0500
Date: Wed, 19 Jan 2005 11:48:52 +0100
From: Kiniger <karl.kiniger@med.ge.com>
To: Lars Marowsky-Bree <lmb@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: raid 1 - automatic 'repair' possible?
Message-ID: <20050119104852.GB3087@wszip-kinigka.euro.med.ge.com>
References: <20050118211801.GA28400@wszip-kinigka.euro.med.ge.com> <20050118214605.GY22648@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20050118214605.GY22648@marowsky-bree.de>
User-Agent: Mutt/1.4.1i
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2005 at 10:46:05PM +0100, Lars Marowsky-Bree wrote:
> On 2005-01-18T22:18:01, "Kiniger, Karl (GE Healthcare)" <karl.kiniger@med.ge.com> wrote:
> 
> > idea for enhancement of software raid 1:
> > 
> > every time the raid determines that a sector cannot
> > be read it could at least try to overwrite the bad are
> > with good data from the other disk.
> 
> The idea is good and I'm sure we'll love to get a patch ;-)

Dont account on me as a coder  (absolutely no spare time
for the next couple of months)

some random thoughts:

nowadays hardware sector sizes are much bigger than 512 bytes and
the read error may affect some sectors +- the sector which actually
returned the error.

to keep the handling in userspace as much as possible: 

the real problem is the long resync time. therefore it would
be sufficient to have a concept of "defective areas" per partition
and drive (a few of them, perhaps four or so , would be enough) 
which will be excluded from reads/writes and some means to
re-synchronize these "defective areas" from the good counterparts
of the other disk. This would avoid having the whole partition being
marked as defective.

The repair could then be done in userspace given some kernel support.

There might be some corner cases though (e.g defective physical
sector spanning more than one partition) but I think they would be
rare.

Has anybody else had problems with the newer Maxtors
(200 GB and up) ? 

Karl

> 
> 
> Sincerely,
>     Lars Marowsky-Brée <lmb@suse.de>
> 
> -- 
> High Availability & Clustering
> SUSE Labs, Research and Development
> SUSE LINUX Products GmbH - A Novell Business

-- 
Karl Kiniger   mailto:karl.kiniger@med.ge.com
GE Medical Systems Kretztechnik GmbH & Co OHG
Tiefenbach 15       Tel: (++43) 7682-3800-710
A-4871 Zipf Austria Fax: (++43) 7682-3800-47
