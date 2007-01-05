Return-Path: <linux-kernel-owner+w=401wt.eu-S1161016AbXAEI3O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161016AbXAEI3O (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 03:29:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161010AbXAEI3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 03:29:14 -0500
Received: from gw-e.panasas.com ([65.194.124.178]:44782 "EHLO
	cassoulet.panasas.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030369AbXAEI3N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 03:29:13 -0500
Message-ID: <459E0C11.4020203@panasas.com>
Date: Fri, 05 Jan 2007 10:28:01 +0200
From: Benny Halevy <bhalevy@panasas.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
       Jan Harkes <jaharkes@cs.cmu.edu>, Miklos Szeredi <miklos@szeredi.hu>,
       linux-kernel@vger.kernel.org, nfsv4@ietf.org,
       linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@poochiereds.net>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: [nfsv4] RE: Finding hardlinks
References: <Pine.LNX.4.64.0612200942060.28362@artax.karlin.mff.cuni.cz>	 <E1GwzsI-0004Y1-00@dorka.pomaz.szeredi.hu>	 <20061221185850.GA16807@delft.aura.cs.cmu.edu>	 <Pine.LNX.4.64.0612220038520.4677@artax.karlin.mff.cuni.cz>	 <1166869106.3281.587.camel@laptopd505.fenrus.org>	 <Pine.LNX.4.64.0612231458060.5182@artax.karlin.mff.cuni.cz>	 <4593890C.8030207@panasas.com> <4593C524.8070209@poochiereds.net>	 <4593DEF8.5020609@panasas.com>	 <Pine.LNX.4.64.0612281916230.2960@artax.karlin.mff.cuni.cz>	 <E472128B1EB43941B4E7FB268020C89B149CEC@riverside.int.panasas.com>	 <1167388129.6106.45.camel@lade.trondhjem.org>	 <E472128B1EB43941B4E7FB268020C89B149CF1@riverside.int.panasas.com>	 <1167780097.6090.104.camel@lade.trondhjem.org>	 <459BA30A.4020809@panasas.com>	 <1167899796.6046.11.camel@lade.trondhjem.org>	 <459CD11E.3000200@panasas.com> <1167907640.6046.44.camel@lade.trondhjem.org>
In-Reply-To: <1167907640.6046.44.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Jan 2007 08:27:40.0600 (UTC) FILETIME=[5D45B380:01C730A3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
> On Thu, 2007-01-04 at 12:04 +0200, Benny Halevy wrote:
>> I agree that the way the client implements its cache is out of the protocol
>> scope. But how do you interpret "correct behavior" in section 4.2.1?
>>  "Clients MUST use filehandle comparisons only to improve performance, not for correct behavior. All clients need to be prepared for situations in which it cannot be determined whether two filehandles denote the same object and in such cases, avoid making invalid assumptions which might cause incorrect behavior."
>> Don't you consider data corruption due to cache inconsistency an incorrect behavior?
> 
> Exactly where do you see us violating the close-to-open cache
> consistency guarantees?
> 

I haven't seen that. What I did see is cache inconsistency when opening
the same file with different file descriptors when the filehandle changes.
My testing shows that at least fsync and close fail with EIO when the filehandle
changed while there was dirty data in the cache and that's good. Still,
not sharing the cache while the file is opened (even on a different file
descriptors by the same process) seems impractical.

Benny
