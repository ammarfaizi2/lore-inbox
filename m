Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263496AbTJQSX2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 14:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263498AbTJQSX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 14:23:28 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:52743 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S263496AbTJQSXZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 14:23:25 -0400
Date: Fri, 17 Oct 2003 11:23:21 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: Transparent compression in the FS
Message-ID: <20031017182321.GB145@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <1066163449.4286.4.camel@Borogove> <20031015133305.GF24799@bitwizard.nl> <3F8D6417.8050409@pobox.com> <20031016162926.GF1663@velociraptor.random> <20031016172930.GA5653@work.bitmover.com> <20031016174927.GB25836@speare5-1-14> <20031016230448.GA29279@pegasys.ws> <20031017094443.GA7738@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031017094443.GA7738@elf.ucw.cz>
User-Agent: Mutt/1.3.27i
X-Message-Flag: Unauthorised duplication and storage of this email is a violation of international copyright law and is subject to prosecution.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 17, 2003 at 11:44:44AM +0200, Pavel Machek wrote:
> Hi!
> 
> > Several months ago we encountered the hash collision problem
> > with rsync.  This brought about a fair amount of discussion
> 
> So you found collision in something like md5 or sha1?

Each block was done with md4 truncated to 16 bits and
adler32.  The file as a whole is double checked with the
full 128 bit md4 and adler32.

The changes made were to improve block sizing to reduce the
number of blocks, and to scale the hash truncation according
to block count and size on a per-file basis.

The probability of false positives in rsync are orders of
magnitude smaller than they would be in a block hashing
filesystem.  Yet we were seeing it happen (with truncated
hash) at measurable rates on files as small as a few hundred
megabytes.  It was almost commonplace on iso images.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
