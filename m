Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265257AbTF3QPc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 12:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265367AbTF3QPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 12:15:32 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30444 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265257AbTF3QPb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 12:15:31 -0400
Date: Mon, 30 Jun 2003 17:29:51 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Hans Reiser <reiser@namesys.com>
Cc: John Bradford <john@grabjohn.com>, jaharkes@cs.cmu.edu,
       linux-kernel@vger.kernel.org, mlmoser@comcast.net
Subject: Re: File System conversion -- ideas
Message-ID: <20030630162951.GO27348@parcelfarce.linux.theplanet.co.uk>
References: <200306300855.h5U8tNG2000475@81-2-122-30.bradfords.org.uk> <3F0004A9.8080402@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F0004A9.8080402@namesys.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 30, 2003 at 01:36:41PM +0400, Hans Reiser wrote:
> I tend to agree with the below.  I just want to add though that there 
> are a lot of users who have one disk drive and and no decent network 
> connection to somewhere with a lot of storage.  It would be nice to 
> adapt tar to understand about the reiser4 resizer and mkreiser4 and the 
> reiser3 resizer, and the partitioner (yah, at this point it would no 
> longer really be tar, but.... ), and to have it shrink the V3 partition, 
> create a reiser4 partition, copy some of the V3 partition to the V4 
> partition, shrink the V3 partition some more, etc.....
> 
> Money will get us to do this.  Otherwise we will work on what we are 
> contracted to do for DARPA.

*Ugh*.  If one really wants reiserfs v3 -> v4 conversion, presumably
there are much more intelligent ways to do that.  For one thing,
you really don't want to create an empty tree and move the stuff
from original node-by-node - that would give a shitload of IO on
tree rebalancing alone, not to mention the PITA it will be for allocator
(you get to reshuffle trees a lot on potentially almost full fs).
