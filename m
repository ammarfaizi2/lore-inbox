Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264639AbUGSLUu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264639AbUGSLUu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 07:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265002AbUGSLUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 07:20:50 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:38302 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S264639AbUGSLUs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 07:20:48 -0400
Date: Mon, 19 Jul 2004 13:20:47 +0200
From: bert hubert <ahu@ds9a.nl>
To: Klaus Dittrich <kladit@t-online.de>
Cc: linux mailing-list <linux-kernel@vger.kernel.org>, gilbertd@treblig.org,
       nickpiggin@yahoo.com.au
Subject: dentry cache leak? Re: rsync out of memory 2.6.8-rc2
Message-ID: <20040719112047.GA14784@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Klaus Dittrich <kladit@t-online.de>,
	linux mailing-list <linux-kernel@vger.kernel.org>,
	gilbertd@treblig.org, nickpiggin@yahoo.com.au
References: <20040719091943.GA866@xeon2.local.here>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040719091943.GA866@xeon2.local.here>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 19, 2004 at 11:19:43AM +0200, Klaus Dittrich wrote:

> I found out I could trigger the memory outage using du -s /disc1 too.

Including crashing and/or running out of swap? That would indicate that the
dentry cache is not cleaning itself up, or that something is wrong with
reference counting.

Can you run 'cat fs/dentry-state' before and after the du -s? (assuming
there is an 'after'. Also, which fs is /disc1 on? any messages in dmesg?

dentry-state
------------

Status of  the  directory  cache.  Since  directory  entries  are
dynamically allocated and deallocated, this file indicates the current
status. It holds six values, in which the last two are not used and are
always zero. The others are listed in table 2-1.


Table 2-1: Status files of the directory cache 
..............................................................................
 File       Content                                                            
 nr_dentry  Almost always zero                                                 
 nr_unused  Number of unused cache entries                                     
 age_limit  
            in seconds after the entry may be reclaimed, when memory is
short 
 want_pages internally                                                         


-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
