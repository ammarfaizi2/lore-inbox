Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263338AbUFBPoV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263338AbUFBPoV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 11:44:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263271AbUFBPnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 11:43:50 -0400
Received: from newpeace.netnation.com ([204.174.223.7]:10443 "EHLO
	peace.netnation.com") by vger.kernel.org with ESMTP id S263338AbUFBPlr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 11:41:47 -0400
Date: Wed, 2 Jun 2004 08:41:46 -0700
From: Simon Kirby <sim@netnation.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS client behavior on close
Message-ID: <20040602154146.GA2481@netnation.com>
References: <20040531213820.GA32572@netnation.com> <1086159327.10317.2.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1086159327.10317.2.camel@lade.trondhjem.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Trond,

On Tue, Jun 01, 2004 at 11:55:27PM -0700, Trond Myklebust wrote:

> P? m? , 31/05/2004 klokka 14:38, skreiv Simon Kirby:
> 
> > Is the NFS client required to write all data on close?
> 
> Yes. That is the basis of the NFSv2/v3 caching model...

In that case, is there any reason why we would ever want to wait
before sending data to the server, except for a minimal time to allow
merging into wsize blocks?  With no delay, avoiding the write to disk
for temporary files can still happen on the server side (async). 
Mass file writes from a single thread should be faster if the client
write buffering is minimized.

Perhaps there is no way to easily separate the NFS client case from
the normal page cache behavior?

Simon-
