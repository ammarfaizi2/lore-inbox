Return-Path: <linux-kernel-owner+w=401wt.eu-S1751214AbXAFHp4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbXAFHp4 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 02:45:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbXAFHp4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 02:45:56 -0500
Received: from gw-e.panasas.com ([65.194.124.178]:51970 "EHLO
	cassoulet.panasas.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751198AbXAFHpz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 02:45:55 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [nfsv4] RE: Finding hardlinks
Date: Sat, 6 Jan 2007 02:44:26 -0500
Message-ID: <E472128B1EB43941B4E7FB268020C89B149CF5@riverside.int.panasas.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [nfsv4] RE: Finding hardlinks
Thread-Index: Accw7es6EDUfc8kRTTWyvHNiLw3kSQAdN0eZ
References: <4593C524.8070209@poochiereds.net> <4593DEF8.5020609@panasas.com> <Pine.LNX.4.64.0612281916230.2960@artax.karlin.mff.cuni.cz> <E472128B1EB43941B4E7FB268020C89B149CEC@riverside.int.panasas.com> <1167388129.6106.45.camel@lade.trondhjem.org> <E472128B1EB43941B4E7FB268020C89B149CF1@riverside.int.panasas.com> <1167780097.6090.104.camel@lade.trondhjem.org> <459BA30A.4020809@panasas.com> <1167899796.6046.11.camel@lade.trondhjem.org> <459CD11E.3000200@panasas.com> <20070105164008.GA1010@binky.Central.Sun.COM>
From: "Halevy, Benny" <bhalevy@panasas.com>
To: "Nicolas Williams" <Nicolas.Williams@sun.com>
Cc: "Trond Myklebust" <trond.myklebust@fys.uio.no>,
       "Jan Harkes" <jaharkes@cs.cmu.edu>,
       "Miklos Szeredi" <miklos@szeredi.hu>, <nfsv4@ietf.org>,
       <linux-kernel@vger.kernel.org>,
       "Mikulas Patocka" <mikulas@artax.karlin.mff.cuni.cz>,
       <linux-fsdevel@vger.kernel.org>,
       "Jeff Layton" <jlayton@poochiereds.net>,
       "Arjan van de Ven" <arjan@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: linux-fsdevel-owner@vger.kernel.org on behalf of Nicolas Williams
> Sent: Fri 1/5/2007 18:40
> To: Halevy, Benny
> Cc: Trond Myklebust; Jan Harkes; Miklos Szeredi; nfsv4@ietf.org; linux-kernel@vger.kernel.org; Mikulas Patocka; linux-fsdevel@vger.kernel.org; Jeff Layton; Arjan van de Ven
> Subject: Re: [nfsv4] RE: Finding hardlinks
> 
> On Thu, Jan 04, 2007 at 12:04:14PM +0200, Benny Halevy wrote:
> > I agree that the way the client implements its cache is out of the protocol
> > scope. But how do you interpret "correct behavior" in section 4.2.1?
> >  "Clients MUST use filehandle comparisons only to improve performance, not for correct behavior. All clients > need to be prepared for situations in which it cannot be determined whether two filehandles denote the same > object and in such cases, avoid making invalid assumptions which might cause incorrect behavior."
> > Don't you consider data corruption due to cache inconsistency an incorrect behavior?
> 
> If a file with multiple hardlinks appears to have multiple distinct
> filehandles then a client like Trond's will treat it as multiple
> distinct files (with the same hardlink count, and you won't be able to
> find the other links to them -- oh well).  Can this cause data
> corruption?  Yes, but only if there are applications that rely on the
> different file names referencing the same file, and backup apps on the
> client won't get the hardlinks right either.

Well, this is why the hard links were made, no?
FWIW, I believe that rename of an open file might also produce this problem.


> 
> What I don't understand is why getting the fileid is so hard -- always
> GETATTR when you GETFH and you'll be fine.  I'm guessing that's not as
> difficult as it is to maintain a hash table of fileids.


The problem with NFS is that fileid isn't enough because the client doesn't
know about removes by other clients until it uses the stale filehandle.
Also, quite a few file systems are not keeping fileids unique (this triggered
this thread)
 
> 
> Nico
> --

