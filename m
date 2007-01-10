Return-Path: <linux-kernel-owner+w=401wt.eu-S964800AbXAJNGM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964800AbXAJNGM (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 08:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932814AbXAJNGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 08:06:12 -0500
Received: from gw-e.panasas.com ([65.194.124.178]:56447 "EHLO
	cassoulet.panasas.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932817AbXAJNGK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 08:06:10 -0500
Message-ID: <45A4E457.7020403@panasas.com>
Date: Wed, 10 Jan 2007 15:04:23 +0200
From: Benny Halevy <bhalevy@panasas.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Benny Halevy <bhalevy@panasas.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Jan Harkes <jaharkes@cs.cmu.edu>, Miklos Szeredi <miklos@szeredi.hu>,
       nfsv4@ietf.org, linux-kernel@vger.kernel.org,
       Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
       linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@poochiereds.net>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: [nfsv4] RE: Finding hardlinks
References: <4593C524.8070209@poochiereds.net> <4593DEF8.5020609@panasas.com> <Pine.LNX.4.64.0612281916230.2960@artax.karlin.mff.cuni.cz> <E472128B1EB43941B4E7FB268020C89B149CEC@riverside.int.panasas.com> <1167388129.6106.45.camel@lade.trondhjem.org> <E472128B1EB43941B4E7FB268020C89B149CF1@riverside.int.panasas.com> <1167780097.6090.104.camel@lade.trondhjem.org> <459BA30A.4020809@panasas.com> <1167899796.6046.11.camel@lade.trondhjem.org> <459CD11E.3000200@panasas.com> <20070105164008.GA1010@binky.Central.Sun.COM>
In-Reply-To: <20070105164008.GA1010@binky.Central.Sun.COM>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Jan 2007 13:04:01.0984 (UTC) FILETIME=[CC9CDC00:01C734B7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicolas Williams wrote:
> On Thu, Jan 04, 2007 at 12:04:14PM +0200, Benny Halevy wrote:
>> I agree that the way the client implements its cache is out of the protocol
>> scope. But how do you interpret "correct behavior" in section 4.2.1?
>>  "Clients MUST use filehandle comparisons only to improve performance, not for correct behavior. All clients need to be prepared for situations in which it cannot be determined whether two filehandles denote the same object and in such cases, avoid making invalid assumptions which might cause incorrect behavior."
>> Don't you consider data corruption due to cache inconsistency an incorrect behavior?
> 
> If a file with multiple hardlinks appears to have multiple distinct
> filehandles then a client like Trond's will treat it as multiple
> distinct files (with the same hardlink count, and you won't be able to
> find the other links to them -- oh well).  Can this cause data
> corruption?  Yes, but only if there are applications that rely on the
> different file names referencing the same file, and backup apps on the
> client won't get the hardlinks right either.

The case I'm discussing is multiple filehandles for the same name,
not even for different hardlinks.  This causes spurious EIO errors
on the client when the filehandle changes and cache inconsistency
when opening the file multiple times in parallel.

> 
> What I don't understand is why getting the fileid is so hard -- always
> GETATTR when you GETFH and you'll be fine.  I'm guessing that's not as
> difficult as it is to maintain a hash table of fileids.

It's not difficult at all, just that the client can't rely on the fileids to be
unique in both space and time because of server non-compliance (e.g. netapp's
snapshots) and fileid reuse after delete.


