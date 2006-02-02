Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751140AbWBBPRj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbWBBPRj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 10:17:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbWBBPRj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 10:17:39 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:65164 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S1751140AbWBBPRi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 10:17:38 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: Recursive chmod/chown OOM kills box with 32MB RAM
Date: Thu, 2 Feb 2006 17:17:04 +0200
User-Agent: KMail/1.8.2
Cc: Chris Mason <mason@suse.com>, Hans Reiser <reiser@namesys.com>,
       linux-kernel@vger.kernel.org,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>
References: <200601281613.16199.vda@ilport.com.ua> <200601300822.47821.mason@suse.com> <20060121232008.GA2697@ucw.cz>
In-Reply-To: <20060121232008.GA2697@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602021717.04429.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 22 January 2006 01:20, Pavel Machek wrote:
> > In the case of reiserfs, it might pin as much as the size of the journal at 
> > any time.  The default journal is 32MB, which is much too large for a system 
> > with only 32MB of ram.
> > 
> > You can shrink the log of an existing filesystem.  The minimum size is 513 
> > blocks, you might try 1024 as a good starting poing.
> > 
> > reiserfstune -s 1024 /dev/xxxx
> > 
> > The filesystem must be unmounted first.
> 
> Could we refuse to mount filesystem unless journal_size <
> physmem_size/2 or something like that?
> 
> I was not aware of this trap, and it seems unlikely that users know
> about it...

Maybe reiserfs code should use journal of reduced size on lowmem boxes.
Basically "reiserfstune -s 1024 /dev/xxxx" on-the-fly.
--
vda
