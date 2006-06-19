Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751070AbWFSQyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751070AbWFSQyi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 12:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751071AbWFSQyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 12:54:38 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:60878 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751070AbWFSQyi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 12:54:38 -0400
Date: Mon, 19 Jun 2006 09:54:22 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Theodore Tso <tytso@thunk.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH 0/8] Inode slimming
In-Reply-To: <20060619152003.830437000@candygram.thunk.org>
Message-ID: <Pine.LNX.4.64.0606190953180.21382@schroedinger.engr.sgi.com>
References: <20060619152003.830437000@candygram.thunk.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jun 2006, Theodore Tso wrote:

> What else remains to be done?  There are a large number of fields in
> struct inode which are never populated unless the inode is open, and
> those should get moved into another structure which is populated only
> when needed.  There are a large number of inodes which are read into
> memory only because stat(2) was called on them (thanks to things like
> color ls, et. al).  

One could remove the reclaim list and use the slab lists of the slab 
allocator to scan through the inodes and reclaim them in such a way
that would maximize the number of pages freed. I will post an RFC on that 
one later. This may reduce the complexity of inode reclaim.

