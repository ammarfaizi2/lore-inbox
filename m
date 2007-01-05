Return-Path: <linux-kernel-owner+w=401wt.eu-S1422636AbXAERUH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422636AbXAERUH (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 12:20:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422630AbXAERUH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 12:20:07 -0500
Received: from nwkea-mail-4.sun.com ([192.18.42.26]:47978 "EHLO
	nwkea-mail-4.sun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422632AbXAERUD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 12:20:03 -0500
X-Greylist: delayed 2371 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Jan 2007 12:20:03 EST
Date: Fri, 5 Jan 2007 10:40:09 -0600
From: Nicolas Williams <Nicolas.Williams@sun.com>
To: Benny Halevy <bhalevy@panasas.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Jan Harkes <jaharkes@cs.cmu.edu>, Miklos Szeredi <miklos@szeredi.hu>,
       nfsv4@ietf.org, linux-kernel@vger.kernel.org,
       Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
       linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@poochiereds.net>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: [nfsv4] RE: Finding hardlinks
Message-ID: <20070105164008.GA1010@binky.Central.Sun.COM>
Mail-Followup-To: Benny Halevy <bhalevy@panasas.com>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Jan Harkes <jaharkes@cs.cmu.edu>,
	Miklos Szeredi <miklos@szeredi.hu>, nfsv4@ietf.org,
	linux-kernel@vger.kernel.org,
	Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
	linux-fsdevel@vger.kernel.org,
	Jeff Layton <jlayton@poochiereds.net>,
	Arjan van de Ven <arjan@infradead.org>
References: <4593C524.8070209@poochiereds.net> <4593DEF8.5020609@panasas.com> <Pine.LNX.4.64.0612281916230.2960@artax.karlin.mff.cuni.cz> <E472128B1EB43941B4E7FB268020C89B149CEC@riverside.int.panasas.com> <1167388129.6106.45.camel@lade.trondhjem.org> <E472128B1EB43941B4E7FB268020C89B149CF1@riverside.int.panasas.com> <1167780097.6090.104.camel@lade.trondhjem.org> <459BA30A.4020809@panasas.com> <1167899796.6046.11.camel@lade.trondhjem.org> <459CD11E.3000200@panasas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <459CD11E.3000200@panasas.com>
User-Agent: Mutt/1.5.7i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 04, 2007 at 12:04:14PM +0200, Benny Halevy wrote:
> I agree that the way the client implements its cache is out of the protocol
> scope. But how do you interpret "correct behavior" in section 4.2.1?
>  "Clients MUST use filehandle comparisons only to improve performance, not for correct behavior. All clients need to be prepared for situations in which it cannot be determined whether two filehandles denote the same object and in such cases, avoid making invalid assumptions which might cause incorrect behavior."
> Don't you consider data corruption due to cache inconsistency an incorrect behavior?

If a file with multiple hardlinks appears to have multiple distinct
filehandles then a client like Trond's will treat it as multiple
distinct files (with the same hardlink count, and you won't be able to
find the other links to them -- oh well).  Can this cause data
corruption?  Yes, but only if there are applications that rely on the
different file names referencing the same file, and backup apps on the
client won't get the hardlinks right either.

What I don't understand is why getting the fileid is so hard -- always
GETATTR when you GETFH and you'll be fine.  I'm guessing that's not as
difficult as it is to maintain a hash table of fileids.

Nico
-- 
