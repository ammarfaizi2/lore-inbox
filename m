Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319329AbSHOBdn>; Wed, 14 Aug 2002 21:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319330AbSHOBdn>; Wed, 14 Aug 2002 21:33:43 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:55802 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319329AbSHOBdm>; Wed, 14 Aug 2002 21:33:42 -0400
Subject: Re: Will NFSv4 be accepted?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dax Kelson <dax@gurulabs.com>
Cc: "Kendrick M. Smith" <kmsmith@umich.edu>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "nfs@lists.sourceforge.net" <nfs@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0208141926030.31203-100000@mooru.gurulabs.com>
References: <Pine.LNX.4.44.0208141926030.31203-100000@mooru.gurulabs.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 15 Aug 2002 02:35:27 +0100
Message-Id: <1029375327.28240.35.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-15 at 02:27, Dax Kelson wrote:
> On 15 Aug 2002, Alan Cox wrote:
> 
> > Thats not an NFS2 or NFS3 issue, thats an implementation matter. A
> > proper NFS credential system prevents that from occurring. You also have
> > to fix some bogon assumptions in our NFS client too I grant. 
> 
> Please, do tell.

Ok item #1 you authenticate with the server and get a cryptographic key
for use as credentials. This solves the bad client problem. Kerberos,
gssapi etc will do the job

Item #2 is a bug in our NFS page cache handling. Its not legal in NFS to
assume we can share caches between processes unless they have the same
NFS credentials for the query. The most we can do (and should do) is
that when we think we can reuse a cache entry we issue an NFS ACCESS
check for NFSv3 or for NFSv2 we write it back to the server if dirty
then issue a read for the new credential set.


